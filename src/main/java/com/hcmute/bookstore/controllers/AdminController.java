package com.hcmute.bookstore.controllers;

import com.hcmute.bookstore.models.Product;
import com.hcmute.bookstore.services.admin.IAdminService;
import lombok.AllArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@AllArgsConstructor
@Controller
@RequestMapping("/admin")
public class AdminController {
    private final IAdminService adminService;
    @GetMapping("/manage")
    public String showManagePage(HttpServletRequest request){
        return adminService.showManagePage(request);
    }
    @GetMapping("/add_product")
    public String showAddProduct(HttpServletRequest request, Model model){
        return adminService.showAddProduct(request,model);
    }
    @PostMapping(value = "/add_product", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public String addProduct(@ModelAttribute(value = "product") Product product, HttpServletRequest request) throws IOException, ServletException {
        return adminService.addProduct(product,request);
    }
    @GetMapping("/update_product/{id}")
    public String showUpdateProduct(ModelMap modelMap, HttpServletRequest request ,Model model, @PathVariable int id){
        return adminService.showUpdateProduct(modelMap,request,model,id);
    }
    @PostMapping(value = "/update_product/{id}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public String updateProduct(Model model,@ModelAttribute(value = "productUpdate") Product productUpdate, HttpServletRequest request,@PathVariable int id) throws IOException, ServletException {
        return adminService.updateProduct(model,productUpdate,request,id);
    }
    @GetMapping(value = "/delete_product/{id}")
    public void deleteProduct(HttpServletRequest request, HttpServletResponse response, @PathVariable int id) throws IOException{
        adminService.deleteProduct(request,response,id);
    }
    @GetMapping(value = "/add_user")
    public String showAddUser(HttpServletRequest request){
        return adminService.showAddUser(request);
    }
    @PostMapping(value = "/add_user")
    public String addUser (HttpServletRequest request) throws MessagingException {
        return adminService.addUser(request);
    }
    @GetMapping(value = "/update_user/{id}")
    public String showUpdateUser(HttpServletRequest request,@PathVariable int id){
        return adminService.showUpdateUser(request,id);
    }
    @PostMapping(value = "/update_user/{id}")
    public String updateUser(HttpServletRequest request,@PathVariable int id){
        return adminService.updateUser(request, id);
    }
    @GetMapping(value = "/delete_user/{id}")
    public void deleteUser(HttpServletRequest request, HttpServletResponse response ,@PathVariable int id) throws IOException{
        adminService.deleteUser(request,response,id);
    }
    @GetMapping(value = "/add_category")
    public String showAddCategory(HttpServletRequest request){
        return adminService.showAddCategory(request);
    }
    @PostMapping(value = "/add_category")
    public String addCategory (HttpServletRequest request){
        return adminService.addCategory(request);
    }
    @GetMapping(value = "/update_category/{id}")
    public String showUpdateCategory(HttpServletRequest request,@PathVariable int id){
        return adminService.showUpdateCategory(request,id);
    }
    @PostMapping(value = "/update_category/{id}")
    public String updateCategory (HttpServletRequest request, @PathVariable int id){
        return adminService.updateCategory(request,id);
    }
    @GetMapping(value = "/delete_category/{id}")
    public void deleteCategory(HttpServletRequest request,HttpServletResponse response,@PathVariable int id) throws IOException{
        adminService.deleteCategory(request,response,id);
    }
}
