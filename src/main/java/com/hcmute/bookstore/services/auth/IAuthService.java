package com.hcmute.bookstore.services.auth;

import org.springframework.ui.ModelMap;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public interface IAuthService {
    String showLoginPage(HttpServletRequest request);
    String login(ModelMap modelMap, HttpServletRequest request);
    String showRegisterPage(HttpServletRequest request);
    String register(ModelMap modelMap, HttpServletRequest request);
    String resetPass(HttpServletRequest request);
    String updatePass(HttpServletRequest request,HttpServletResponse response) throws MessagingException;
    void sendOTP(HttpServletRequest request, HttpServletResponse response) throws IOException;
    String logout(HttpServletRequest request);
}
