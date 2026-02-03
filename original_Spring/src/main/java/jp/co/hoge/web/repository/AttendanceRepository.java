package jp.co.hoge.web.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import jp.co.hoge.web.entity.Attendance;

@Repository
public interface AttendanceRepository extends JpaRepository<Attendance, Long> {
    List<Attendance> findByEventId(Long eventId);

    // String型の方は削除し、Long型だけを残します
    void deleteByUserId(Long userId); 
}