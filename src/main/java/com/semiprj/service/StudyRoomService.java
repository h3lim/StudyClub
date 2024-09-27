package com.semiprj.service;

import com.semiprj.model.StudyRoomVO;

import java.util.List;

public interface StudyRoomService {
    public List<StudyRoomVO> svcRoomSelect(StudyRoomVO studyRoomVO);
    public int svcRoomInsert(StudyRoomVO studyRoomVO);
    public int svcRoomUpdate(StudyRoomVO studyRoomVO);
    public int svcRoomDelete(int roomId);
    public StudyRoomVO svcRoomFindById(int roomId);
}
