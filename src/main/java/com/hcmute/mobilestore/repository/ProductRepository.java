package com.hcmute.mobilestore.repository;

import com.hcmute.mobilestore.models.Product;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface ProductRepository extends CrudRepository<Product,Integer> {
    @Query("FROM Product p where p.name like %:query%")
    List<Product> searchProduct(@Param("query") String query);
}
