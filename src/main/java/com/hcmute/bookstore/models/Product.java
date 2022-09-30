package com.hcmute.bookstore.models;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "products")
@Getter
@Setter
@NoArgsConstructor
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    private String name;

    private double price;

    private int discount;

    private String description;

    private int pageNum;

    private String publisher;

    private String author;

    private String supplier;

    private String size;

    private String publishYear;

    private int categoryId;

    private String state;

    @Transient
    private List<ProductImage> productImages;
    @Transient
    private List<MultipartFile> imgs;

    public Product(String name, double price, int discount, String description, int pageNum, String publisher, String author, String supplier, String size, String publishYear, int categoryId, String state) {
        this.name = name;
        this.price = price;
        this.discount = discount;
        this.description = description;
        this.pageNum = pageNum;
        this.publisher = publisher;
        this.author = author;
        this.supplier = supplier;
        this.size = size;
        this.publishYear = publishYear;
        this.categoryId = categoryId;
        this.state = state;
    }

    public Product(int id, String name, double price, int discount, int categoryId) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.discount = discount;
        this.categoryId = categoryId;
    }
}
