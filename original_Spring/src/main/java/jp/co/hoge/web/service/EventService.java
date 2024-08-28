package jp.co.hoge.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jp.co.hoge.web.entity.Event;
import jp.co.hoge.web.repository.EventRepository;

@Service
public class EventService {

    @Autowired
    private EventRepository eventRepository;

    public void saveEvent(Event event) {
        eventRepository.save(event);
    }

    public int getMaxEventId() {
        return eventRepository.findMaxEventId();
    }

    public List<Event> getAllEvents() {
        return eventRepository.findAll();
    }

    // イベントIDでイベントを取得するメソッドを追加
    public Event getEventById(Long eventId) {
        return eventRepository.findById(eventId).orElse(null);
    }

    // イベントを更新するメソッドを追加
    public void updateEvent(Event event) {
        eventRepository.save(event);
    }
}
