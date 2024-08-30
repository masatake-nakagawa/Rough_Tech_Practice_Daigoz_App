package jp.co.hoge.web.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import jp.co.hoge.web.entity.Attendance;

@Repository
public interface AttendanceRepository extends JpaRepository<Attendance, Long> {
    List<Attendance> findByEventId(Long eventId);
    void deleteByUserId(String userId); // 既存のメソッド
    void deleteByUserId(Long userId); // 新しく追加するメソッド
}
