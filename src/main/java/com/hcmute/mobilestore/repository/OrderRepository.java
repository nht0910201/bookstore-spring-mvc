package com.hcmute.mobilestore.repository;

import com.hcmute.mobilestore.models.Account;
import org.springframework.data.repository.CrudRepository;

import javax.persistence.criteria.Order;

public interface OrderRepository extends CrudRepository<Order, Integer> {
    //Order findByUsername(String username);

}
