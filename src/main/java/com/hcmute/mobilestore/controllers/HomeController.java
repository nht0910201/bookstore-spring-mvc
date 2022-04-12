package com.hcmute.mobilestore.controllers;

import com.hcmute.mobilestore.models.Supplier;
import com.hcmute.mobilestore.repository.SupplierRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(path = "")
public class HomeController {
    @Autowired
    private SupplierRepository supplierRepository;
    @GetMapping(path = "/home")
    public String showHomePage(ModelMap modelMap) {
        return "viewHome/Index";
    }
}
