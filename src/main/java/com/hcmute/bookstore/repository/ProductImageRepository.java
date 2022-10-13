package com.hcmute.bookstore.repository;

import com.hcmute.bookstore.models.ProductImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ProductImageRepository extends JpaRepository<ProductImage,Integer> {
    @Query(value = "select * from products_image where pro_id=:id",nativeQuery = true)
    List<ProductImage> findImageByProID(@Param("id") int id);

}
