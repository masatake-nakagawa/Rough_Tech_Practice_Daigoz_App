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
public class AuthController {

    @Autowired
    private UserInfoRepository userInfoRepository;

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @PostMapping("/login")
    public String authenticate(@RequestParam("loginId") String loginId,
                               @RequestParam("pass") String password,
                               Model model,
                               HttpSession session) {
        if (loginId.isEmpty()) {
            model.addAttribute("errorMessage", "IDは必須です");
            return "login";
        }
        if (password.isEmpty()) {
            model.addAttribute("errorMessage", "PASSは必須です");
            return "login";
        }

        UserInfo user = userInfoRepository.findByLoginIdAndPassword(loginId, password);
        if (user == null) {
            model.addAttribute("errorMessage", "IDまたはPASSが間違っています");
            return "login";
        }
        session.setAttribute("user_id", user.getUserId()); 
        session.setAttribute("login_id", loginId); // ここでlogin_idをセッションに設定
        session.setAttribute("user_name", user.getUserName());
        session.setAttribute("role_id", String.valueOf(user.getRole().getRoleId()));

        return "redirect:/menu";
    }

    @PostMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "logout";
    }

}
