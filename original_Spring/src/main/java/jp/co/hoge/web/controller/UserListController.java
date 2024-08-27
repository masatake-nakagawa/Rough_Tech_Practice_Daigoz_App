package jp.co.hoge.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jp.co.hoge.web.entity.UserInfo;
import jp.co.hoge.web.repository.UserInfoRepository;

@Controller
public class UserListController {

    @Autowired
    private UserInfoRepository userInfoRepository;

    @GetMapping("/userList")
    public String userList(Model model) {
        List<UserInfo> userList = userInfoRepository.findAll();
        model.addAttribute("userList", userList);
        return "userList";
    }
}
