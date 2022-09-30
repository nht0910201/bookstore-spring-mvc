package com.hcmute.bookstore.services.admin;

import com.hcmute.bookstore.Config.CloudinaryConfig;
import com.hcmute.bookstore.models.Product;
import com.hcmute.bookstore.models.ProductImage;
import com.hcmute.bookstore.repository.ProductImageRepository;
import com.hcmute.bookstore.repository.ProductRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@MultipartConfig(
        fileSizeThreshold = 2 * 1024 * 1024,
        maxFileSize = 50 * 1024 * 1024,
        maxRequestSize = 50 * 1024 * 1024
)
@Service
@AllArgsConstructor
public class AdminService implements IAdminService{
    private final ProductRepository productRepository;
    private final CloudinaryConfig cloudinary;
    private final ProductImageRepository productImageRepository;
    @Override
    public String showManagePage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        boolean checkAuth = (boolean) session.getAttribute("auth");
        if (!checkAuth) {
            return "redirect:/Home";
        } else {
            List<Product> products = productRepository.findAll();
            for (Product pro:products) {
                List<ProductImage> productImages = productImageRepository.findImageByProID(pro.getId());
                pro.setProductImages(productImages);
            }
            request.setAttribute("products",products);
            return "viewAdmin/Manage";
        }
    }

    @Override
    public String showAddProduct(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        boolean checkAuth = (boolean) session.getAttribute("auth");
        if (!checkAuth) {
            return "redirect:/Home";
        } else {
            model.addAttribute("product",new Product());
            return "viewAdmin/AddProduct";
        }
    }

    @Override
    public String addProduct(Product product, HttpServletRequest request) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("proname");
        int category = Integer.parseInt(request.getParameter("category"));
        double price = Double.parseDouble(request.getParameter("price"));
        int discount = Integer.parseInt(request.getParameter("discount"));
        String supplier = request.getParameter("supplier");
        String publisher = request.getParameter("publisher");
        String year = request.getParameter("year");
        String author = request.getParameter("author");
        int pageNum = Integer.parseInt(request.getParameter("pageNum"));
        String size = request.getParameter("size");
        String description = request.getParameter("description");
        Optional<Product> checkExist = productRepository.findProductByName(name);
        if(checkExist.isPresent()){
            request.setAttribute("hasError", true);
            request.setAttribute("errorMessage", "Product already exist");
            return "viewAdmin/AddProduct";
        }else{
            Product newProduct = new Product(name,price,discount,description,pageNum,publisher,author,supplier,size,year,category,"enable");
            productRepository.save(newProduct);
            Optional<Product> pro = productRepository.findProductByName(name);
            if(pro.isEmpty()){
                request.setAttribute("hasError", true);
                request.setAttribute("errorMessage", "Cannot Add Product");
                return "viewAdmin/AddProduct";
            }else{
                if(product.getImgs().size()>0)
                {
                    for (MultipartFile file:product.getImgs()) {
                        String img_src = cloudinary.uploadImage(file,null);
                        ProductImage productImage = new ProductImage(pro.get(),img_src);
                        productImageRepository.save(productImage);
                    }
                }
                return "redirect:/admin/manage";
            }
        }
    }
}
