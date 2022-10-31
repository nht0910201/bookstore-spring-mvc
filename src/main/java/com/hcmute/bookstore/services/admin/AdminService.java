package com.hcmute.bookstore.services.admin;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.hcmute.bookstore.Config.CloudinaryConfig;
import com.hcmute.bookstore.Config.Constant;
import com.hcmute.bookstore.models.*;
import com.hcmute.bookstore.repository.*;
import com.hcmute.bookstore.utils.MailUtils;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartFile;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Optional;

@MultipartConfig(
        fileSizeThreshold = 2 * 1024 * 1024,
        maxFileSize = 50 * 1024 * 1024,
        maxRequestSize = 50 * 1024 * 1024
)
@Service
@AllArgsConstructor
public class AdminService implements IAdminService {
    private final ProductRepository productRepository;
    private final CloudinaryConfig cloudinary;
    private final ProductImageRepository productImageRepository;
    private final CategoryRepository categoryRepository;
    private final UserRepository userRepository;
    private final OrderRepository orderRepository;
    private final OrderItemRepository orderItemRepository;

    @Override
    public String showManagePage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        boolean checkAuth = (boolean) session.getAttribute("auth");
        String roleAuth = (String) session.getAttribute("role");
        if (checkAuth && roleAuth.equals(Constant.ROLE_ADMIN)) {
            List<Product> products = productRepository.findAll();
            for (Product pro : products) {
                List<ProductImage> productImages = productImageRepository.findImageByProID(pro.getId());
                pro.setProductImages(productImages);
            }
            request.setAttribute("products", products);
            List<User> users = userRepository.findAll();
            request.setAttribute("users", users);
            List<Category> categories = categoryRepository.findAll();
            request.setAttribute("categories", categories);
            List<Category> sub_categories = categoryRepository.findAll();
            request.setAttribute("sub_categories", sub_categories);
            List<Order> orders = orderRepository.getAllOrder();
            request.setAttribute("orders",orders);
            List<OrderItem> orderItemList = orderItemRepository.findAll();
            request.setAttribute("orderItemList",orderItemList);
            return "viewAdmin/Manage";
        } else {
            return "redirect:/Home";
        }
    }

    @Override
    public String showAddProduct(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        boolean checkAuth = (boolean) session.getAttribute("auth");
        String roleAuth = (String) session.getAttribute("role");
        if (checkAuth && roleAuth.equals(Constant.ROLE_ADMIN)) {
            model.addAttribute("product", new Product());
            List<Category> categories = categoryRepository.findAll();
            request.setAttribute("categories",categories);
            return "viewAdmin/AddProduct";
        } else {
            return "redirect:/Home";
        }
    }

    @Override
    public String addProduct(Product product, HttpServletRequest request) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("proname");
        int category = Integer.parseInt(request.getParameter("category"));
        double price = Double.parseDouble(request.getParameter("price"));
        int discount = Integer.parseInt(request.getParameter("discount"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String supplier = request.getParameter("supplier");
        String publisher = request.getParameter("publisher");
        String year = request.getParameter("year");
        String author = request.getParameter("author");
        int pageNum = Integer.parseInt(request.getParameter("pageNum"));
        String size = request.getParameter("size");
        String description = request.getParameter("description");
        Optional<Product> checkExist = productRepository.findProductByName(name);
        if (checkExist.isPresent()) {
            request.setAttribute("hasError", true);
            request.setAttribute("errorMessage", "Product already exist");
            return "viewAdmin/AddProduct";
        } else {
            Product newProduct = new Product(name, price, discount, quantity,description, pageNum, publisher, author, supplier, size, year, category, "enable");
            productRepository.save(newProduct);
            Optional<Product> pro = productRepository.findProductByName(name);
            if (pro.isEmpty()) {
                request.setAttribute("hasError", true);
                request.setAttribute("errorMessage", "Cannot Add Product");
                return "viewAdmin/AddProduct";
            } else {
                if (product.getImgs().size() > 0) {
                    for (MultipartFile file : product.getImgs()) {
                        String img_src = cloudinary.uploadImage(file, null);
                        ProductImage productImage = new ProductImage(pro.get(), img_src);
                        productImageRepository.save(productImage);
                    }
                }
                return "redirect:/admin/manage";
            }
        }
    }

    @Override
    public String showUpdateProduct(ModelMap modelMap, HttpServletRequest request, Model model, int id) {
        HttpSession session = request.getSession();
        boolean checkAuth = (boolean) session.getAttribute("auth");
        String roleAuth = (String) session.getAttribute("role");
        if (checkAuth && roleAuth.equals(Constant.ROLE_ADMIN)) {
            Optional<Product> product = productRepository.findProductByAdmin(id);
            model.addAttribute("productUpdate", product.get());
            List<Category> categories = categoryRepository.findAll();
            request.setAttribute("categories", categories);
            List<ProductImage> productImage = productImageRepository.findImageByProID(id);
            request.setAttribute("productImage", productImage);
            return "viewAdmin/UpdateProduct";
        } else {
            return "redirect:/Home";
        }
    }

    @Override
    public String updateProduct(Model model, Product productUpdate, HttpServletRequest request, int id) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("proname");
        int category = Integer.parseInt(request.getParameter("category"));
        double price = Double.parseDouble(request.getParameter("price"));
        int discount = Integer.parseInt(request.getParameter("discount"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String supplier = request.getParameter("supplier");
        String publisher = request.getParameter("publisher");
        String year = request.getParameter("year");
        String author = request.getParameter("author");
        int pageNum = Integer.parseInt(request.getParameter("pageNum"));
        String size = request.getParameter("size");
        String description = request.getParameter("description");
        Optional<Product> product = productRepository.findProductByAdmin(id);
        if (product.isPresent()) {
            if (product.get().getName().equals(name)) {
                product.get().setName(name);
                product.get().setCategoryId(category);
                product.get().setPrice(price);
                product.get().setDiscount(discount);
                product.get().setQuantity(quantity);
                product.get().setSupplier(supplier);
                product.get().setPublisher(publisher);
                product.get().setPublishYear(year);
                product.get().setAuthor(author);
                product.get().setPageNum(pageNum);
                product.get().setSize(size);
                product.get().setDescription(description);
                productRepository.save(product.get());
                Optional<Product> pro = productRepository.findProductByName(name);
                if (pro.isEmpty()) {
                    request.setAttribute("hasError", true);
                    request.setAttribute("errorMessage", "Cannot Update Product");
                    Optional<Product> updatePro = productRepository.findProductByAdmin(id);
                    model.addAttribute("productUpdate", updatePro.get());
                    List<Category> categories = categoryRepository.findAll();
                    request.setAttribute("categories", categories);
                    List<ProductImage> productImage = productImageRepository.findImageByProID(id);
                    request.setAttribute("productImage", productImage);
                    return "viewAdmin/UpdateProduct";
                } else {
                    if (productUpdate.getImgs().size() > 0) {
                        for (MultipartFile file : productUpdate.getImgs()) {
                            String img_src = cloudinary.uploadImage(file, null);
                            ProductImage productImage = new ProductImage(pro.get(), img_src);
                            productImageRepository.save(productImage);
                        }
                    }
                    request.setAttribute("hasNotify", true);
                    request.setAttribute("successMessage", "Update Product Successfully");
                    Optional<Product> updatePro = productRepository.findProductByAdmin(id);
                    model.addAttribute("productUpdate", updatePro.get());
                    List<Category> categories = categoryRepository.findAll();
                    request.setAttribute("categories", categories);
                    List<ProductImage> productImage = productImageRepository.findImageByProID(id);
                    request.setAttribute("productImage", productImage);
                    return "viewAdmin/UpdateProduct";
                }
            } else {
                Optional<Product> checkExist = productRepository.findProductByName(name);
                if (checkExist.isPresent()) {
                    request.setAttribute("hasError", true);
                    request.setAttribute("errorMessage", "Product name already exist");
                    Optional<Product> updatePro = productRepository.findProductByAdmin(id);
                    model.addAttribute("productUpdate", updatePro.get());
                    List<Category> categories = categoryRepository.findAll();
                    request.setAttribute("categories", categories);
                    List<ProductImage> productImage = productImageRepository.findImageByProID(id);
                    request.setAttribute("productImage", productImage);
                    return "viewAdmin/UpdateProduct";
                } else {
                    product.get().setName(name);
                    product.get().setCategoryId(category);
                    product.get().setPrice(price);
                    product.get().setDiscount(discount);
                    product.get().setQuantity(quantity);
                    product.get().setSupplier(supplier);
                    product.get().setPublisher(publisher);
                    product.get().setPublishYear(year);
                    product.get().setAuthor(author);
                    product.get().setPageNum(pageNum);
                    product.get().setSize(size);
                    product.get().setDescription(description);
                    productRepository.save(product.get());
                    Optional<Product> pro = productRepository.findProductByName(name);
                    if (pro.isEmpty()) {
                        request.setAttribute("hasError", true);
                        request.setAttribute("errorMessage", "Cannot Update Product");
                        Optional<Product> updatePro = productRepository.findProductByAdmin(id);
                        model.addAttribute("productUpdate", updatePro.get());
                        List<Category> categories = categoryRepository.findAll();
                        request.setAttribute("categories", categories);
                        List<ProductImage> productImage = productImageRepository.findImageByProID(id);
                        request.setAttribute("productImage", productImage);
                        return "viewAdmin/UpdateProduct";
                    } else {
                        if (productUpdate.getImgs().size() > 0) {
                            for (MultipartFile file : productUpdate.getImgs()) {
                                String img_src = cloudinary.uploadImage(file, null);
                                ProductImage productImage = new ProductImage(pro.get(), img_src);
                                productImageRepository.save(productImage);
                            }
                        }
                        request.setAttribute("hasNotify", true);
                        request.setAttribute("successMessage", "Update Product Successfully");
                        Optional<Product> updatePro = productRepository.findProductByAdmin(id);
                        model.addAttribute("productUpdate", updatePro.get());
                        List<Category> categories = categoryRepository.findAll();
                        request.setAttribute("categories", categories);
                        List<ProductImage> productImage = productImageRepository.findImageByProID(id);
                        request.setAttribute("productImage", productImage);
                        return "viewAdmin/UpdateProduct";
                    }
                }
            }
        } else {
            System.out.println("not found product");
        }
        return "";
    }

    @Override
    public void deleteProduct(HttpServletRequest request, HttpServletResponse response, int id) throws IOException {
        Optional<Product> delProduct = productRepository.findProductByAdmin(id);
        if (delProduct.isEmpty()) {
            System.out.println("Cannot find product");
        } else {
            delProduct.get().setState("disable");
            productRepository.save(delProduct.get());
            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            out.print(true);
            out.flush();
        }
    }

    @Override
    public String showAddUser(HttpServletRequest request) {
        HttpSession session = request.getSession();
        boolean checkAuth = (boolean) session.getAttribute("auth");
        String roleAuth = (String) session.getAttribute("role");
        if (checkAuth && roleAuth.equals(Constant.ROLE_ADMIN)) {
            return "viewAdmin/AddUser";
        } else {
            return "redirect:/Home";
        }
    }

    @Override
    public String addUser(HttpServletRequest request) throws MessagingException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");
        Optional<User> user1 = userRepository.findUserByEmail(email);
        if (user1.isPresent()) {
            request.setAttribute("hasError", true);
            request.setAttribute("errorMessage", "Email already exist");
            return "viewAdmin/AddUser";
        } else {
            Optional<User> user2 = userRepository.findUserByPhone(phone);
            if (user2.isPresent()) {
                request.setAttribute("hasError", true);
                request.setAttribute("errorMessage", "Phone number already exist");
                return "viewAdmin/AddUser";
            } else {
                String pwd = "123456a.";
                String rawPassword = BCrypt.withDefaults().hashToString(12, pwd.toCharArray());
                User newUser = new User(name, email, rawPassword, phone, role, Constant.ACTIVE);
                userRepository.save(newUser);
                MailUtils.sendPassword(email, pwd);
                return "redirect:/admin/manage";
            }
        }
    }

    @Override
    public String showUpdateUser(HttpServletRequest request, int id) {
        HttpSession session = request.getSession();
        boolean checkAuth = (boolean) session.getAttribute("auth");
        String roleAuth = (String) session.getAttribute("role");
        if (checkAuth && roleAuth.equals(Constant.ROLE_ADMIN)) {
            Optional<User> user = userRepository.findUserByIDAdmin(id);
            request.setAttribute("user", user.get());
            return "viewAdmin/UpdateUser";
        } else {
            return "redirect:/Home";
        }
    }

    @Override
    public String updateUser(HttpServletRequest request, int id) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");
        String state = request.getParameter("state");
        Optional<User> user = userRepository.findUserByIDAdmin(id);
        if (user.isPresent()) {
            if (user.get().getEmail().equals(email)) {
                if (user.get().getPhone().equals(phone)) {
                    user.get().setEmail(email);
                    user.get().setName(name);
                    user.get().setPhone(phone);
                    user.get().setRole(role);
                    user.get().setState(state);
                    userRepository.save(user.get());
                    Optional<User> upadteUser = userRepository.findUserByIDAdmin(id);
                    request.setAttribute("user", upadteUser.get());
                    request.setAttribute("hasNotify", true);
                    request.setAttribute("successMessage", "Update User Successfully");
                    return "viewAdmin/UpdateUser";
                } else {
                    Optional<User> user1 = userRepository.findUserByPhoneAdmin(phone);
                    if (user1.isPresent()) {
                        request.setAttribute("hasError", true);
                        request.setAttribute("errorMessage", "Phone number already exist");
                        Optional<User> upadteUser = userRepository.findUserByIDAdmin(id);
                        request.setAttribute("user", upadteUser.get());
                        return "viewAdmin/UpdateUser";
                    } else {
                        user.get().setEmail(email);
                        user.get().setName(name);
                        user.get().setPhone(phone);
                        user.get().setRole(role);
                        user.get().setState(state);
                        userRepository.save(user.get());
                        Optional<User> upadteUser = userRepository.findUserByIDAdmin(id);
                        request.setAttribute("user", upadteUser.get());
                        request.setAttribute("hasNotify", true);
                        request.setAttribute("successMessage", "Update User Successfully");
                        return "viewAdmin/UpdateUser";
                    }
                }
            } else {
                Optional<User> user2 = userRepository.findUserByEmailAdmin(email);
                if (user2.isPresent()) {
                    request.setAttribute("hasError", true);
                    request.setAttribute("errorMessage", "Email already exist");
                    Optional<User> upadteUser = userRepository.findUserByIDAdmin(id);
                    request.setAttribute("user", upadteUser.get());
                    return "viewAdmin/UpdateUser";
                } else {
                    Optional<User> user3 = userRepository.findUserByPhoneAdmin(phone);
                    if (user3.isPresent()) {
                        if (user3.get().getPhone().equals(user.get().getPhone())) {
                            user.get().setEmail(email);
                            user.get().setName(name);
                            user.get().setPhone(phone);
                            user.get().setRole(role);
                            user.get().setState(state);
                            userRepository.save(user.get());
                            Optional<User> upadteUser = userRepository.findUserByIDAdmin(id);
                            request.setAttribute("user", upadteUser.get());
                            request.setAttribute("hasNotify", true);
                            request.setAttribute("successMessage", "Update User Successfully");
                            return "viewAdmin/UpdateUser";
                        } else {
                            request.setAttribute("hasError", true);
                            request.setAttribute("errorMessage", "Phone number already exist");
                            Optional<User> upadteUser = userRepository.findUserByIDAdmin(id);
                            request.setAttribute("user", upadteUser.get());
                            return "viewAdmin/UpdateUser";
                        }

                    } else {
                        user.get().setEmail(email);
                        user.get().setName(name);
                        user.get().setPhone(phone);
                        user.get().setRole(role);
                        user.get().setState(state);
                        userRepository.save(user.get());
                        Optional<User> upadteUser = userRepository.findUserByIDAdmin(id);
                        request.setAttribute("user", upadteUser.get());
                        request.setAttribute("hasNotify", true);
                        request.setAttribute("successMessage", "Update User Successfully");
                        return "viewAdmin/UpdateUser";
                    }
                }
            }
        } else {
            System.out.println("Cannot find user");
            return "Cannot find user";
        }
    }

    @Override
    public void deleteUser(HttpServletRequest request, HttpServletResponse response, int id) throws IOException {
        Optional<User> delUser = userRepository.findUserByIDAdmin(id);
        if (delUser.isEmpty()) {
            System.out.println("Cannot find product");
        } else {
            delUser.get().setState(Constant.NOT_ACTIVE);
            userRepository.save(delUser.get());
            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            out.print(true);
            out.flush();
        }
    }

    @Override
    public String showAddCategory(HttpServletRequest request) {
        HttpSession session = request.getSession();
        boolean checkAuth = (boolean) session.getAttribute("auth");
        String roleAuth = (String) session.getAttribute("role");
        if (checkAuth && roleAuth.equals(Constant.ROLE_ADMIN)) {
            List<Category> categories = categoryRepository.findCategoryParent();
            request.setAttribute("categories", categories);
            return "viewAdmin/AddCategory";
        } else {
            return "redirect:/Home";
        }
    }

    @Override
    public String addCategory(HttpServletRequest request) {
        String name = request.getParameter("name");
        int catParent_id = Integer.parseInt(request.getParameter("parent_category"));
        Optional<Category> existCategory = categoryRepository.findCategoryByName(name);
        if (existCategory.isPresent()) {
            request.setAttribute("hasError", true);
            request.setAttribute("errorMessage", "Category already exist");
            List<Category> categories = categoryRepository.findCategoryParent();
            request.setAttribute("categories", categories);
            return "viewAdmin/AddCategory";
        } else {
            Category newCategory = new Category(name, catParent_id);
            categoryRepository.save(newCategory);
            return "redirect:/admin/manage";
        }
    }

    @Override
    public String showUpdateCategory(HttpServletRequest request, int id) {
        HttpSession session = request.getSession();
        boolean checkAuth = (boolean) session.getAttribute("auth");
        String roleAuth = (String) session.getAttribute("role");
        if (checkAuth && roleAuth.equals(Constant.ROLE_ADMIN)) {
            Optional<Category> category = categoryRepository.findById(id);
            request.setAttribute("category", category.get());
            List<Category> categories = categoryRepository.findAll();
            request.setAttribute("categories", categories);
            return "viewAdmin/UpdateCategory";
        } else {
            return "redirect:/Home";
        }
    }

    @Override
    public String updateCategory(HttpServletRequest request, int id) {
        String name = request.getParameter("name");
        int catParent_id = Integer.parseInt(request.getParameter("parent_category"));
        Optional<Category> category = categoryRepository.findById(id);
        if (category.isPresent()) {
            Optional<Category> existCategory = categoryRepository.findCategoryByName(name);
            if (existCategory.isPresent()) {
                if (category.get().getName().equals(name)) {
                    category.get().setName(name);
                    category.get().setParent_id(catParent_id);
                    categoryRepository.save(category.get());
                    request.setAttribute("hasNotify", true);
                    request.setAttribute("successMessage", "Update Category Successfully");
                    Optional<Category> updateCategory = categoryRepository.findById(id);
                    request.setAttribute("category", updateCategory.get());
                    List<Category> categories = categoryRepository.findAll();
                    request.setAttribute("categories", categories);
                    return "viewAdmin/UpdateCategory";
                } else {
                    request.setAttribute("hasError", true);
                    request.setAttribute("errorMessage", "Category already exist");
                    request.setAttribute("category", category.get());
                    List<Category> categories = categoryRepository.findAll();
                    request.setAttribute("categories", categories);
                    return "viewAdmin/UpdateCategory";
                }
            } else {
                category.get().setName(name);
                category.get().setParent_id(catParent_id);
                categoryRepository.save(category.get());
                request.setAttribute("hasNotify", true);
                request.setAttribute("successMessage", "Update Category Successfully");
                Optional<Category> updateCategory = categoryRepository.findById(id);
                request.setAttribute("category", updateCategory.get());
                List<Category> categories = categoryRepository.findAll();
                request.setAttribute("categories", categories);
                return "viewAdmin/UpdateCategory";
            }
        } else {
            System.out.println("Cannot find category");
            return "";
        }
    }

    @Override
    public void deleteCategory(HttpServletRequest request, HttpServletResponse response, int id) throws IOException {
        List<Product> productList = productRepository.findProductViaCategoryByAdmin(id);
        List<Category> categoryList = categoryRepository.findCategoryChildByParentID(id);
        if (productList.size() > 0) {
            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            out.print(false);
            out.flush();
        } else {
            if(categoryList.size()>0)
            {
                PrintWriter out = response.getWriter();
                response.setContentType("application/json");
                response.setCharacterEncoding("utf-8");
                out.print(false);
                out.flush();
            }else{
                categoryRepository.deleteById(id);
                PrintWriter out = response.getWriter();
                response.setContentType("application/json");
                response.setCharacterEncoding("utf-8");
                out.print(true);
                out.flush();
            }
        }
    }

    @Override
    public String updateOrder(HttpServletRequest request,int id) {
        String address = request.getParameter("address");
        String confirm = request.getParameter("confirm");
        Optional<Order> order = orderRepository.getOrder(id);
        if(order.isPresent()){
            if(confirm.equals(Constant.ACCEPTED)){
                order.get().setState(confirm);
                order.get().setAddress(address);
                List<OrderItem> orderItems = orderItemRepository.findCartById(id);
                int pro_id;
                if(orderItems.size() > 0) {
                    for (OrderItem orderItem : orderItems) {
                        pro_id = orderItem.getProductId();
                        Optional<Product> product = productRepository.findById(pro_id);
                        if(product.get().getQuantity()>orderItem.getQuantity()){
                            product.get().setQuantity(product.get().getQuantity() - orderItem.getQuantity());
                            productRepository.save(product.get());
                            orderRepository.save(order.get());
                        }
                    }
                }
            }else if(confirm.equals(Constant.DELIVERY)){
                order.get().setState(confirm);
                order.get().setAddress(address);
                orderRepository.save(order.get());
            }
            return "redirect:/admin/manage";
        }else {
            return "";
        }
    }

    @Override
    public void deleteOrder(HttpServletRequest request, HttpServletResponse response, int id) throws IOException {
        Optional<Order> order = orderRepository.getOrder(id);
        if(order.isPresent()){
            order.get().setState(Constant.CANCELED);
            orderRepository.save(order.get());
            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            out.print(true);
            out.flush();
        }else{
            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            out.print(false);
            out.flush();
        }
    }
}
