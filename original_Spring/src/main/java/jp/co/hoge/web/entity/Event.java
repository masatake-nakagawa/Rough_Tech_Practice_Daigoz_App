package jp.co.hoge.web.entity;

import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Event {

    @Id
    private Long event_id; // 修正
    private String eventName;
    private Timestamp dateAndTime;
    private String venue;
    private String text;
    private int number;

    // コンストラクタ
    public Event() {}

    public Event(Long event_id, String eventName, Timestamp dateAndTime, String venue, String text, int number) {
        this.event_id = event_id;
        this.eventName = eventName;
        this.dateAndTime = dateAndTime;
        this.venue = venue;
        this.text = text;
        this.number = number;
    }

    public Event(String eventName, Timestamp dateAndTime, String venue, String text, int number) {
        this.eventName = eventName;
        this.dateAndTime = dateAndTime;
        this.venue = venue;
        this.text = text;
        this.number = number;
    }

    // ゲッターとセッター
    public Long getEvent_id() {
        return event_id;
    }

    public void setEvent_id(Long event_id) {
        this.event_id = event_id;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public Timestamp getDateAndTime() {
        return dateAndTime;
    }

    public void setDateAndTime(Timestamp dateAndTime) {
        this.dateAndTime = dateAndTime;
    }

    public String getVenue() {
        return venue;
    }

    public void setVenue(String venue) {
        this.venue = venue;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }
}


