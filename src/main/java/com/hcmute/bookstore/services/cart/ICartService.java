package com.hcmute.bookstore.services.cart;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public interface ICartService {
    String showCart(HttpServletRequest request,int id);
    void addToCart(HttpServletRequest request, HttpServletResponse response) throws IOException;
    void updateItem(HttpServletRequest request, HttpServletResponse response,int id) throws IOException;
    void deleteItem(HttpServletRequest request, HttpServletResponse response) throws IOException;
}
