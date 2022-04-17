package com.hcmute.mobilestore.repository;

import com.hcmute.mobilestore.models.Product;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface ProductRepository extends CrudRepository<Product,Integer> {
}
