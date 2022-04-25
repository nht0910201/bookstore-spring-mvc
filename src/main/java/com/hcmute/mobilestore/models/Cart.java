package com.hcmute.mobilestore.models;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "cart")
public class Cart {
    @Id
    private int id;
    private int pro_id;
    private String pro_name;
    private double price;
    private int quantity;
    private int account_id;
    // 1: chưa thanh toán; 0: đã thanh toán
    private int order_id;


    public void setPrice(double price) {
        this.price = price;
    }

    public Cart(int pro_id, String pro_name, double price, int quantity, int account_id, int order_id) {
        this.pro_id = pro_id;
        this.pro_name = pro_name;
        this.price = price;
        this.quantity = quantity;
        this.account_id = account_id;
        this.order_id = order_id;
    }

    public Cart() {
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPro_id() {
        return pro_id;
    }

    public void setPro_id(int pro_id) {
        this.pro_id = pro_id;
    }

    public String getPro_name() {
        return pro_name;
    }

    public void setPro_name(String pro_name) {
        this.pro_name = pro_name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getAccount_id() {
        return account_id;
    }

    public void setAccount_id(int account_id) {
        this.account_id = account_id;
    }
    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }
}
