package com.hcmute.bookstore.services.auth;

import org.springframework.ui.ModelMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public interface IAuthService {
    String login(ModelMap modelMap, HttpServletRequest request);
    String register(ModelMap modelMap, HttpServletRequest request);
    void sendOTP(HttpServletRequest request, HttpServletResponse response) throws IOException;
    String logout(HttpServletRequest request);
}
