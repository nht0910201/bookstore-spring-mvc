package com.hcmute.mobilestore.controllers;

import com.hcmute.mobilestore.models.Product;
import com.hcmute.mobilestore.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Optional;

@Controller
@RequestMapping(path = "/Product")
public class ProductController {
    @Autowired
    private ProductRepository productRepository;
    @GetMapping(value = "/Detail")
    public String detailProduct(ModelMap modelMap, HttpServletRequest request) {
        int Pro_id = Integer.parseInt(request.getParameter("pro_id"));
        Optional<Product> product=productRepository.findById(Pro_id);
        request.setAttribute("product",product.get());
        return "viewProduct/Detail";
    }

}
