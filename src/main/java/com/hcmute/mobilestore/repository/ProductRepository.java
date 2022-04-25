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

    @Query("FROM Product p where p.name like %:query% order by p.price desc")
    List<Product> sortDecPrice(@Param("query") String query);

    @Query("FROM Product p where p.name like %:query% order by p.price asc ")
    List<Product> sortIncPrice(@Param("query") String query);

    @Query("FROM Product p where p.sup_id =:sup_id")
    List<Product> findBySupID(@Param("sup_id") int sup_id);
}
