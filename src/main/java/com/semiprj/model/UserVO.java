package com.semiprj.model;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class UserVO {
    private int userSeq;              // USER_SEQ
    private String userEmail;         // USER_EMAIL
    private String userPw;            // USER_PW
    private String userNickname;      // USER_NICKNAME
    private Timestamp userDate;       // USER_DATE
    private String userProvider;       // USER_PROVIDER
    private String userGubun;
    private String confirmPassword;

    private UserOauthVO userOauthVO;  // UserOauthVO instance
}