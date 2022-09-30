package com.hcmute.bookstore.services.admin;

import com.hcmute.bookstore.models.Product;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

public interface IAdminService {
    String showManagePage(HttpServletRequest request);
    String showAddProduct(HttpServletRequest request, Model moddel);
    String addProduct(Product product, HttpServletRequest request) throws IOException, ServletException;
}
