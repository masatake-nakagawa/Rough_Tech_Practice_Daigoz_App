package jp.co.hoge.web.controller;

import java.util.List;
import jakarta.servlet.http.HttpSession;
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
                             @RequestParam(value = "rePass", required = false) String rePass,
                             @RequestParam(value = "roleId", required = false) String roleId,
                             @RequestParam(value = "mail", required = false) String mail,
                             Model model) {
        List<Role> roles = userInfoRepository.findAllRoles();
        model.addAttribute("roles", roles);
        model.addAttribute("defaultRoleId", 2); 
        model.addAttribute("loginId", loginId);
        model.addAttribute("userName", userName);
        model.addAttribute("tel", tel);
        model.addAttribute("pass", pass);
        model.addAttribute("rePass", rePass);
        model.addAttribute("roleId", roleId);
        model.addAttribute("mail", mail);
        return "insert";
    }

    @PostMapping("/insert")
    @Transactional
    public String insert(@RequestParam("loginId") String loginId,
                         @RequestParam("userName") String userName,
                         @RequestParam("tel") String tel,
                         @RequestParam("pass") String pass,
                         @RequestParam("rePass") String rePass,
                         @RequestParam("roleId") String roleId,
                         @RequestParam("mail") String mail,
                         Model model) {
        
        StringBuilder errorMessage = new StringBuilder();

        // --- バグ3修正: 未入力チェック（必須項目） ---
        if (loginId == null || loginId.isEmpty() || 
            userName == null || userName.isEmpty() || 
            mail == null || mail.isEmpty() || 
            pass == null || pass.isEmpty()) {
            errorMessage.append("未入力の必須項目があります。");
        }

        // --- バグ3修正: パスワード再入力一致チェック ---
        if (!pass.equals(rePass)) {
            if (errorMessage.length() > 0) errorMessage.append("<br>");
            errorMessage.append("パスワードと確認用パスワードが一致しません。");
        }

        // エラーがある場合は入力画面に戻す
        if (errorMessage.length() > 0) {
            List<Role> roles = userInfoRepository.findAllRoles();
            model.addAttribute("roles", roles);
            model.addAttribute("errorMessage", errorMessage.toString());
            // 入力値を保持させる
            model.addAttribute("loginId", loginId);
            model.addAttribute("userName", userName);
            model.addAttribute("tel", tel);
            model.addAttribute("mail", mail);
            model.addAttribute("roleId", roleId);
            return "insert";
        }

        // --- バグ2修正: 存在チェックの判定ミス（!を削除） ---
        // 指示：ユーザーIDが既に存在する場合、エラーになること
        if (userInfoRepository.existsByLoginId(loginId)) {
            List<Role> roles = userInfoRepository.findAllRoles();
            model.addAttribute("roles", roles);
            model.addAttribute("errorMessage", "このログインIDは既に登録されています。");
            return "insert";
        }

        // 以下、正常登録処理
        Role role = new Role();
        role.setRoleId(Long.parseLong(roleId));

        Long latestUserId = userInfoRepository.findMaxUserId();
        Long newUserId = latestUserId != null ? latestUserId + 1 : 1;

        UserInfo userInfo = new UserInfo(newUserId, loginId, userName, tel, pass, mail, role);
        userInfoRepository.save(userInfo);

        String loggedInUserName = (String) session.getAttribute("user_name");
        model.addAttribute("loggedInUserName", loggedInUserName);

        return "insertResult";
    }
}