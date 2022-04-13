package com.hcmute.mobilestore.controllers;

import com.hcmute.mobilestore.models.Product;
import com.hcmute.mobilestore.repository.ProductRepository;
import com.hcmute.mobilestore.repository.SupplierRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(path = "")
public class HomeController {
    @Autowired
    private ProductRepository productRepository;
    @GetMapping(path = "/Home")
    public String showHomePage(ModelMap modelMap) {
        Iterable<Product> products=productRepository.findAll();
        modelMap.addAttribute("products",products);
        return "viewHome/Index";
    }
}
