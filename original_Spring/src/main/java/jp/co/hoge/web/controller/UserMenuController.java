package jp.co.hoge.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserMenuController {

    @GetMapping("/userMenu")
    public String userMenu() {
        return "userMenu";
    }
}
