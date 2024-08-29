package jp.co.hoge.web.controller;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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
public class EventEditController {

    @Autowired
    private HttpSession session;

    @Autowired
    private EventService eventService;

    @GetMapping("/editEvent")
    public String editEvent(@RequestParam("eventId") Long eventId, @RequestParam("dateAndTime") String dateAndTime, Model model) {
        if (session == null || session.getAttribute("user_name") == null || session.getAttribute("role_id") == null) {
            return "redirect:/index";
        }

        Event event = eventService.getEventById(eventId);
        if (dateAndTime != null && !dateAndTime.isEmpty()) {
            // ミリ秒を削除
            if (dateAndTime.contains(".")) {
                dateAndTime = dateAndTime.substring(0, dateAndTime.indexOf("."));
            }
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            LocalDateTime localDateTime = LocalDateTime.parse(dateAndTime, formatter);
            event.setDateAndTime(Timestamp.valueOf(localDateTime));
        } else {
            model.addAttribute("errorMessage", "日時情報が不正です。");
        }
        model.addAttribute("event", event);

        return "eventEdit"; // ここで適切なビュー名を返す
    }


    @PostMapping("/updateEvent")
    public String updateEvent(@RequestParam("eventId") Long eventId, @RequestParam("eventName") String eventName,
                              @RequestParam("dateAndTime") String dateAndTime, @RequestParam("venue") String venue,
                              @RequestParam("text") String text, @RequestParam("number") int number, Model model) {
        Event event = eventService.getEventById(eventId);
        event.setEventName(eventName);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime localDateTime = LocalDateTime.parse(dateAndTime, formatter);
        event.setDateAndTime(Timestamp.valueOf(localDateTime));
        event.setVenue(venue);
        event.setText(text);
        event.setNumber(number);

        eventService.updateEvent(event);

        return "editingResult";
    }
}


