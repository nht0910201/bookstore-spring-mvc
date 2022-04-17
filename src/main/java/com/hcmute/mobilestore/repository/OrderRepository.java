package com.hcmute.mobilestore.repository;


import com.hcmute.mobilestore.models.Order;
import org.springframework.data.repository.CrudRepository;


public interface OrderRepository extends CrudRepository<Order, Integer> {
    //Order findByUsername(String username);

}
