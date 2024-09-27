package com.semiprj.mapper;

import java.util.ArrayList;
import java.util.List;

import com.semiprj.model.UserOauthVO;
import com.semiprj.model.UserVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface UserMapper {

	// 전체 회원 조회
	public List<UserVO> allUser();

	// 일반 회원 가입
	public void insertUser(UserVO uvo);

	// 일반 회원 이메일 업데이트
	public void updateEmail(UserVO uvo);

	// 일반 회원 비밀번호 업데이트
	public void updatePw(UserVO uvo);

	// 일반 회원 닉네임 업데이트
	public void updateNickname(UserVO uvo);

	// 회원 삭제
	public int userDelete(int seq);

	// 일반 로그인
	public UserVO formLogin(UserVO uvo);

	// 일반 회원가입
	public void formJoin(UserVO uvo);

	// OAuth 관련 메서드
	public UserVO findUserByEmail(String userEmail);

	public UserVO findUserByNickname(String userNickname);

	public void insertUserOauth(UserOauthVO ovo);

	public void updateUserOauth(UserOauthVO ovo);
}
