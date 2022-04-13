package com.hcmute.mobilestore.repository;

import com.hcmute.mobilestore.models.Account;
import com.hcmute.mobilestore.models.User;
import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<User, Integer> {
    User findByEmail(String email);
}
