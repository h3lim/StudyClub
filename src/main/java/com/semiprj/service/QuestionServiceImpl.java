package com.semiprj.service;

import com.semiprj.mapper.QuestionMapper;
import com.semiprj.model.QuestionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class QuestionServiceImpl {

    @Autowired
    private QuestionMapper questionMapper;

    @Transactional
    public void svcInsertQuestion(QuestionVO questionVO) {
        questionMapper.insertQuestion(questionVO);
    }

    public List<QuestionVO> getQuestionsByQuizId(int quizSeq) {
        return questionMapper.getQuestionsByQuizId(quizSeq);
    }


    public void deleteQuestion(int questionSeq) {
        questionMapper.deleteQuestion(questionSeq);  // Implement the method
    }

    @Transactional
    public void svcUpdateQuestion(QuestionVO questionVO) {
        questionMapper.updateQuestion(questionVO);
    }

}
