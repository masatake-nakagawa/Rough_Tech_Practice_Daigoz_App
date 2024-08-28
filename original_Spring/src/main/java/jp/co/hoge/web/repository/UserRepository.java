package jp.co.hoge.web.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import jp.co.hoge.web.entity.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
}
