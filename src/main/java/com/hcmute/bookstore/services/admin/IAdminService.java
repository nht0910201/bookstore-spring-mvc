package com.hcmute.bookstore.services.admin;

import com.hcmute.bookstore.models.Product;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

public interface IAdminService {
    String showManagePage(HttpServletRequest request);
    String showAddProduct(HttpServletRequest request, Model model);
    String addProduct(Product product, HttpServletRequest request) throws IOException, ServletException;
    String showUpdateProduct(ModelMap modelMap, HttpServletRequest request ,Model moddel, int id);
    String updateProduct(Model model,Product product, HttpServletRequest request,int id) throws IOException, ServletException;
    void deleteProduct(HttpServletRequest request, HttpServletResponse response, int id) throws IOException;
    String showAddUser(HttpServletRequest request);
    String addUser(HttpServletRequest request) throws MessagingException;
    String showUpdateUser(HttpServletRequest request,int id);
    String updateUser(HttpServletRequest request,int id);
    void deleteUser(HttpServletRequest request,HttpServletResponse response,int id) throws IOException;
    String showAddCategory(HttpServletRequest request);
    String addCategory(HttpServletRequest request);
    String showUpdateCategory(HttpServletRequest request,int id);
    String updateCategory(HttpServletRequest request,int id);
    void deleteCategory(HttpServletRequest request, HttpServletResponse response, int id) throws IOException;
}
