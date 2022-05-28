package com.hcmute.mobilestore.repository;


import com.hcmute.mobilestore.models.Shopping_Cart;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.Optional;


public interface BillRepository extends CrudRepository<Shopping_Cart, Integer> {
    @Query("from Shopping_Cart bill where bill.account_id=:acc_id and bill.status='incomplete'")
    Optional<Shopping_Cart> isUserHasCart(@Param("acc_id") int acc_id);
}
