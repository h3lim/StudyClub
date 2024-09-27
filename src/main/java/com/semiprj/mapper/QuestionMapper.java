package com.semiprj.mapper;

import com.semiprj.model.QuestionVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface QuestionMapper {
    void insertQuestion(QuestionVO questionVO);

    List<QuestionVO> getQuestionsByQuizId(int quizSeq);

    void updateQuestion(QuestionVO questionVO);

    void deleteQuestion(int questionSeq);

}
