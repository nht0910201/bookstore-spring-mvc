package com.hcmute.bookstore.repository;

import com.hcmute.bookstore.models.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface ProductRepository extends JpaRepository<Product,Integer> {
    @Query(value = "select * from products where state='enable' order by discount desc",nativeQuery = true)
    List<Product> findProductByDiscount();

    @Query(value = "select * from products where id=:id and state ='enable'",nativeQuery = true)
    Optional<Product> findProductByID(@Param("id") int id);

    @Query(value = "select products.id, products.category_id, products.description, products.discount,products.quantity,products.name, products.page_num, products.price, products.publish_year, products.publisher, products.size, products.supplier, products.state, products.author,products.category_name from  products,categories where products.id=:id and products.category_id = categories.id",nativeQuery = true)
    Optional<Product> findProductByAdmin(@Param("id") int id);

    @Query(value = "select * from products where name=:name and state='enable'",nativeQuery = true)
    Optional<Product> findProductByName(@Param("name") String name);

    @Query(value = "select distinct products.id,products.name,products.price,products.discount,products.category_id,products.description,products.author,products.publisher,products.publish_year,products.page_num,products.size,products.supplier,products.state,products.category_name from\n" +
            "    (select * from categories where id = :id or parent_id=:id) as a,products\n" +
            "where (a.id = products.category_id and products.state='enable')",nativeQuery = true)
    List<Product> findProductByCategory(@Param("id") int id);

    @Query(value = "select * from products where category_id = :id",nativeQuery = true)
    List<Product> findProductViaCategoryByAdmin(@Param("id") int id);
}
