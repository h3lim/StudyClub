package com.semiprj.service;

import com.semiprj.mapper.UserMapper;
import com.semiprj.model.UserOauthVO;
import com.semiprj.model.UserVO;
import com.semiprj.oauth.Oauth;
import com.semiprj.oauth.SocialType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class OauthServiceImpl {

	@Autowired
	private List<Oauth> socialOauthList;

	@Autowired
	private UserMapper userMapper;

	// OAuth :: GOOGLE/KAKAO/NAVER Oauth 클래스 인스턴스 가져오기
	public Oauth getSocialInstance(SocialType socialType) {
		return socialOauthList.stream()
				.filter(x -> x.type() == socialType)
				.findFirst()
				.orElseThrow(() -> new IllegalArgumentException("Unknown SocialType"));
	}

	// OAuth :: 로그인창 URL 가져오기
	public String svcLoginFormURL(SocialType socialType) {
		Oauth socialOauth = getSocialInstance(socialType);
		return socialOauth.getLoginFormURL();
	}

	// OAuth :: 콜백URL을 통한 엑세스 토큰 발급
	public Map<String, String> svcRequestAccessToken(SocialType socialType, String code) {
		Oauth socialOauth = getSocialInstance(socialType);
		return socialOauth.requestAccessToken(code);
	}

	// OAuth :: 엑세스 토큰을 사용한 구글 서비스(profile) 가져오기
	public Map<String, String> svcRequestUserInfo(SocialType socialType, String accessToken) {
		Oauth socialOauth = getSocialInstance(socialType);
		return socialOauth.getUserInfo(accessToken);
	}

	// OAuth :: 기존회원/신규회원 구분을 위한 DB조회
	public UserVO svcCheckExistUser(String email) {
		return userMapper.findUserByEmail(email);
	}

	// OAuth :: 신규회원: 회원정보 저장 + 토큰 저장
	public int svcInsertToken(UserVO uvo) {
		userMapper.insertUser(uvo);
		System.out.println("SEQ CURRVAL: " + uvo.getUserSeq());

		// user_tbl에 입력한 user_seq 시퀀스번호를 user_oauth의 user_seq값으로 사용
		uvo.getUserOauthVO().setUserSeq(uvo.getUserSeq());
		userMapper.insertUserOauth(uvo.getUserOauthVO());
		return uvo.getUserSeq();
	}

	// OAuth :: 기존회원: 토큰 갱신
	public void svcUpdateToken(UserOauthVO ovo) {
		userMapper.updateUserOauth(ovo);
	}

	// 일반유저 회원가입
	public void svcFormJoin(UserVO uvo) {
		userMapper.formJoin(uvo);
	}

	// 일반유저 로그인
	public UserVO svcFormLogin(UserVO uvo) {
		return userMapper.formLogin(uvo);
	}

	public List<UserVO> allUser () {
		return userMapper.allUser();
	}

	public boolean isEmailExists(String email) {
		return userMapper.findUserByEmail(email) != null;
	}

	public boolean isNicknameExists(String nickname) {
		return userMapper.findUserByNickname(nickname) != null;
	}


	public void updateEmail(UserVO uvo) {
		userMapper.updateEmail(uvo);
	}

	// 일반 회원 비밀번호 업데이트
	public void updatePw(UserVO uvo) {
		userMapper.updatePw(uvo);

	}

	// 일반 회원 닉네임 업데이트
	public void updateNickname(UserVO uvo) {
		userMapper.updateNickname(uvo);
	}

	// 회원 삭제
	public int userDelete (int userSeq) {
		return userMapper.userDelete(userSeq);
	}
}
