package com.hcmute.mobilestore.repository;

import com.hcmute.mobilestore.models.Cart;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface CartRepository extends CrudRepository<Cart,String> {
    @Query("from Cart c where c.pro_id=:pro_id and c.account_id=:acc_id")
    Optional<Cart> findProductInCartById(@Param("pro_id") int pro_id, @Param("acc_id") int acc_id);

    @Query("from Cart c where c.account_id=:acc_id")
    List<Cart> findCartById(@Param("acc_id") int acc_id);

    @Query("delete from Cart c where c.pro_id=:pro_id and c.account_id=:acc_id")
    void deleteProductInCart(@Param("pro_id") int pro_id, @Param("acc_id") int acc_id);
}
