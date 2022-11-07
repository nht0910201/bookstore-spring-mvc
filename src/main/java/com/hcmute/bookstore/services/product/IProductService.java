package com.hcmute.bookstore.services.product;

import org.springframework.web.bind.annotation.PathVariable;

import javax.servlet.http.HttpServletRequest;

public interface IProductService {
    String detailProduct(HttpServletRequest request, int id);
    String listProduct(HttpServletRequest request, int id);
    String search (HttpServletRequest request,String search);
}
