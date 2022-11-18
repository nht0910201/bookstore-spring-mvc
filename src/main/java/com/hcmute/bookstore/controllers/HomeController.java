package com.hcmute.bookstore.controllers;

import com.hcmute.bookstore.services.home.IHomeService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@AllArgsConstructor
@Controller
@RequestMapping(path = "")
public class HomeController {
    private final IHomeService homeService;
    @GetMapping(path = "/Home")
    public String showHomePage(ModelMap modelMap) {
        return homeService.showHomePage(modelMap);
    }
}

