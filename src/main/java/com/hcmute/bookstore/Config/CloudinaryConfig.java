package com.hcmute.bookstore.Config;

import com.hcmute.bookstore.utils.ImageUtils;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.web.multipart.MultipartFile;
import com.cloudinary.Cloudinary;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import java.io.IOException;
import java.util.Map;

@Configuration
public class CloudinaryConfig {
    @Bean
    public CommonsMultipartResolver commonsMultipartResolver(){
        CommonsMultipartResolver resolver = new CommonsMultipartResolver();
        resolver.setDefaultEncoding("UTF-8");
        return resolver;
    }

    @Bean
    public com.cloudinary.Cloudinary cloudinary() {
        Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dmlt1eshx",
                "api_key", "762325771148589",
                "api_secret", "qGwPAxMLYcFE6J3SgM2_nZ0n0nc",
                "secure",true
        ));
        return cloudinary;
    }


    public String getPublicId(String urlImage){
        int temp1 = urlImage.lastIndexOf(".");
        int temp2 = urlImage.lastIndexOf("/");
        return urlImage.substring(temp2+1,temp1);
    }

    public String uploadImage(MultipartFile file, String urlDestroy) throws IOException {
        Map params = ObjectUtils.asMap(
                "resource_type", "auto",
                "folder", "cinema"
        );
        Map map = cloudinary().uploader().upload(ImageUtils.convertMultiPartToFile(file),params);
        if (urlDestroy!= null) {
            deleteImage(urlDestroy);
        }
        ImageUtils.deleteMultipartfile(ImageUtils.convertMultiPartToFile(file));
        return map.get("secure_url").toString();
    }
    public void deleteImage(String urlImage) throws IOException {
        cloudinary().uploader().destroy("cinema/" + getPublicId(urlImage)
                , ObjectUtils.asMap("resource_type", "image"));
    }
}
