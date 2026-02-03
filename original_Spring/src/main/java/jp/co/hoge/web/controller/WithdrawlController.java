package jp.co.hoge.web.controller;

import jakarta.servlet.http.HttpSession;

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

            // セッションを無効化（ログアウト状態にする）
            session.invalidate();

            // --- 修正箇所 ---
            // 直接 "/withdrawlResult" と書くと @PostMapping を再度探してしまうため、
            // 明示的に完了画面のURL（/withdrawl/withdrawlResult）へリダイレクトします。
            // 修正後、下の showWithdrawlResultPage メソッドが呼ばれるようになります。
            return "redirect:/withdrawl/withdrawlResult"; 
        }

        // loginIdがnullの場合のリダイレクト先を指定
        return "redirect:/userMenu";
    }

    // このメソッドが "/withdrawl/withdrawlResult" への GET アクセスを受け取ります
    @GetMapping("/withdrawlResult")
    @SuppressWarnings("unused")
    public String showWithdrawlResultPage() {
        return "withdrawlResult"; // withdrawlResult.jspを表示
    }
}