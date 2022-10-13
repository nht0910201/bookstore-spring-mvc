package com.hcmute.bookstore.controllers;

import com.hcmute.bookstore.services.image.IImageService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@AllArgsConstructor
@RequestMapping("/image")
@Controller
public class ImageController {
    private final IImageService imageService;

    @GetMapping("/{id}/deleteImage")
    public void deleteImage(HttpServletRequest request, HttpServletResponse response, @PathVariable int id) throws IOException {
        imageService.deleteImage(request,response,id);
    }
}
