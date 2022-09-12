package com.hcmute.cinema.controllers;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.hcmute.cinema.Config.Constant;
import com.hcmute.cinema.Utils.MailUtils;
import com.hcmute.cinema.models.User;
import com.hcmute.cinema.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Optional;

@Controller
@RequestMapping("/auth")
public class AuthController {
    @Autowired
    UserRepository userRepository;
    @GetMapping("/login")
    public String showLogin(){
        return "viewAuth/Login";
    }
    @PostMapping("/login")
    public String login(ModelMap modelMap, HttpServletRequest request) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Optional<User> user = userRepository.findByEmail(email);
        if (user.isPresent()) {
            BCrypt.Result result = BCrypt.verifyer().verify(password.toCharArray(), user.get().getPassword());
            if (result.verified) {
                HttpSession session = request.getSession();
                session.setAttribute("auth", true);
                session.setAttribute("authUser", userRepository.findById(user.get().getId()).get());
                session.setAttribute("role", user.get().getRole());
                return "redirect:/Home";
            } else {
                modelMap.addAttribute("hasError", true);
                modelMap.addAttribute("errorMessage", "Incorrect Email or Password");
                return "viewAuth/Login";
            }
        } else {
            modelMap.addAttribute("hasError", true);
            modelMap.addAttribute("errorMessage", "Incorrect Email or Password");
            return "viewAuth/Login";
        }
    }
    @PostMapping(value = "/logout")
    public String logout(ModelMap modelMap, HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.setAttribute("auth", false);
        session.setAttribute("authUser", new User());
        return "redirect:/Home";
    }
    @GetMapping("/register")
    public String showRegister(){
        return "viewAuth/Register";
    }
    @GetMapping(value = "/existEmail")
    public void emailChecking(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("email");
        Optional<User> user = Optional.of(userRepository.findByEmail(username).get());
        boolean isAvailable = (user == null);

        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");
        // Send JSON data. if email exists JSON data will be true.
        out.print(isAvailable);
        out.flush();
    }
    @PostMapping(value = "/register")
    public String register(ModelMap modelMap, HttpServletRequest request) {
        String password = request.getParameter("password");
        String rawPassword = BCrypt.withDefaults().hashToString(12, password.toCharArray());
        String strDob = request.getParameter("dob") + " 00:00";
        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        LocalDateTime dob = LocalDateTime.parse(strDob, df);
        String phone_number = request.getParameter("phone");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        Optional<User> user = (userRepository.findByEmail(email));
        if(user.isPresent()){
            modelMap.addAttribute("hasError", true);
            modelMap.addAttribute("errorMessage", "Email already Exist");
            return "viewAuth/Register";
        }
        else{
            try {
                User newUser = new User(name, email,rawPassword,dob,phone_number, Constant.ROLE_CUSTOMER,Constant.ACTIVE);
                userRepository.save(newUser);
//                modelMap.addAttribute("hasNotify", true);
//                modelMap.addAttribute("Message", "Sign Up Successfully");
                return "redirect:/auth/login";
            } catch (Exception e) {
                modelMap.addAttribute("hasError", true);
                modelMap.addAttribute("Message", e);
                return "viewAuth/Register";
            }
        }
    }
    @GetMapping("/sendOTP")
    public void sendOTP(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) throws IOException{
        String username = request.getParameter("email");
        String otp = request.getParameter("otp");
        boolean sendOTP =  MailUtils.sendOTP(username,otp);
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");
        out.print(sendOTP);
        out.flush();
    }
}
