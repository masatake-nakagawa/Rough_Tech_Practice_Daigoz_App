package jp.co.hoge.web.service;

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
}
