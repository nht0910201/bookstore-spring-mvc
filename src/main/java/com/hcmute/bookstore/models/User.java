package com.hcmute.bookstore.models;

import com.sun.istack.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "users")
@Getter
@Setter
@NoArgsConstructor
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private String name;
    private String email;
    private String password;
    private LocalDateTime dob;
    private String phone;
    private String role;
    private String state;

    public User(String name, String email, String password, LocalDateTime dob, String phone, String role, String state) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.dob = dob;
        this.phone = phone;
        this.role = role;
        this.state = state;
    }
    public User(String name, String email, LocalDateTime dob, String phone) {
        this.name = name;
        this.email = email;
        this.dob = dob;
        this.phone = phone;
    }

    public User(String name, String email, String password, String phone, String role,String state) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.role = role;
        this.state = state;
    }

    public User(String name, String email, String phone, String role, String state) {
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.role = role;
        this.state = state;
    }
}

