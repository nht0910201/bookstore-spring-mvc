package com.hcmute.mobilestore.repository;

import com.hcmute.mobilestore.models.Product;
import org.springframework.data.repository.CrudRepository;

public interface ProductRepository extends CrudRepository<Product,Integer> {
}
