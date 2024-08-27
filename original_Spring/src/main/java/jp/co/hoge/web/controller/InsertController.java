package jp.co.hoge.web.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jp.co.hoge.web.entity.Role;
import jp.co.hoge.web.entity.UserInfo;
import jp.co.hoge.web.repository.UserInfoRepository;

@Controller
public class InsertController {

    @Autowired
    private UserInfoRepository userInfoRepository;

    @Autowired
    private HttpSession session;

    @GetMapping("/insert")
    public String insertForm(@RequestParam(value = "loginId", required = false) String loginId,
                             @RequestParam(value = "userName", required = false) String userName,
                             @RequestParam(value = "tel", required = false) String tel,
                             @RequestParam(value = "pass", required = false) String pass,
                             @RequestParam(value = "rePass", required = false) String rePass, // 追加
                             @RequestParam(value = "roleId", required = false) String roleId,
                             @RequestParam(value = "mail", required = false) String mail, // 追加
                             Model model) {
        List<Role> roles = userInfoRepository.findAllRoles();
        model.addAttribute("roles", roles);
        model.addAttribute("defaultRoleId", 2); 
        model.addAttribute("loginId", loginId);
        model.addAttribute("userName", userName);
        model.addAttribute("tel", tel);
        model.addAttribute("pass", pass);
        model.addAttribute("rePass", rePass); // 追加
        model.addAttribute("roleId", roleId);
        model.addAttribute("mail", mail); // 追加
        return "insert";
    }

    @PostMapping("/insert")
    @Transactional
    public String insert(@RequestParam("loginId") String loginId,
                         @RequestParam("userName") String userName,
                         @RequestParam("tel") String tel,
                         @RequestParam("pass") String pass,
                         @RequestParam("rePass") String rePass, // 追加
                         @RequestParam("roleId") String roleId,
                         @RequestParam("mail") String mail, // 追加
                         Model model) {
        StringBuilder errorMessage = new StringBuilder();

        if (loginId.isEmpty()) {
            errorMessage.append("IDは必須です。<br>");
        }
        if (userName.isEmpty()) {
            errorMessage.append("名前は必須です。<br>");
        }
        if (tel.isEmpty()) {
            errorMessage.append("TELは必須です。<br>");
        }
        if (pass.isEmpty()) {
            errorMessage.append("PASSは必須です。<br>");
        }
        if (mail.isEmpty()) { // 追加
            errorMessage.append("MAILは必須です。<br>");
        }
        if (!pass.equals(rePass)) { // 追加
            errorMessage.append("パスワードが一致しません。<br>");
        }

        if (errorMessage.length() > 0) {
            List<Role> roles = userInfoRepository.findAllRoles();
            model.addAttribute("roles", roles);
            model.addAttribute("errorMessage", errorMessage.toString());
            return "insert";
        }

        if (userInfoRepository.existsByLoginId(loginId)) {
            List<Role> roles = userInfoRepository.findAllRoles();
            model.addAttribute("roles", roles);
            model.addAttribute("errorMessage", "IDが重複しています");
            return "insert";
        }

        Role role = new Role();
        role.setRoleId(Long.parseLong(roleId));

        // 最新のuser_idを取得し、新しいuser_idを設定
        Long latestUserId = userInfoRepository.findMaxUserId();
        Long newUserId = latestUserId != null ? latestUserId + 1 : 1;

        UserInfo userInfo = new UserInfo(newUserId, loginId, userName, tel, pass, mail, role); // 修正
        userInfoRepository.save(userInfo);

        // ログインユーザー名をセッションから取得
        String loggedInUserName = (String) session.getAttribute("user_name");
        model.addAttribute("loggedInUserName", loggedInUserName);

        return "insertResult";
    }

}

