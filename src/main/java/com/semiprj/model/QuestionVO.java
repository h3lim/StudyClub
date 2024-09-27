package com.semiprj.model;

import lombok.Data;
import org.springframework.stereotype.Component;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Data
@Component
public class QuestionVO {
    private int questionSeq;
    private int quizSeq;
    @NotEmpty(message = "질문 내용을 입력하세요")
    private String questionText;
    private int correctAnswer;
    @NotEmpty(message = "선택지 1을 입력하세요")
    private String choice1;

    @NotEmpty(message = "선택지 2을 입력하세요")
    private String choice2;

    @NotEmpty(message = "선택지 3을 입력하세요")
    private String choice3;

    @NotEmpty(message = "선택지 4을 입력하세요")
    private String choice4;


    @NotNull(message = "답변을 선택하세요")
    private transient int userAnswer; // This will hold the user's selected answer during the quiz
}