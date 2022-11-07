package com.hcmute.bookstore.controllers;

import com.hcmute.bookstore.services.product.IProductService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;

@AllArgsConstructor
@RequestMapping("/search")
@Controller
public class SearchController {
    private final IProductService productService;

    @GetMapping("/query")
    public String search(HttpServletRequest request, @RequestParam(name = "search") String search){
        return productService.search(request,search);
    }
}
