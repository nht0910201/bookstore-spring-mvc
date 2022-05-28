package com.hcmute.mobilestore.repository;

import com.hcmute.mobilestore.models.Cart_Item;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface CartItemRepository extends CrudRepository<Cart_Item,String> {
    @Query("from Cart_Item c,Shopping_Cart s where c.pro_id=:pro_id and c.account_id=:acc_id and s.status ='incomplete' and c.order_id = s.id")
    Optional<Cart_Item> findProductInCartById(@Param("pro_id") int pro_id, @Param("acc_id") int acc_id);

    @Query("from Cart_Item c where c.order_id=:bill_id")
    List<Cart_Item> findCartById( @Param("bill_id") int bill_id);

    @Query("delete from Cart_Item c where c.pro_id=:pro_id and c.account_id=:acc_id")
    void deleteProductInCart(@Param("pro_id") int pro_id, @Param("acc_id") int acc_id);


}
