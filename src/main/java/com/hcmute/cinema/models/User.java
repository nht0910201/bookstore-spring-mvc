package com.hcmute.cinema.models;

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
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @NotNull
    private String name;
    @NotNull
    private String email;
    @NotNull
    private String password;
    @NotNull
    private LocalDateTime dob;
    @NotNull
    private String phone;
    @NotNull
    private String role;
    @NotNull
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
}
