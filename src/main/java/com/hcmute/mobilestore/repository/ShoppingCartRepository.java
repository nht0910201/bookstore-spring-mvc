package com.hcmute.mobilestore.repository;


import com.hcmute.mobilestore.models.Shopping_Cart;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;


public interface ShoppingCartRepository extends CrudRepository<Shopping_Cart, Integer> {
    @Query("from Shopping_Cart bill where bill.account_id=:acc_id and bill.status='incomplete'")
    Optional<Shopping_Cart> isUserHasCart(@Param("acc_id") int acc_id);
    @Query("from Shopping_Cart s where s.account_id =:acc_id  and s.status = 'complete'")
    List<Shopping_Cart> showOrder(@Param("acc_id") int acc_id);
    @Query("from Shopping_Cart s where s.status = 'complete'")
    List<Shopping_Cart> showAllOrder();
}
