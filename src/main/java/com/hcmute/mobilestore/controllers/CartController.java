package com.hcmute.mobilestore.controllers;

import com.hcmute.mobilestore.models.Product;
import com.hcmute.mobilestore.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.Optional;

@Controller
@RequestMapping(path = "/Cart")
public class CartController {
    @Autowired
    private ProductRepository productRepository;
    @GetMapping(value = "")
    public String detailProduct(ModelMap modelMap, HttpServletRequest request) {
        return "viewCart/Cart";
    }

}
