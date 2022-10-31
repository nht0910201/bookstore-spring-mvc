package com.hcmute.bookstore.repository;

import com.hcmute.bookstore.models.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order,Integer> {
    @Query(value = "select * from orders where user_id = :id and state = 'CREATED'",nativeQuery = true)
    Optional<Order> isUserHasCart(@Param("id") int id);

    @Query(value = "select * from orders where user_id = :id and state != 'CREATED'",nativeQuery = true)
    List<Order> getOrderOfUser(@Param("id") int id);

    @Query(value = "select * from orders where orders.state != 'CREATED' and orders.state != 'CANCELED'",nativeQuery = true)
    List<Order> getAllOrder();

    @Query(value = "select * from orders where id = :id and orders.state != 'CREATED' and orders.state != 'CANCELED'",nativeQuery = true)
    Optional<Order> getOrder(@Param("id") int id);

    @Query(value = "select * from orders where id = :id and orders.state != 'CREATED' and orders.state != 'CANCELED'",nativeQuery = true)
    Optional<Order> getOrderByUser(@Param("id") int id);
}
