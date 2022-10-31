package com.hcmute.bookstore.repository;

import com.hcmute.bookstore.models.OrderItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface OrderItemRepository extends JpaRepository<OrderItem,Integer> {
    @Query(value = "select order_items.id, order_items.discount, order_items.order_id, order_items.price, order_items.product_id, order_items.product_name, order_items.quantity, order_items.user_id\n" +
            "from order_items,orders\n" +
            "where order_items.product_id = :pro_id and\n" +
            "      order_items.user_id = :user_id and\n" +
            "      order_items.order_id = orders.id  and\n" +
            "      orders.state='CREATED'",nativeQuery = true)
    Optional<OrderItem> findProductInCartById(@Param("pro_id") int pro_id, @Param("user_id") int user_id);

    @Query(value = "select * from order_items o where o.order_id=:id",nativeQuery = true)
    List<OrderItem> findCartById(@Param("id") int id);

    @Query(value = "select * from order_items o where o.order_id=:order_id and o.id=:item_id",nativeQuery = true)
    Optional<OrderItem> findCartItemById(@Param("order_id") int order_id,@Param("item_id") int item_id);
}
