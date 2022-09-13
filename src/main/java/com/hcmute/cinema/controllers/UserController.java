package com.hcmute.cinema.controllers;

import com.hcmute.cinema.services.user.IUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RequiredArgsConstructor
@Controller
@RequestMapping("/user")
public class UserController {
    private final IUserService userService;

    @GetMapping("/profile")
    public String showProfile(HttpServletRequest request, HttpServletResponse response){
        return userService.profile(request,response);
    }
    @PostMapping("/update/{id}")
    public String update(ModelMap modelMap, HttpServletRequest request, @PathVariable int id){
        return userService.update(modelMap, request,id);
    }
}
