package com.semiprj.model;

import lombok.Data;
import org.springframework.stereotype.Component;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import java.util.Date;

@Data
@Component
public class QuizVO {
    private int quizSeq;

    @NotBlank(message = "퀴즈 제목을 입력하세요.")
    private String quizTitle;

    @NotNull(message = "질문 수를 입력하세요.")
    @Min(value = 1, message = "질문 수를 다시 설정해주세요.")
    private Integer questionCnt;

    private String userNickname;
    private Date regdate;
    private String status;


}