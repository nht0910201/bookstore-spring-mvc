package com.hcmute.mobilestore.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(path = "")
public class HomeController {

    @GetMapping(path = "/home")
    public String showHomePage(ModelMap modelMap) {
        return "viewHome/Index";
    }
}
