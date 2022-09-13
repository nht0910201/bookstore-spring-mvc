package com.hcmute.cinema.repository;

import com.hcmute.cinema.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User,Integer> {
    @Query(value = "select * from users where email=:email and state='ACTIVE' ",nativeQuery = true)
    Optional<User> findUserByEmail(@Param("email") String email);

    @Query(value = "select * from users where phone=:phone and state='ACTIVE' ",nativeQuery = true)
    Optional<User> findUserByPhone(@Param("phone") String phone);

    @Query(value = "select * from users where id=:id and state='ACTIVE' ",nativeQuery = true)
    Optional<User> findUserByID(@Param("id") int id);
}
