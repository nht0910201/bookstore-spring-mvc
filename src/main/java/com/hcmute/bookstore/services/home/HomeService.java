package com.hcmute.bookstore.services.home;

import com.hcmute.bookstore.models.Product;
import com.hcmute.bookstore.models.ProductImage;
import com.hcmute.bookstore.repository.ProductImageRepository;
import com.hcmute.bookstore.repository.ProductRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import java.util.List;

@AllArgsConstructor
@Service
public class HomeService implements IHomeService{
    private final ProductRepository productRepository;
    private final ProductImageRepository productImageRepository;
    @Override
    public String showHomePage(ModelMap modelMap) {
        List<Product> listProductDiscount = productRepository.findProductByDiscount();
        for (Product pro:listProductDiscount) {
            List<ProductImage> productImages = productImageRepository.findImageByProID(pro.getId());
            pro.setProductImages(productImages);
        }
        List<Product>  listProductPrice = productRepository.findProductByPrice();
        for (Product pro:listProductPrice) {
            List<ProductImage> productImages = productImageRepository.findImageByProID(pro.getId());
            pro.setProductImages(productImages);
        }
        modelMap.addAttribute("productsDiscount",listProductDiscount);
        modelMap.addAttribute("productsPrice",listProductPrice);
        return "viewHome/Index";
    }
}
