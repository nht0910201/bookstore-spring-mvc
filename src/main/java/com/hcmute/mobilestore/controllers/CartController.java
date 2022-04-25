package com.hcmute.mobilestore.controllers;

import com.hcmute.mobilestore.models.Bill;
import com.hcmute.mobilestore.models.Cart;
import com.hcmute.mobilestore.models.Product;
import com.hcmute.mobilestore.repository.BillRepository;
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
@RequestMapping(path = "/Cart")
public class CartController {
    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private CartRepository cartRepository;
    @Autowired
    private BillRepository billRepository;
    @GetMapping(value = "")
    public String showCart(ModelMap modelMap, HttpServletRequest request) {
        int Acc_id=Integer.parseInt(request.getParameter("acc_id"),10);
        Optional<Bill> bill = billRepository.isUserHasCart(Acc_id);
        if(bill.isPresent()) {
            List<Cart> cart = cartRepository.findCartById(Acc_id, bill.get().getId());
            modelMap.addAttribute("carts", cart);
            return "viewCart/Cart";
        }
        else{
            return "viewHome/Index";
        }
    }
    @GetMapping(value = "/DeleteCart")
    public void deleteCart(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) throws IOException {
        int Pro_id=Integer.parseInt(request.getParameter("pro_id"));
        int Acc_id=Integer.parseInt(request.getParameter("acc_id"));
        Optional<Cart> cart = cartRepository.findProductInCartById(Pro_id,Acc_id);
        cartRepository.delete(cart.get());
        boolean isAvailable = cartRepository.findProductInCartById(Pro_id,Acc_id).isPresent();
        if (isAvailable)
        {
            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            out.print(false);
            out.flush();
        }else{
            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            out.print(true);
            out.flush();
        }

    }

}
