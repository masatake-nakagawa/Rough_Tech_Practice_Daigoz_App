package jp.co.hoge.web.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jp.co.hoge.web.service.UserService;

@Controller
@RequestMapping("/withdrawl")
public class WithdrawlController {

    @Autowired
    private UserService userService;

    @GetMapping
    public String showWithdrawlPage() {
        return "withdrawl"; // withdrawl.jspを表示
    }

    @PostMapping("/withdrawlResult")
    public String withdrawl(HttpSession session) {
        // ログインユーザーの情報を取得
        String loginId = (String) session.getAttribute("login_id");

        // loginIdがnullでないことを確認
        if (loginId != null) {
            // ユーザー情報をデータベースから削除
            userService.deleteUserByLoginId(loginId);

            // セッションを無効化
            session.invalidate();

            // 退会後のリダイレクト先を指定
            return "redirect:/withdrawl/withdrawlResult";
        }

        // loginIdがnullの場合のリダイレクト先を指定
        return "redirect:/userMenu";
    }

    @GetMapping("/withdrawlResult")
    public String showWithdrawlResultPage() {
        return "withdrawlResult"; // withdrawlResult.jspを表示
    }
}



