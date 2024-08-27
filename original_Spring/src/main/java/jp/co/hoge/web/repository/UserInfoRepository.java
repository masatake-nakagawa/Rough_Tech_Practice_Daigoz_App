package jp.co.hoge.web.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import jp.co.hoge.web.entity.Role;
import jp.co.hoge.web.entity.UserInfo;

public interface UserInfoRepository extends JpaRepository<UserInfo, Long> {

    @Query("SELECT u FROM UserInfo u WHERE (:userName IS NULL OR u.userName LIKE %:userName%) AND (:tel IS NULL OR u.telephone LIKE %:tel%)")
    List<UserInfo> findByUserNameAndTelephone(@Param("userName") String userName, @Param("tel") String tel);

    @Query("SELECT u FROM UserInfo u WHERE u.loginId = :loginId AND u.password = :password")
    UserInfo findByLoginIdAndPassword(@Param("loginId") String loginId, @Param("password") String password);

    @Query("SELECT r FROM Role r")
    List<Role> findAllRoles();

    boolean existsByLoginId(String loginId);

    @Query("SELECT MAX(u.userId) FROM UserInfo u")
    Long findMaxUserId();

    @Query("SELECT u FROM UserInfo u WHERE u.mail = :mail") // 修正
    UserInfo findByEmail(@Param("mail") String mail); // 修正
}
