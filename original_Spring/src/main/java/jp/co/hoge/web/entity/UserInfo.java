package jp.co.hoge.web.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "user_info")
public class UserInfo {

    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long userId;

    @Column(name = "login_id")
    private String loginId;

    @Column(name = "user_name")
    private String userName;

    @Column(name = "telephone")
    private String telephone;

    @Column(name = "password")
    private String password;

    @Column(name = "mail") // 追加
    private String mail;

    @ManyToOne
    @JoinColumn(name = "role_id")
    private Role role;

    public UserInfo() {}

    public UserInfo(Long userId, String loginId, String userName, String telephone, String password, String mail, Role role) {
        this.userId = userId; // 追加
        this.loginId = loginId;
        this.userName = userName;
        this.telephone = telephone;
        this.password = password;
        this.mail = mail; // 追加
        this.role = role;
    }

    public UserInfo(String loginId, String userName, String telephone, String password, String mail, Role role) {
        this.loginId = loginId;
        this.userName = userName;
        this.telephone = telephone;
        this.password = password;
        this.mail = mail; // 追加
        this.role = role;
    }

    public UserInfo(String loginId, String userName, String telephone, String password, String mail, int roleId) {
        this.loginId = loginId;
        this.userName = userName;
        this.telephone = telephone;
        this.password = password;
        this.mail = mail; // 追加
        this.role = new Role();
        this.role.setRoleId((long) roleId);
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getLoginId() {
        return loginId;
    }

    public void setLoginId(String loginId) {
        this.loginId = loginId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }
}
