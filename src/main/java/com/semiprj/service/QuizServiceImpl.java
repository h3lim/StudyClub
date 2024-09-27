package com.semiprj.service;

import com.semiprj.mapper.QuizMapper;
import com.semiprj.model.QuizVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.semiprj.mapper.QuestionMapper;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class QuizServiceImpl {

    @Autowired
    private QuizMapper quizMapper;

    @Autowired
    private QuestionMapper questionMapper;

    public void svcInsertQuiz(QuizVO quiz) {
        quizMapper.insertQuiz(quiz);
    }

    public List<QuizVO> getQuizzesByUserNickname(String userNickname) {
        return quizMapper.getQuizzesByUserNickname(userNickname);
    }

    public QuizVO getQuizById(int quizSeq) {
        return quizMapper.getQuizById(quizSeq);
    }

    public void updateQuizStatusToComplete(int quizSeq) {
        quizMapper.updateQuizStatusToComplete(quizSeq);
    }

    public void svcUpdateQuiz(QuizVO quiz) {
        quizMapper.updateQuiz(quiz);
    }

    @Transactional
    public void deleteQuiz(int quizSeq) {
        quizMapper.deleteQuiz(quizSeq);
    }


}
