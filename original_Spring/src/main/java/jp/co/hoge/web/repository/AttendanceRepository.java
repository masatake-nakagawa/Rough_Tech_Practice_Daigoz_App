package jp.co.hoge.web.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import jp.co.hoge.web.entity.Attendance;

public interface AttendanceRepository extends JpaRepository<Attendance, Long> {
    List<Attendance> findByEventId(Long eventId);
}
