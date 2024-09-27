package com.semiprj.model;

import lombok.Data;
import org.springframework.stereotype.Component;
import java.util.List;

@Data
@Component
public class QuizForm {
    private int quizSeq;
    private String quizTitle;
    private int questionCnt;
    private String userNickname;
    private List<QuestionVO> questions;


}
