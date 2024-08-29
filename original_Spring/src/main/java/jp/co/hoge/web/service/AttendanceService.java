package jp.co.hoge.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jp.co.hoge.web.entity.Attendance;
import jp.co.hoge.web.repository.AttendanceRepository;

@Service
public class AttendanceService {

    @Autowired
    private AttendanceRepository attendanceRepository;

    public void saveAttendance(Attendance attendance) {
        attendanceRepository.save(attendance);
    }

    public List<Attendance> getAllAttendances() {
        return attendanceRepository.findAll();
    }

    public List<Attendance> getAttendancesByEventId(Long eventId) {
        return attendanceRepository.findByEventId(eventId);
    }
}

