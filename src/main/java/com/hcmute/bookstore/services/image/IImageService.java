package com.hcmute.bookstore.services.image;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public interface IImageService {
    void deleteImage(HttpServletRequest request, HttpServletResponse respone, int id) throws IOException;
}
