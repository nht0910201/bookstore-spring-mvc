package com.hcmute.bookstore.repository;

import com.hcmute.bookstore.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User,Integer> {
    @Query(value = "select * from users where email=:email",nativeQuery = true)
    Optional<User> findUserByEmailAdmin(@Param("email") String email);

    @Query(value = "select * from users where email=:email and state='ACTIVE' ",nativeQuery = true)
    Optional<User> findUserByEmail(@Param("email") String email);

    @Query(value = "select * from users where phone=:phone",nativeQuery = true)
    Optional<User> findUserByPhoneAdmin(@Param("phone") String phone);

    @Query(value = "select * from users where phone=:phone and state='ACTIVE' ",nativeQuery = true)
    Optional<User> findUserByPhone(@Param("phone") String phone);

    @Query(value = "select * from users where id=:id and state='ACTIVE' ",nativeQuery = true)
    Optional<User> findUserByID(@Param("id") int id);

    @Query(value = "select * from users where id=:id ",nativeQuery = true)
    Optional<User> findUserByIDAdmin(@Param("id") int id);
}
