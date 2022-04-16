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
import java.util.Optional;

@Controller
@RequestMapping(path = "/Product")
public class ProductController {
    @Autowired
    private ProductRepository productRepository;
    private CartRepository cartRepository;
    @GetMapping(value = "/Detail")
    public String detailProduct(ModelMap modelMap, HttpServletRequest request) {
        int Pro_id = Integer.parseInt(request.getParameter("pro_id"));
        Optional<Product> product=productRepository.findById(Pro_id);
        request.setAttribute("product",product.get());
        return "viewProduct/Detail";
    }
    @GetMapping(value = "/AddToCart")
    public String addToCart(ModelMap modelMap,HttpServletRequest request,HttpServletResponse response) throws IOException {
        int Pro_id = Integer.parseInt(request.getParameter("pro_id"));
        String Pro_name = request.getParameter("pro_name");
        double Price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int Acc_id=Integer.parseInt(request.getParameter("acc_id"));
        //Optional<Product> product=productRepository.findById(Pro_id);
        Cart cart = cartRepository.findProductInCartById(Pro_id,Acc_id);
        if (cart==null)
        {
            Cart newCart = new Cart(Pro_id,Pro_name,Price,quantity,1);
            cartRepository.save(newCart);
            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            out.print(true);
            out.flush();
        }
        else
        {
            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            out.print(false);
            out.flush();
        }
        return "viewProduct/Detail";
    }
}
