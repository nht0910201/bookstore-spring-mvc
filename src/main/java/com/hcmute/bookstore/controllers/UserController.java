package com.hcmute.bookstore.controllers;

import com.hcmute.bookstore.services.user.IUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
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
    @GetMapping("/changePass")
    public String changePass(HttpServletRequest request,HttpServletResponse response){
        return userService.showChangePass(request,response);
    }
    @PostMapping("/changePass/{id}")
    public String updatePass(HttpServletRequest request, HttpServletResponse response,@PathVariable int id){
        return userService.changePass(request,response,id);
    }
}
