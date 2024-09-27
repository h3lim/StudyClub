package com.semiprj.model;

import lombok.Data;
import org.springframework.stereotype.Component;

import java.util.ArrayList;

@Component
@Data
public class StudyRoomVO {
    private int roomId;
    private String roomName;
    private String roomDescription;
    private String roomDate;
    private int userCount;
    private int maxUserCount;
    private String roomPwd;
    private String userNickname;
    private ArrayList<UserVO> userList;
}
