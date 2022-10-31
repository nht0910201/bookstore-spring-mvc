package com.hcmute.bookstore.services.order;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public interface IOrderService {
    String makeOrder(HttpServletRequest request, HttpServletResponse response,int id);
    String completeOrder(HttpServletRequest request,HttpServletResponse response,int id) throws IOException;
    String showOrder(HttpServletRequest request,int id);
    String getOrder(HttpServletRequest request,HttpServletResponse response,int id) throws IOException;
    void doneOrder(HttpServletRequest request, HttpServletResponse response,int id) throws IOException;
    void cancelOrder(HttpServletRequest request, HttpServletResponse response,int id) throws IOException;
}
