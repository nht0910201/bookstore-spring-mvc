package com.hcmute.bookstore.services.user;

import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface IUserService {
    String profile(HttpServletRequest request, HttpServletResponse response);
    String update(ModelMap modelMap, HttpServletRequest request, int id);
}
