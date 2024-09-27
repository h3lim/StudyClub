package com.semiprj.service;


import com.semiprj.mapper.StudyRoomMapper;
import com.semiprj.model.StudyRoomVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudyRoomServiceImpl implements StudyRoomService {

     @Autowired
     StudyRoomMapper studyRoomMapper;


    @Override
    public List<StudyRoomVO> svcRoomSelect(StudyRoomVO studyRoomVO) {
        return studyRoomMapper.roomSelect(studyRoomVO);
    }

    @Override
    public int svcRoomInsert(StudyRoomVO studyRoomVO) {
        return studyRoomMapper.roomInsert(studyRoomVO);
    }

    @Override
    public int svcRoomUpdate(StudyRoomVO studyRoomVO) {
        return studyRoomMapper.roomUpdate(studyRoomVO);
    }

    @Override
    public int svcRoomDelete(int roomId) {
        return studyRoomMapper.roomDelete(roomId);
    }

    @Override
    public StudyRoomVO svcRoomFindById(int roomId) {
        return studyRoomMapper.roomFindById(roomId);
    }
}
