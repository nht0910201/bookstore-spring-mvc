package com.hcmute.mobilestore.repository;

import com.hcmute.mobilestore.models.Cart;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface CartRepository extends CrudRepository<Cart,Integer> {
    @Query("from Cart where Cart .productId=:pro_id and Cart .accountId=:acc_id")
    public Cart findProductInCartById(@Param("pro_id") int pro_id,@Param("acc_id") int acc_id);

}
