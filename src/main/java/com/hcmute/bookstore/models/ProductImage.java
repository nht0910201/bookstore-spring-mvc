package com.hcmute.bookstore.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "products_image")
@Getter
@Setter
@NoArgsConstructor
public class ProductImage {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "pro_id", updatable = false)
    @JsonIgnore
    private Product product;

    private String img_src;

    public ProductImage(Product product, String img_src) {
        this.product = product;
        this.img_src = img_src;
    }
}
