package com.semiprj.service;

import com.semiprj.mapper.UserGradeMapper;
import com.semiprj.model.UserGradeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserGradeServiceImpl {

    @Autowired
    private UserGradeMapper userGradeMapper;

    @Transactional
    public void svcInsertUserGrade(UserGradeVO userGradeVO) {
        userGradeMapper.insertUserGrade(userGradeVO);
    }

    public UserGradeVO getLatestUserGrade(int quizSeq, String userNickname) {
        return userGradeMapper.getLatestUserGrade(quizSeq, userNickname);
    }

    public List<UserGradeVO> getUserGradesByQuizAndUser(int quizSeq, String userNickname) {
        return userGradeMapper.getUserGradesByQuizAndUser(quizSeq, userNickname);
    }
}
