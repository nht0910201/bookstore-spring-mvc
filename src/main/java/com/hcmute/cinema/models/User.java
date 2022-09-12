package com.hcmute.cinema.models;

import com.sun.istack.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Date;

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
    private String phone_number;
    @NotNull
    private String role;
    @NotNull
    private String state;

    public User(String name, String email, String password, LocalDateTime dob, String phone_number, String role, String state) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.dob = dob;
        this.phone_number = phone_number;
        this.role = role;
        this.state = state;
    }
}
