package com.semiprj.controller;


import com.semiprj.model.StudyRoomVO;
import com.semiprj.service.StudyRoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;

@Controller
public class StudyRoomCtl {

    @Autowired
    private StudyRoomService studyRoomService;

    @CrossOrigin(origins = "https://jw7469.iptime.org:8447")
    @GetMapping(value = "/video")
    public String video(Model model, @RequestParam("roomId") int roomId) {
        StudyRoomVO roomVO = studyRoomService.svcRoomFindById(roomId);
        model.addAttribute("roomVO", roomVO);
        return "webRTCtemp";
    }

    @PostMapping(value = "/checkPassword")
    public String chackPassword(@RequestParam("roomId") int roomId, @RequestParam("password") String passPwd, Model model) {
        StudyRoomVO studyRoomVO = studyRoomService.svcRoomFindById(roomId);
        if(studyRoomVO != null && studyRoomVO.getRoomPwd().equals(passPwd)){
            return "redirect:/roomDetail?roomId=" + roomId;
        } else {
            model.addAttribute("errorMessage", "패스워드가 올바르지 않습니다.");
            return ctlRoomSelect(model);
        }

    }
    @GetMapping(value = "/roomList")
    public String ctlRoomSelect(Model model) {
        StudyRoomVO studyRoomVO = new StudyRoomVO();
        ArrayList<StudyRoomVO> roomList = (ArrayList)studyRoomService.svcRoomSelect(studyRoomVO);
        System.out.println("Room List: " + roomList);
        model.addAttribute("KEY_ROOMLIST", roomList);
        return "studyroom/roomList";
    }

    @GetMapping(value="/roomInsert")
    public String ctlRoomInsert(Model model) {
        return "studyroom/roomInsertForm";

    }
    @PostMapping(value = "/roomInsert")
    public String ctlRoomInsert(@ModelAttribute StudyRoomVO studyRoomVO) {
        int insertRows = studyRoomService.svcRoomInsert(studyRoomVO);
        System.out.println(studyRoomVO.getUserNickname());
        return "redirect:/roomList";
    }

    @GetMapping(value = "/roomDetail")
    public String ctlRoomDetail(Model model, @RequestParam("roomId") int roomId) {
        StudyRoomVO studyRoomVO = studyRoomService.svcRoomFindById(roomId);
        model.addAttribute("KEY_ROOMVO", studyRoomVO);
        return "studyroom/roomDetail";
    }

    @GetMapping(value="/roomUpdate")
    public String showRoomUpdate(Model model, @RequestParam("roomId") int roomId) {
    StudyRoomVO studyRoomVO = studyRoomService.svcRoomFindById(roomId);
    model.addAttribute("KEY_ROOMVO", studyRoomVO);
    return "studyroom/roomUpdateForm";

    }
    @PostMapping(value = "/roomUpdate")
    public String ctlRoomUpdate(Model model, @ModelAttribute StudyRoomVO studyRoomVO) {
        int updateRows = studyRoomService.svcRoomUpdate(studyRoomVO);
        return "redirect:/roomDetail?roomId=" + studyRoomVO.getRoomId();
    }

    @PostMapping(value = "/roomDelete")
    public String ctlRoomDelete(Model model, @RequestParam("roomId") int roomId) {
        int deleteRows = studyRoomService.svcRoomDelete(roomId);
        return "redirect:/roomList";
    }
}
