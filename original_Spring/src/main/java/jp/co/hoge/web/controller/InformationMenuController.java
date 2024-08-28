package jp.co.hoge.web.controller;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jp.co.hoge.web.entity.Event;
import jp.co.hoge.web.service.EventService;

@Controller
public class InformationMenuController {

    @Autowired
    private HttpSession session;

    @Autowired
    private EventService eventService;

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

    @GetMapping("/insertInformationForm")
    public String insertInformationForm() {
        return "insertInformation";
    }

    @PostMapping("/insertInformation")
    public String insertInformation(
            @RequestParam("eventName") String eventName,
            @RequestParam("dateAndTime") String dateAndTime,
            @RequestParam("venue") String venue,
            @RequestParam("text") String text,
            @RequestParam("number") int number,
            Model model) {
        List<String> dateFormats = Arrays.asList("yyyy-MM-dd HH:mm:ss", "yyyy.MM.dd");
        Timestamp timestamp = null;
        for (String format : dateFormats) {
            try {
                SimpleDateFormat dateFormat = new SimpleDateFormat(format);
                timestamp = new Timestamp(dateFormat.parse(dateAndTime).getTime());
                break;
            } catch (ParseException e) {
                // 無視して次の形式を試す
            }
        }

        if (timestamp == null) {
            // エラーハンドリング
            model.addAttribute("errorMessage", "日付形式が正しくありません。");
            return "insertInformation";
        }

        int maxEventId = eventService.getMaxEventId();
        Event event = new Event((long) (maxEventId + 1), eventName, timestamp, venue, text, number);
        eventService.saveEvent(event);

        return "insertInformationResult";
    }

}


