package com.example.gymsystem.service;

import com.example.gymsystem.model.Schedule;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.List;

@Service
public class GymService {
    private List<Schedule> scheduleList = new ArrayList<>();

    public String getPaymentStatus(String memberId) { return "APPROVED"; }
    public String getMemberPackage(String memberId) { return "GOLD"; }
    public List<Schedule> getAllSchedules() { return scheduleList; }
    public void saveSchedule(Schedule s) { scheduleList.add(s); }

    public long getSlotCount(String slot) {
        return scheduleList.stream()
                .filter(s -> s.getTimeSlot().equals(slot) && s.getStatus().equals("BOOKED"))
                .count();
    }

    public void updateStatusToDeleted(String memberId, String timeSlot, String trainer) {
        for (Schedule s : scheduleList) {
            if (s.getMemberId().equals(memberId) && s.getTimeSlot().equals(timeSlot) &&
                    s.getTrainer().equals(trainer) && s.getStatus().equals("BOOKED")) {
                s.setStatus("DELETED");
                break;
            }
        }
    }
}