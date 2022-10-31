package com.hcmute.bookstore.models;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "order_items")
@Getter
@Setter
@NoArgsConstructor
public class OrderItem {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private int productId;
    private String productName;
    private int quantity;
    private double price;
    private int discount;
    @Transient
    private String image;
    private int orderId;
    private int userId;

    public OrderItem(int productId, String productName, int quantity, double price, int discount,int orderId,int userId) {
        this.productId = productId;
        this.productName = productName;
        this.quantity = quantity;
        this.price = price;
        this.discount = discount;
        this.orderId = orderId;
        this.userId = userId;
    }
}
