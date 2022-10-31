package com.hcmute.bookstore.controllers;

import com.hcmute.bookstore.services.cart.ICartService;
import com.hcmute.bookstore.services.product.IProductService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Optional;

@AllArgsConstructor
@RequestMapping("/cart")
@Controller
public class CartController {
    private final ICartService cartService;
    @GetMapping("/{id}")
    public String showCart(HttpServletRequest request,@PathVariable int id){
        return cartService.showCart(request,id);
    }
    @GetMapping(value = "/addToCart")
    public void addToCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
         cartService.addToCart(request,response);
    }
    @GetMapping(value = "/updateItem/{id}")
    public void updateItem(HttpServletRequest request, HttpServletResponse response,@PathVariable int id)throws IOException {
        cartService.updateItem(request,response,id);
    }
    @GetMapping(value = "/deleteItem")
    public void deleteItem(HttpServletRequest request, HttpServletResponse response) throws IOException{
        cartService.deleteItem(request,response);
    }
}
