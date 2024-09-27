package com.semiprj.model;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;
import lombok.Data;

@Component
@Data
public class UserOauthVO {
	private int userSeq;               // USER_SEQ
	private String accessToken;        // USER_ACCESSTOKEN
	private String refreshToken;       // USER_REFRESHTOKEN
	private Timestamp updateDate;      // USER_UPDATEDATE
}
