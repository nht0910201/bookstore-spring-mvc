package com.hcmute.mobilestore.controllers;

import com.hcmute.mobilestore.models.*;
import com.hcmute.mobilestore.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping(path = "/Admin")
public class AdminController {
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    ProductRepository productRepository;
    @Autowired
    SupplierRepository supplierRepository;
    @Autowired
    private ShoppingCartRepository shoppingCartRepository;
    @Autowired
    private CartItemRepository cartItemRepository;
//    Quản lý sản phẩm
    @GetMapping(value = "/Manage")
    public String productManage(ModelMap modelMap) {
        Iterable<Product> products = productRepository.findAll();
        modelMap.addAttribute("products", products);
        Iterable<Account> users = accountRepository.findAll();
        modelMap.addAttribute("users", users);
        Iterable<Supplier> suppliers = supplierRepository.findAll();
        modelMap.addAttribute("suppliers", suppliers);
        List<Shopping_Cart> shopping_cart = shoppingCartRepository.showAllOrder();
        modelMap.addAttribute("list_Order" ,shopping_cart);
        Iterable<Cart_Item> cartItem = cartItemRepository.findAll();
        modelMap.addAttribute("cart_item" ,cartItem);
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
        Account updateUser = accountRepository.findById(id).get();
        updateUser.setAddress(userAddress);
        updateUser.setName(userName);
        updateUser.setPhone_number(userPhone_number);
        try {
            accountRepository.save(updateUser);
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
            Account newUser = new Account(name, email, pass,address,  phone_number,role);
            accountRepository.save(newUser);
            return "redirect:/Admin/Manage";
        } catch (Exception e) {
            System.out.println(e);
            return "redirect:/Admin/Manage";
        }
    }
    @PostMapping(value = "/Manage/Authorize")
    public String authorizeOrder(ModelMap modelMap, HttpServletRequest request) {
        int order_id = Integer.parseInt(request.getParameter("order_ id"));
        Optional<Shopping_Cart> shopping_cart = shoppingCartRepository.findById(order_id);
        shopping_cart.get().setStatus("Accepted");
        shoppingCartRepository.save(shopping_cart.get());

        try {


            return "redirect:/Admin/Manage";
        } catch (Exception e) {
            System.out.println(e);
            return "redirect:/Admin/Manage";
        }
    }
}
