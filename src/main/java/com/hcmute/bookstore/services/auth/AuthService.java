package com.hcmute.bookstore.services.auth;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.hcmute.bookstore.Config.Constant;
import com.hcmute.bookstore.models.User;
import com.hcmute.bookstore.repository.UserRepository;
import com.hcmute.bookstore.utils.MailUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class AuthService implements IAuthService {
    private final UserRepository userRepository;

    @Override
    public String showLoginPage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        boolean checkAuth = (boolean) session.getAttribute("auth");
        if(checkAuth){
            return "redirect:/Home";
        }else{
            return "viewAuth/Login";
        }
    }

    @Override
    public String login(ModelMap modelMap, HttpServletRequest request) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Optional<User> user = userRepository.findUserByEmail(email);
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

    @Override
    public String showRegisterPage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        boolean checkAuth = (boolean) session.getAttribute("auth");
        if(checkAuth){
            return "redirect:/Home";
        }else{
            return "viewAuth/Register";
        }
    }

    @Override
    public String register(ModelMap modelMap, HttpServletRequest request) {
        String password = request.getParameter("password");
        String rawPassword = BCrypt.withDefaults().hashToString(12, password.toCharArray());
        String strDob = request.getParameter("dob") + " 00:00";
        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        LocalDateTime dob = LocalDateTime.parse(strDob, df);
        String phone_number = request.getParameter("phone");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        Optional<User> user1 = (userRepository.findUserByEmail(email));
        if (user1.isPresent()) {
            modelMap.addAttribute("hasError", true);
            modelMap.addAttribute("errorMessage", "Email already exist");
            return "viewAuth/Register";
        } else {
            Optional<User> user2 = userRepository.findUserByPhone(phone_number);
            if (user2.isPresent()) {
                modelMap.addAttribute("hasError", true);
                modelMap.addAttribute("errorMessage", "Phone number already exist");
                return "viewAuth/Register";
            } else {
                try {
                    User newUser = new User(name, email, rawPassword, dob, phone_number, Constant.ROLE_CUSTOMER, Constant.ACTIVE);
                    userRepository.save(newUser);

                    return "redirect:/auth/login";
                } catch (Exception e) {
                    modelMap.addAttribute("hasError", true);
                    modelMap.addAttribute("Message", e);
                    return "viewAuth/Register";
                }
            }
        }
    }

    @Override
    public String resetPass(HttpServletRequest request) {
        HttpSession session = request.getSession();
        boolean checkAuth = (boolean) session.getAttribute("auth");
        if(checkAuth){
            return "redirect:/Home";
        }else{
            return "viewAuth/ResetPassword";
        }
    }

    @Override
    public String updatePass(HttpServletRequest request, HttpServletResponse response) throws MessagingException {
        String email = request.getParameter("email");
        Optional<User> user = userRepository.findUserByEmail(email);
        if (user.isEmpty()){
            request.setAttribute("hasError", true);
            request.setAttribute("errorMessage", "Cannot find account with email");
            return "viewAuth/ResetPassword";
        }else{
            String pass = "123456abc.";
            String newPass =BCrypt.withDefaults().hashToString(12, pass.toCharArray());
            user.get().setPassword(newPass);
            userRepository.save(user.get());
            MailUtils.sendPassword(email,pass);
            request.setAttribute("hasNotify", true);
            request.setAttribute("successMessage", "New password has been sent to your email. Please check email and log in again");
            return "viewAuth/ResetPassword";
        }
    }

    @Override
    public void sendOTP(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String otp = request.getParameter("otp");
        boolean sendOTP = MailUtils.sendOTP(email, otp);
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");
        out.print(sendOTP);
        out.flush();
    }

    @Override
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.setAttribute("auth", false);
        session.setAttribute("authUser", new User());
        return "redirect:/Home";
    }
}
