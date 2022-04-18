package com.hcmute.mobilestore.controllers;

import com.hcmute.mobilestore.models.Account;
import com.hcmute.mobilestore.models.Product;
import com.hcmute.mobilestore.models.Supplier;
import com.hcmute.mobilestore.models.User;
import com.hcmute.mobilestore.repository.AccountRepository;
import com.hcmute.mobilestore.repository.ProductRepository;
import com.hcmute.mobilestore.repository.SupplierRepository;
import com.hcmute.mobilestore.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Optional;

@Controller
@RequestMapping(path = "/Admin")
public class AdminController {
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    UserRepository userRepository;
    @Autowired
    ProductRepository productRepository;
    @Autowired
    SupplierRepository supplierRepository;

//    Quản lý sản phẩm
    @GetMapping(value = "/Manage")
    public String productManage(ModelMap modelMap) {
        Iterable<Product> products = productRepository.findAll();
        modelMap.addAttribute("products", products);
        Iterable<User> users = userRepository.findAll();
        modelMap.addAttribute("users", users);
        Iterable<Supplier> suppliers = supplierRepository.findAll();
        modelMap.addAttribute("suppliers", suppliers);
        return "viewAdmin/Manage";
    }

    //    Chỉnh sửa sản phẩm
    @PostMapping(value = "/ProductManage/{id}/Update")
    public String updateProduct(ModelMap modelMap, HttpServletRequest request,
                                @PathVariable int id) {
        String proName = request.getParameter("name");
        Integer proQuantity = Integer.parseInt(request.getParameter("quantity"),10);
        Integer proDiscount = Integer.parseInt(request.getParameter("discount"),10);
        Float proPrice = Float.parseFloat(request.getParameter("price"));
        String proDes = request.getParameter("des");
        Product updateProduct = productRepository.findById(id).get();
        updateProduct.setName(proName);
        updateProduct.setDescription(proDes);
        updateProduct.setDiscount(proDiscount);
        updateProduct.setPrice(proPrice);
        updateProduct.setQuantity(proQuantity);

        try {
            productRepository.save(updateProduct);
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            return "redirect:/Admin/Manage";
        }
    }

    //    Xóa sản phẩm
    @PostMapping(value = "/ProductManage/{id}/Delete")
    public String deleteProduct(ModelMap modelMap,
                                @PathVariable int id) {
        try {
            productRepository.deleteById(id);
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            return "redirect:/Admin/Manage";
        }
    }

    //    Thêm sản phẩm
    @PostMapping(value = "/ProductManage/Add")
    public String addProduct(HttpServletRequest request) {
        String pro_name = request.getParameter("name");
        Integer quantity = Integer.parseInt(request.getParameter("quantity"),10);
        Float price = Float.parseFloat(request.getParameter("price"));
        Integer discount = Integer.parseInt(request.getParameter("discount"),10);
        String des = request.getParameter("des");
        Integer sup_id = Integer.parseInt(request.getParameter("supid"),10);
        Product newProduct = new Product(quantity, discount, sup_id, pro_name, des, price);
        try {
            productRepository.save(newProduct);
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            return "redirect:/Admin/Manage";
        }
    }

    // Chỉnh sửa người dùng
    @PostMapping(value = "/UserManage/{id}/Update")
    public String updateUser(HttpServletRequest request,
                             @PathVariable int id )
    {
        String userName = request.getParameter("name");
        String userAddress = request.getParameter("address");
        String userPhone_number = request.getParameter("phone_number");
        User updateUser = userRepository.findById(id).get();
        updateUser.setAddress(userAddress);
        updateUser.setName(userName);
        updateUser.setPhone_number(userPhone_number);
        try {
            userRepository.save(updateUser);
            return "redirect:/Admin/Manage#list-users";
        } catch (Exception e) {
            return "redirect:/Admin/Manage#list-users";
        }
    }

    //    Xóa người dùng
    @PostMapping(value = "/UserManage/{id}/Delete")
    public String deleteUser(ModelMap modelMap,
                                @PathVariable int id) {
        try {
            accountRepository.deleteById(id);
            userRepository.deleteById(id);
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            return "redirect:/Admin/Manage";
        }
    }

    @PostMapping(value = "/UserManage/Add")
    public String addUser(ModelMap modelMap, HttpServletRequest request) {
        String pass = request.getParameter("pass");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String phone_number = request.getParameter("phone_number");
        int role = 2;
        try {
            User newUser = new User(name, email, address,  phone_number);
            userRepository.save(newUser);
            Account newAccount = new Account(userRepository.findByEmail(email).getId(), email, pass, role);
            accountRepository.save(newAccount);
            return "redirect:/Admin/Manage";
        } catch (Exception e) {
            System.out.println(e);
            return "redirect:/Admin/Manage";
        }
    }
}
