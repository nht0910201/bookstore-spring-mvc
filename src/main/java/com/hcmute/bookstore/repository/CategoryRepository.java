package com.hcmute.bookstore.repository;

import com.hcmute.bookstore.models.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface CategoryRepository extends JpaRepository<Category,Integer> {
    @Query(value = "select * from categories where parent_id=0",nativeQuery = true)
    List<Category> findCategoryParent();
    @Query(value = "select * from categories where parent_id != 0",nativeQuery = true)
    List<Category> findCategoryChild();
    @Query(value = "select * from categories where name=:name",nativeQuery = true)
    Optional<Category> findCategoryByName(@Param("name") String name);
    @Query(value = "select * from categories where parent_id = :id",nativeQuery = true)
    List<Category> findCategoryChildByParentID(@Param("id") int id);

}
