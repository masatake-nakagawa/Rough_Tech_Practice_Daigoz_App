package jp.co.hoge.web.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import jp.co.hoge.web.entity.Event;

@Repository
public interface EventRepository extends JpaRepository<Event, Long> {

    @Query("SELECT COALESCE(MAX(e.eventId), 0) FROM Event e")
    int findMaxEventId();

    List<Event> findAll();
}
