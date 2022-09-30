package com.hcmute.bookstore.models;

import com.sun.istack.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "categories")
@Getter
@Setter
@NoArgsConstructor
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @NotNull
    private String name;
    @NotNull
    private int parent_id;

    public Category(String name, int parent_id) {
        this.name = name;
        this.parent_id = parent_id;
    }
}
