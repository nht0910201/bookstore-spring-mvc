package com.hcmute.bookstore.controllers;

import com.hcmute.bookstore.services.product.IProductService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@AllArgsConstructor
@RequestMapping("/product")
@Controller
public class ProductController {
    private final IProductService productService;

    @GetMapping("/{id}")
    public String detail(HttpServletRequest request, @PathVariable int id){
        return productService.detailProduct(request,id);
    }
    @GetMapping("/category/{id}")
    public String listProduct(HttpServletRequest request,@PathVariable int id){
        return productService.listProduct(request,id);
    }
}
