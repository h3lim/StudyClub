package com.semiprj.model;

import lombok.Data;
import org.springframework.stereotype.Component;

import java.util.Date;

@Data
@Component
public class UserGradeVO {
    private int gradeSeq;
    private int quizSeq;
    private String userNickname;
    private int score;
    private int totalQuestions;
    private Date submitDate;
}