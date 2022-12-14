package com.hcmute.bookstore.controllers;


import com.hcmute.bookstore.services.auth.IAuthService;
import com.hcmute.bookstore.repository.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@AllArgsConstructor
@Controller
@RequestMapping("/auth")
public class AuthController {
    private final IAuthService authService;
    @Autowired
    UserRepository userRepository;
    @GetMapping("/login")
    public String showLogin(HttpServletRequest request){
        return authService.showLoginPage(request);
    }
    @PostMapping("/login")
    public String login(ModelMap modelMap, HttpServletRequest request){
        return authService.login(modelMap,request);
    }
    @PostMapping(value = "/logout")
    public String logout(HttpServletRequest request) {
        return authService.logout(request);
    }
    @GetMapping("/register")
    public String showRegister(HttpServletRequest request){
        return authService.showRegisterPage(request);
    }
    @PostMapping(value = "/register")
    public String register(ModelMap modelMap, HttpServletRequest request) {
        return authService.register(modelMap,request);
    }
    @GetMapping("/resetPassword")
    public String resetPass(HttpServletRequest request){
       return authService.resetPass(request);
    }
    @PostMapping("/updatePass")
    public String updatePass (HttpServletRequest request,HttpServletResponse response) throws MessagingException {
        return authService.updatePass(request,response);
    }
    @GetMapping("/sendOTP")
    public void sendOTP(HttpServletRequest request, HttpServletResponse response) throws IOException{
        authService.sendOTP(request, response);
    }
}
