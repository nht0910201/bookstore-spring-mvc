package com.hcmute.bookstore.services.product;

import com.hcmute.bookstore.models.Product;
import com.hcmute.bookstore.models.ProductImage;
import com.hcmute.bookstore.repository.ProductImageRepository;
import com.hcmute.bookstore.repository.ProductRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Optional;

@AllArgsConstructor
@Service
public class ProductService implements IProductService {
    private final ProductRepository productRepository;
    private final ProductImageRepository productImageRepository;

    @Override
    public String detailProduct(HttpServletRequest request, int id) {
        Optional<Product> product = productRepository.findProductByID(id);
        if (product.isEmpty()) {
            return "204";
        } else {
            List<ProductImage> imgs = productImageRepository.findImageByProID(id);
            if (imgs.size() == 0) {
                return "204";
            } else {
                request.setAttribute("product_image", imgs);
                request.setAttribute("product", product.get());
                return "viewProduct/DetailProduct";
            }
        }
    }

    @Override
    public String listProduct(HttpServletRequest request, int id) {
        List<Product> productList = productRepository.findProductByCategory(id);
        if (productList.size() == 0) {
            return "204";
        } else {
            for (Product pro : productList) {
                List<ProductImage> productImages = productImageRepository.findImageByProID(pro.getId());
                pro.setProductImages(productImages);
            }
            request.setAttribute("products", productList);
            return "viewProduct/ListProduct";
        }
    }

    @Override
    public String search(HttpServletRequest request, String search) {
        List<Product> products = productRepository.searchProduct(search);
        if (products.size() == 0) {
            return "204";
        } else {
            for (Product pro : products) {
                List<ProductImage> productImages = productImageRepository.findImageByProID(pro.getId());
                pro.setProductImages(productImages);
            }
            request.setAttribute("products", products);
            return "viewSearch/Search";
        }
    }
}
