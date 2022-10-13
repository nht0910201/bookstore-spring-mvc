package com.hcmute.bookstore.services.image;

import com.hcmute.bookstore.Config.CloudinaryConfig;
import com.hcmute.bookstore.repository.ProductImageRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@Service
@AllArgsConstructor
public class ImageService implements IImageService {
    private final ProductImageRepository productImageRepository;
    private final CloudinaryConfig cloudinary;

    @Override
    public void deleteImage(HttpServletRequest request, HttpServletResponse response, int id) throws IOException {
        String url = request.getParameter("url");
        System.out.println(id);
        System.out.println(url);
        cloudinary.deleteImage(url);
        productImageRepository.deleteById(id);
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");
        out.print(true);
        out.flush();
    }
}
