package com.semiprj.mapper;

import com.semiprj.model.UserGradeVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UserGradeMapper {
    void insertUserGrade(UserGradeVO userGrade);

    UserGradeVO getLatestUserGrade(@Param("quizSeq") int quizSeq, @Param("userNickname") String userNickname);

    List<UserGradeVO> getUserGradesByQuizAndUser(@Param("quizSeq") int quizSeq, @Param("userNickname") String userNickname);
}