package com.hcmute.mobilestore.repository;


import com.hcmute.mobilestore.models.Bill;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.Optional;


public interface BillRepository extends CrudRepository<Bill, Integer> {
    @Query("from Bill bill where bill.account_id=:acc_id and bill.status='incomplete'")
    Optional<Bill> isUserHasCart(@Param("acc_id") int acc_id);
}
