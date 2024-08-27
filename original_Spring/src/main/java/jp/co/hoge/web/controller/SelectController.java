package jp.co.hoge.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jp.co.hoge.web.entity.UserInfo;
import jp.co.hoge.web.repository.UserInfoRepository;

@Controller
public class SelectController {

    @Autowired
    private UserInfoRepository userInfoRepository;

    @GetMapping("/select")
    public String selectForm() {
        return "select";
    }

    @GetMapping("/list")
    public String select(@RequestParam(name = "userName", required = false) String userName,
                         @RequestParam(name = "tel", required = false) String tel,
                         Model model) {
        List<UserInfo> userList;

        if ((userName == null || userName.isEmpty()) && (tel == null || tel.isEmpty())) {
            userList = userInfoRepository.findAll();
        } else {
            userList = userInfoRepository.findByUserNameAndTelephone(userName, tel);
        }

        if (userList.isEmpty()) {
            model.addAttribute("errorMessage", "入力されたデータはありませんでした");
            return "select";
        } else {
            model.addAttribute("userList", userList);
            return "selectResult";
        }
    }
}

