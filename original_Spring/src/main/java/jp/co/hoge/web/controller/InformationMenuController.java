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

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import jp.co.hoge.web.entity.Attendance;
import jp.co.hoge.web.entity.Event;
import jp.co.hoge.web.service.AttendanceService;
import jp.co.hoge.web.service.EventService;

@Controller
public class InformationMenuController {

    @Autowired
    private HttpSession session;

    @Autowired
    private EventService eventService;

    @Autowired
    private AttendanceService attendanceService;

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

    @GetMapping("/scheduleView")
    public String scheduleView(Model model) {
        if (session == null || session.getAttribute("user_name") == null || session.getAttribute("role_id") == null) {
            return "redirect:/index";
        }

        List<Event> events = eventService.getAllEvents();
        model.addAttribute("events", events);

        String roleIdStr = (String) session.getAttribute("role_id");
        int roleId = Integer.parseInt(roleIdStr);
        model.addAttribute("roleId", roleId);

        return "scheduleList";
    }

    @GetMapping("/eventResponse")
    public String eventResponse(@RequestParam("eventId") int eventId, Model model) {
        if (session == null || session.getAttribute("user_name") == null || session.getAttribute("role_id") == null) {
            return "redirect:/index";
        }

        // int 型の eventId を Long 型に変換
        Long eventIdLong = Long.valueOf(eventId);

        Event event = eventService.getEventById(eventIdLong);
        model.addAttribute("event", event);

        // ここで全てのイベントを取得してモデルに追加
        List<Event> events = eventService.getAllEvents();
        model.addAttribute("events", events);

        return "scheduleResponseList";
    }

    @PostMapping("/submitResponses")
    public String submitResponses(@RequestParam("responses") String responsesJson) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            List<Attendance> responses = objectMapper.readValue(responsesJson, new TypeReference<List<Attendance>>() {});

            Long userId = (Long) session.getAttribute("user_id"); // セッションからuser_idを取得

            for (Attendance response : responses) {
                response.setUserId(userId); // user_idを設定
                attendanceService.saveAttendance(response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }

        return "responseResult";
    }
}
