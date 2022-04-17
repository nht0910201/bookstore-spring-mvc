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
import java.math.BigDecimal;
import java.util.Optional;

@Controller
@RequestMapping(path = "/Product")
public class ProductController {
    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private CartRepository cartRepository;
    @GetMapping(value = "/Detail")
    public String detailProduct(ModelMap modelMap, HttpServletRequest request) {
        int Pro_id = Integer.parseInt(request.getParameter("pro_id"));
        Optional<Product> product=productRepository.findById(Pro_id);
        request.setAttribute("product",product.get());
        return "viewProduct/Detail";
    }
    @GetMapping(value = "/AddToCart")
    public void addToCart(ModelMap modelMap,HttpServletRequest request,HttpServletResponse response) throws IOException {
        int Pro_id = Integer.parseInt(request.getParameter("pro_id"),10);
        String Pro_name = request.getParameter("pro_name");
        Double Price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"),10);
        int Acc_id=Integer.parseInt(request.getParameter("acc_id"),10);
        Optional<Cart> cart = cartRepository.findProductInCartById(Pro_id,Acc_id);
        if (cart.isPresent())
        {
            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            out.print(false);
            out.flush();
        }
        else
        {
            Cart newCart = new Cart(Pro_id,Pro_name,Price,quantity,Acc_id, 1);
            cartRepository.save(newCart);
            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            out.print(true);
            out.flush();
        }
    }
}
