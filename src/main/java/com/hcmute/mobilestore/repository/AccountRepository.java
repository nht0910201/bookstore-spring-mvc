package com.hcmute.mobilestore.repository;

import com.hcmute.mobilestore.models.Account;
import org.springframework.data.repository.CrudRepository;

public interface AccountRepository extends CrudRepository<Account, Integer> {
    Account findByUsername(String username);
}
