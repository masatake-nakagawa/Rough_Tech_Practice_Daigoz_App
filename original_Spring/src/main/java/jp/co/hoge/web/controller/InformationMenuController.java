package jp.co.hoge.web.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class InformationMenuController {

    @Autowired
    private HttpSession session;

    @GetMapping("/informationMenu")
    public String informationMenu(Model model) {
        if (session == null || session.getAttribute("user_name") == null || session.getAttribute("role_id") == null) {
            return "redirect:/index";
        }

        String userName = (String) session.getAttribute("user_name");
        String roleIdStr = (String) session.getAttribute("role_id");
        int roleId = Integer.parseInt(roleIdStr);

        model.addAttribute("userName", userName);
        model.addAttribute("roleId", roleId);

        return "informationMenu";
    }
}
