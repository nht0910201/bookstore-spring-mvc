package com.hcmute.bookstore.controllers;

import com.hcmute.bookstore.services.order.IOrderService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@AllArgsConstructor
@Controller
@RequestMapping("/order")
public class OrderController {
    private final IOrderService orderService;
    @GetMapping(value = "/user/{id}")
    public String showOrder(HttpServletRequest request, @PathVariable int id){
        return orderService.showOrder(request,id);
    }
    @GetMapping(value = "/{id}")
    public String getOrder (HttpServletRequest request,HttpServletResponse response,@PathVariable int id) throws IOException{
        return orderService.getOrder(request, response, id);
    }
    @GetMapping(value = "/makeOrder/{id}")
    public String makeOrder(HttpServletRequest request, HttpServletResponse response, @PathVariable int id){
        return orderService.makeOrder(request,response,id);
    }
    @PostMapping(value = "/completeOrder/{id}")
    public String completeOrder(HttpServletRequest request, HttpServletResponse response, @PathVariable int id) throws IOException {
        return orderService.completeOrder(request,response,id);
    }
    @GetMapping(value = "/done/{id}")
    public void doneOrder(HttpServletRequest request, HttpServletResponse response,@PathVariable int id)throws IOException{
        orderService.doneOrder(request,response,id);
    }
    @GetMapping(value = "/cancel/{id}")
    public void cancelOrder(HttpServletRequest request, HttpServletResponse response,@PathVariable int id)throws IOException{
        orderService.cancelOrder(request,response,id);
    }
}

