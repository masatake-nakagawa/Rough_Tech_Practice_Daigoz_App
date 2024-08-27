package jp.co.hoge.web.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jp.co.hoge.web.entity.UserInfo;
import jp.co.hoge.web.repository.UserInfoRepository;

@Controller
public class PasswordChangeController {

    @Autowired
    private UserInfoRepository userInfoRepository;

    @GetMapping("/changePassword")
    public String showChangePasswordForm() {
        return "passChange";
    }

    @PostMapping("/changePassword")
    public String changePassword(@RequestParam("currentPassword") String currentPassword,
                                 @RequestParam("newPassword") String newPassword,
                                 @RequestParam("confirmPassword") String confirmPassword,
                                 HttpSession session, Model model) {
        String loginId = (String) session.getAttribute("login_id");

        if (loginId == null) {
            return "redirect:/index";
        }

        UserInfo user = userInfoRepository.findByLoginIdAndPassword(loginId, currentPassword);

        if (user == null) {
            model.addAttribute("error", "現在のパスワードが正しくありません。");
            return "passChange";
        }

        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "新しいパスワードが一致しません。");
            return "passChange";
        }

        user.setPassword(newPassword);
        userInfoRepository.save(user);

        return "redirect:/passChangeResult";
    }
}
