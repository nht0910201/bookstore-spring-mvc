package com.hcmute.mobilestore.controllers;

import com.hcmute.mobilestore.models.Product;
import com.hcmute.mobilestore.models.Shopping_Cart;
import com.hcmute.mobilestore.models.Cart_Item;
import com.hcmute.mobilestore.repository.ShoppingCartRepository;
import com.hcmute.mobilestore.repository.CartItemRepository;
import com.hcmute.mobilestore.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
    private CartItemRepository cartItemRepository;
    @Autowired
    private ShoppingCartRepository shoppingCartRepository;
    @GetMapping(value = "")
    public String showCart(ModelMap modelMap, HttpServletRequest request) {
        int Acc_id=Integer.parseInt(request.getParameter("acc_id"),10);
        Optional<Shopping_Cart> bill = shoppingCartRepository.isUserHasCart(Acc_id);
        if(bill.isPresent()) {
            List<Cart_Item> cartItem = cartItemRepository.findCartById(bill.get().getId());
            modelMap.addAttribute("carts", cartItem);
            return "viewCart/Cart";
        }
        else{
            Shopping_Cart shoppingCart = new Shopping_Cart("incomplete",Acc_id,0);
            shoppingCartRepository.save(shoppingCart);
            return "viewHome/Index";
        }
    }
    @GetMapping(value = "/DeleteCart")
    public void deleteCart(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) throws IOException {
        int Pro_id=Integer.parseInt(request.getParameter("pro_id"));
        int Acc_id=Integer.parseInt(request.getParameter("acc_id"));
        Optional<Cart_Item> cart = cartItemRepository.findProductInCartById(Pro_id,Acc_id);
        cartItemRepository.delete(cart.get());
        boolean isAvailable = cartItemRepository.findProductInCartById(Pro_id,Acc_id).isPresent();
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
    @PostMapping(value = "/ProcessCart")
    public String ProcessCart(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response) throws IOException
    {

        int order_id=Integer.parseInt(request.getParameter("orderid"));
        List<Cart_Item> cartItems = cartItemRepository.findCartById(order_id);

        double total=0;
        int pro_id;
        for (Cart_Item cartItem : cartItems) {
            total+= cartItem.getPrice()* cartItem.getQuantity();
            pro_id = cartItem.getPro_id();
            Optional<Product> product = productRepository.findById(pro_id);
            product.get().setQuantity( product.get().getQuantity() -1 );
            productRepository.save(product.get());
        }


        Optional<Shopping_Cart> shopping_cart = shoppingCartRepository.findById(order_id);
        shopping_cart.get().setTotal_price(total);
        shopping_cart.get().setStatus("complete");
        shoppingCartRepository.save(shopping_cart.get());
        return "redirect:/Home";
    }

}
