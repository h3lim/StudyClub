package com.semiprj.mapper;


import com.semiprj.model.StudyRoomVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface StudyRoomMapper {
    public List<StudyRoomVO> roomSelect(StudyRoomVO studyRoomVO);
    public int roomInsert(StudyRoomVO studyRoomVO);
    public int roomUpdate(StudyRoomVO studyRoomVO);
    public int roomDelete(int roomId);
    public StudyRoomVO roomFindById(int roomId);


}
