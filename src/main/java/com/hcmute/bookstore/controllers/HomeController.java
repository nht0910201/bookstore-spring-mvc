package com.hcmute.bookstore.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(path = "")
public class HomeController {
    @GetMapping(path = "/Home")
    public String showHomePage(ModelMap modelMap) {
        return "viewHome/Index";
    }
    @GetMapping(path = "/404")
    public String showErrorPage() {
        return "404";
    }
    @GetMapping(path = "/204")
    public String showOtherPage() {
        return "204";
    }
}

