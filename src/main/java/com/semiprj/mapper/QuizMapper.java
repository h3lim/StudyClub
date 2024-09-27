package com.semiprj.mapper;

import com.semiprj.model.QuizVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface QuizMapper {

    void insertQuiz(QuizVO quiz);

    List<QuizVO> getQuizzesByUserNickname(String userNickname);

    QuizVO getQuizById(int quizSeq);

    void updateQuizStatusToComplete(int quizSeq);

    void updateQuiz(QuizVO quiz);

    void deleteQuiz(int quizSeq);
}

