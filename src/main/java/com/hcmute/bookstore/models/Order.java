package com.hcmute.bookstore.models;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "orders")
@Getter
@Setter
@NoArgsConstructor
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private int userId;
    private String address;
    private double totalPrice;
    private String state;

    public Order(int userId, String address, double totalPrice, String state) {
        this.userId = userId;
        this.address = address;
        this.totalPrice = totalPrice;
        this.state = state;
    }

}
