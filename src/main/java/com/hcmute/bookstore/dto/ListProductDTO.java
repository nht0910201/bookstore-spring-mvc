package com.hcmute.bookstore.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ListProductDTO {
    private int id;
    private String name;
    private int categotyId;
    private int discount;
    private double price;
    private double curPrice = (discount/100)*price;

    public ListProductDTO(int id, String name, int categotyId, int discount, double price, double curPrice) {
        this.id = id;
        this.name = name;
        this.categotyId = categotyId;
        this.discount = discount;
        this.price = price;
        this.curPrice = curPrice;
    }
}
