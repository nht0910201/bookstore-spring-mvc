package com.hcmute.mobilestore.controllers;

import com.hcmute.mobilestore.models.Cart;
import com.hcmute.mobilestore.models.Product;
import com.hcmute.mobilestore.repository.CartRepository;
import com.hcmute.mobilestore.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping(path = "")
public class SearchController {
    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private CartRepository cartRepository;
    @GetMapping(value = "/Search")
    public String searchProduct(ModelMap modelMap, HttpServletRequest request) {
        String query = request.getParameter("search");
        List<Product> product=productRepository.searchProduct(query);
        request.setAttribute("products",product);
        return "viewSearch/Search";
    }
    @GetMapping(value = "/Search/SortDecPrice")
    public String sortDecPrice(ModelMap modelMap, HttpServletRequest request) {
        String query = request.getParameter("search");
        List<Product> product=productRepository.sortDecPrice(query);
        request.setAttribute("products",product);
        return "viewSearch/Search";
    }
    @GetMapping(value = "/Search/SortIncPrice")
    public String sortIncPrice(ModelMap modelMap, HttpServletRequest request) {
        String query = request.getParameter("search");
        List<Product> product=productRepository.sortIncPrice(query);
        request.setAttribute("products",product);
        return "viewSearch/Search";
    }

}
