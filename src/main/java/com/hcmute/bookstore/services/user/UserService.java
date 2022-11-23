package com.hcmute.bookstore.services.user;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.hcmute.bookstore.Config.Constant;
import com.hcmute.bookstore.models.User;
import com.hcmute.bookstore.repository.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Optional;

@AllArgsConstructor
@Service
public class UserService implements IUserService{
    private final UserRepository userRepository;
    @Override
    public String profile(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        boolean checkAuth = (boolean) session.getAttribute("auth");
        String roleAuth = (String) session.getAttribute("role");
        if (checkAuth && roleAuth.equals(Constant.ROLE_CUSTOMER)) {
            return "viewAccount/Profile";
        } else {
            return "redirect:/Home";
        }
    }
    @Override
    public String update(ModelMap modelMap, HttpServletRequest request,int id) {
        Optional<User> user = userRepository.findUserByID(id);
        String strDob = request.getParameter("dob") + " 00:00";
        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        LocalDateTime dob = LocalDateTime.parse(strDob, df);
        String phone_number = request.getParameter("phone");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        if(user.get().getPhone().equals(phone_number) ) {
            if(user.get().getEmail().equals(email)){
                try {
                    user.get().setDob(dob);
                    user.get().setName(name);
                    user.get().setPhone(phone_number);
                    user.get().setEmail(email);
                    userRepository.save(user.get());
                    HttpSession session = request.getSession();
                    session.setAttribute("authUser", user.get());
                    return "redirect:/user/profile";
                } catch (Exception e) {
                    modelMap.addAttribute("hasError", true);
                    modelMap.addAttribute("Message", e);
                    return "viewAccount/Profile";
                }
            }
            else{
                Optional<User> user2 = userRepository.findUserByEmail(email);
                if (user2.isPresent()) {
                    modelMap.addAttribute("hasError", true);
                    modelMap.addAttribute("errorMessage", "Email already exist");
                    return "viewAccount/Profile";
                } else {
                    try {
                        user.get().setDob(dob);
                        user.get().setName(name);
                        user.get().setPhone(phone_number);
                        user.get().setEmail(email);
                        userRepository.save(user.get());
                        HttpSession session = request.getSession();
                        session.setAttribute("authUser", user.get());
                        return "redirect:/user/profile";
                    } catch (Exception e) {
                        modelMap.addAttribute("hasError", true);
                        modelMap.addAttribute("Message", e);
                        return "viewAccount/Profile";
                    }
                }
            }
        }else{
            Optional<User> user1= userRepository.findUserByPhone(phone_number);
            if (user1.isPresent()) {
                modelMap.addAttribute("hasError", true);
                modelMap.addAttribute("errorMessage", "Phone number already exist");
                return "viewAccount/Profile";
            } else {
                if(user.get().getEmail().equals(email)){
                    try {
                        user.get().setDob(dob);
                        user.get().setName(name);
                        user.get().setPhone(phone_number);
                        user.get().setEmail(email);
                        userRepository.save(user.get());
                        HttpSession session = request.getSession();
                        session.setAttribute("authUser", user.get());
                        return "redirect:/user/profile";
                    } catch (Exception e) {
                        modelMap.addAttribute("hasError", true);
                        modelMap.addAttribute("Message", e);
                        return "viewAccount/Profile";
                    }
                }else{
                    Optional<User> user2 = userRepository.findUserByEmail(email);
                    if (user2.isPresent()) {
                        modelMap.addAttribute("hasError", true);
                        modelMap.addAttribute("errorMessage", "Email already exist");
                        return "viewAccount/Profile";
                    } else {
                        try {
                            user.get().setDob(dob);
                            user.get().setName(name);
                            user.get().setPhone(phone_number);
                            user.get().setEmail(email);
                            userRepository.save(user.get());
                            HttpSession session = request.getSession();
                            session.setAttribute("authUser", user.get());
                            return "redirect:/user/profile";
                        } catch (Exception e) {
                            modelMap.addAttribute("hasError", true);
                            modelMap.addAttribute("Message", e);
                            return "viewAccount/Profile";
                        }
                    }
                }
            }
        }
    }

    @Override
    public String showChangePass(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        boolean checkAuth = (boolean) session.getAttribute("auth");
        String roleAuth = (String) session.getAttribute("role");
        if (checkAuth && roleAuth.equals(Constant.ROLE_CUSTOMER)) {
            return "viewAccount/ChangePass";
        } else {
            return "redirect:/Home";
        }
    }

    @Override
    public String changePass(HttpServletRequest request, HttpServletResponse response, int id) {
        Optional<User> user = userRepository.findUserByID(id);
        if(user.isPresent()){
            String oldPass = request.getParameter("oldPass");
            BCrypt.Result result = BCrypt.verifyer().verify(oldPass.toCharArray(), user.get().getPassword());
            if(result.verified){
                String newPass = request.getParameter("newPass");
                String raw = BCrypt.withDefaults().hashToString(12, newPass.toCharArray());
                user.get().setPassword(raw);
                userRepository.save(user.get());
                HttpSession session = request.getSession();
                session.setAttribute("auth", false);
                session.setAttribute("authUser", new User());
                return "redirect:/auth/login";
            }else{
                request.setAttribute("hasError", true);
                request.setAttribute("errorMessage", "Old Password incorrect");
                return "viewAccount/ChangePass";
            }
        }else{
            return "204";
        }
    }
}
