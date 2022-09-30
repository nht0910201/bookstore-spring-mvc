package com.hcmute.bookstore.controllers;

import com.hcmute.bookstore.models.Product;
import com.hcmute.bookstore.services.admin.IAdminService;
import lombok.AllArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@AllArgsConstructor
@Controller
@RequestMapping("/admin")
public class AdminController {
    private final IAdminService adminService;
    @GetMapping("/manage")
    public String showManagePage(HttpServletRequest request){
        return adminService.showManagePage(request);
    }
    @GetMapping("/add_product")
    public String showAddProduct(HttpServletRequest request, Model model){
        return adminService.showAddProduct(request,model);
    }
    @PostMapping(value = "/add_product", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public String addProduct(@ModelAttribute(value = "product") Product product, HttpServletRequest request) throws IOException, ServletException {
        return adminService.addProduct(product,request);
    }
}
