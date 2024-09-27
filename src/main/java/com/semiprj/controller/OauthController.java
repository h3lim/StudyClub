package com.semiprj.controller;

import com.semiprj.model.UserOauthVO;
import com.semiprj.model.UserVO;
import com.semiprj.oauth.SocialType;
import com.semiprj.service.OauthServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

@Controller
public class OauthController {

	@Autowired
	private OauthServiceImpl oauthService;

	// 로그인 폼: 일반 로그인
	@RequestMapping(value = "/form_login_process", method = RequestMethod.POST)
	public String ctlFormLoginProcess(Model model, HttpServletRequest request,
									  @RequestParam("userEmail") String userEmail,
									  @RequestParam("userPW") String userPw) {

		// 입력값 유효성 검사
		if (userEmail == null || userEmail.isEmpty() || userPw == null || userPw.isEmpty()) {
			model.addAttribute("error", "이메일과 비밀번호를 입력해주세요.");
			return "user/login"; // 로그인 페이지로 리다이렉트
		}

		UserVO paramVO = new UserVO();
		paramVO.setUserEmail(userEmail);
		paramVO.setUserPw(userPw);
		UserVO uvo = oauthService.svcFormLogin(paramVO);

		// 로그인 성공
		if (uvo != null) {
			HttpSession session = request.getSession();
			session.setAttribute("SESS_USER", uvo);
			session.setAttribute("SESS_EMAIL", uvo.getUserEmail());
			session.setAttribute("SESS_PW", uvo.getUserPw());
			session.setAttribute("userNickname", uvo.getUserNickname());
			session.setAttribute("SESS_PROVIDER", "local");
			session.setAttribute("SESS_GUBUN", "u");
			session.setAttribute("SESS_PICTURE", "https://icons.veryicon.com/png/o/miscellaneous/youyinzhibo/guest.png");
			session.setAttribute("SESS_USERSEQ", uvo.getUserSeq()); // 사용자 시퀀스를 세션에 저장
			session.setMaxInactiveInterval(10 * 60);
			model.addAttribute("MY_USERSVO", uvo);

			return "redirect:/user/mypage.jsp"; // 마이페이지로 이동
		} else {
			// 이메일이나 비밀번호가 틀린 경우
			if (!oauthService.isEmailExists(userEmail)) {
				model.addAttribute("error", "이메일이 일치하지 않습니다.");
			} else {
				model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
			}
			model.addAttribute("userEmail", userEmail); // 이메일 유지
			return "user/login"; // 로그인 페이지로 리다이렉트
		}
	}



	// 로그아웃
	@RequestMapping(value = "/form_logout_process", method = RequestMethod.POST)
	public String ctlFormLogoutProcess(HttpServletRequest request) {
		request.getSession().invalidate();
		request.getSession().setMaxInactiveInterval(0);
		return "redirect:/user/login.jsp"; // 로그인 페이지로 리다이렉트
	}

	// 마이페이지
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String ctlViewMypage(Model model, HttpServletRequest request) {
		return "user/mypage"; // 마이페이지로 이동
	}

	// 로그인 페이지
	@RequestMapping(value = "/login_page", method = RequestMethod.GET)
	public String ctlViewLoginPage(Model model) {
		return "user/login"; // 로그인 페이지로 이동
	}

	// 회원가입
	@RequestMapping(value = "/form_join_process", method = RequestMethod.POST)
	public String ctlFormJoinProcess(Model model, HttpServletRequest request,
									 @ModelAttribute UserVO uvo,
									 @RequestParam String confirmPassword) {
		uvo.setUserProvider("local");

		// 유효성 검사
		if (uvo.getUserEmail() == null || uvo.getUserEmail().isEmpty() ||
				uvo.getUserNickname() == null || uvo.getUserNickname().isEmpty() ||
				uvo.getUserPw() == null || uvo.getUserPw().isEmpty()) {
			model.addAttribute("error", "이메일, 닉네임, 비밀번호를 입력해주세요.");
			return "user/register"; // 등록 페이지로 돌아감
		}

		// 비밀번호 확인
		if (!uvo.getUserPw().equals(confirmPassword)) {
			model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
			model.addAttribute("userEmail", uvo.getUserEmail());
			model.addAttribute("userNickname", uvo.getUserNickname());
			return "user/register"; // 등록 페이지로 돌아감
		}

		// 이메일 중복 체크
		if (oauthService.isEmailExists(uvo.getUserEmail())) {
			model.addAttribute("error", "이메일이 이미 있습니다.");
			model.addAttribute("userNickname", uvo.getUserNickname());
			return "user/register"; // 등록 페이지로 돌아감
		}

		// 닉네임 중복 체크
		if (oauthService.isNicknameExists(uvo.getUserNickname())) {
			model.addAttribute("error", "닉네임이 이미 있습니다.");
			model.addAttribute("userEmail", uvo.getUserEmail());
			return "user/register"; // 등록 페이지로 돌아감
		}

		// 사용자 등록
		oauthService.svcFormJoin(uvo);
		return "redirect:/user/login.jsp"; // 성공 시 로그인 페이지로 이동
	}

	// 구글/네이버/카카오 로그인
	@RequestMapping(value = "/login/{socialType}", method = RequestMethod.GET)
	public String loginForm(Model model, @PathVariable("socialType") SocialType socialType, HttpServletRequest request) {
		String loginFormUrl = oauthService.svcLoginFormURL(socialType);
		request.getSession().setAttribute("SESS_SOCIALTYPE", socialType.name()); // SocialType enum 사용
		return "redirect:" + loginFormUrl;
	}

	// OAuth 콜백
	@RequestMapping(value = "/oauth2callback/{socialType}", method = RequestMethod.GET)
	public String ctlCallback(Model model,
							  @PathVariable("socialType") SocialType socialType,
							  @RequestParam("code") String code,
							  HttpServletRequest request) {
		// 세션 초기화
		request.getSession().invalidate();
		request.getSession(true); // 새로운 세션 생성

		// CODE를 사용해 ACCESS TOKEN 받기
		Map<String, String> responseMap = oauthService.svcRequestAccessToken(socialType, code);
		String accessToken = responseMap.get("access_token");
		String refreshToken = responseMap.get("refresh_token");

		// ACCESS TOKEN을 사용해 REST 서비스(유저정보) 받기
		Map<String, String> userInfo = oauthService.svcRequestUserInfo(socialType, accessToken);
		System.out.println(userInfo.toString());

		if (userInfo == null) {
			// 사용자 정보를 가져오지 못한 경우
			model.addAttribute("error", "사용자 정보를 가져오지 못했습니다.");
			return "redirect:/login_page.jsp"; // 로그인 페이지로 리다이렉트
		}

		String userEmail = userInfo.get("email");
		UserVO existingUserVO = oauthService.svcCheckExistUser(userEmail);

		if (existingUserVO == null) {
			// 신규 회원 처리

			request.getSession().setAttribute("SESS_EMAIL", userEmail);
			request.getSession().setAttribute("SESS_PROVIDER", socialType.name()); // SocialType 사용
			request.getSession().setAttribute("SESS_PICTURE", userInfo.get("picture"));
			request.getSession().setAttribute("SESS_ACCESS_TOKEN", accessToken);
			request.getSession().setAttribute("SESS_REFRESH_TOKEN", refreshToken);

			return "user/oauth_join_page"; // 회원가입 페이지로 이동
		} else {
			// 기존 회원 처리
			UserOauthVO ovo = new UserOauthVO();
			ovo.setAccessToken(accessToken);
			ovo.setRefreshToken(refreshToken);
			ovo.setUserSeq(existingUserVO.getUserSeq());
			oauthService.svcUpdateToken(ovo);

			// 세션에 정보 설정
			request.getSession().setAttribute("SESS_USER", existingUserVO);
			request.getSession().setAttribute("SESS_EMAIL", userEmail);
			request.getSession().setAttribute("SESS_PROVIDER", socialType.name()); // SocialType 사용
			request.getSession().setAttribute("SESS_ACCESS_TOKEN", accessToken);
			request.getSession().setAttribute("SESS_REFRESH_TOKEN", refreshToken);
			request.getSession().setAttribute("SESS_NICKNAME", existingUserVO.getUserNickname()); // 닉네임 설정
			request.getSession().setAttribute("SESS_GUBUN", "u");
			request.getSession().setAttribute("SESS_USERSEQ", existingUserVO.getUserSeq()); // USER_SEQ 설정

			return "redirect:/user/mypage.jsp"; // 마이페이지로 이동
		}
	}


	// OAuth 신규회원 처리
	@RequestMapping(value = "/oauth_join_process", method = RequestMethod.POST)
	public String ctlOauthJoinProcess(Model model, HttpServletRequest request,
									  @ModelAttribute UserVO uvo) {

		// 세션에서 이메일과 소셜 제공자 정보 가져오기
		String userEmail = (String) request.getSession().getAttribute("SESS_EMAIL");
		String userProvider = request.getSession().getAttribute("SESS_PROVIDER").toString();

		// 입력된 닉네임 중복 체크
		if (oauthService.isNicknameExists(uvo.getUserNickname())) {
			model.addAttribute("error", "닉네임이 이미 존재합니다.");
			model.addAttribute("userEmail", userEmail); // 이메일 정보 유지
			model.addAttribute("userNickname", uvo.getUserNickname()); // 입력된 닉네임 유지
			return "user/oauth_join_page"; // 등록 페이지로 돌아감
		}

		// 사용자 OAuth 정보 설정
		UserOauthVO ovo = new UserOauthVO();
		ovo.setAccessToken((String) request.getSession().getAttribute("SESS_ACCESS_TOKEN"));
		ovo.setRefreshToken((String) request.getSession().getAttribute("SESS_REFRESH_TOKEN"));
		ovo.setUpdateDate(new Timestamp(System.currentTimeMillis())); // Timestamp 사용

		uvo.setUserEmail(userEmail);
		uvo.setUserProvider(userProvider);
		uvo.setUserOauthVO(ovo);

		// 사용자 토큰 DB에 삽입
		int insertUserSeq = oauthService.svcInsertToken(uvo);

		if (insertUserSeq < 0) {
			// 회원가입 실패
			request.getSession().invalidate();
			model.addAttribute("error", "회원가입에 실패했습니다.");
			return "user/login"; // 로그인 페이지로 리다이렉트
		} else {
			// 회원가입 성공
			request.getSession().setAttribute("SESS_NICKNAME", uvo.getUserNickname());
			request.getSession().setAttribute("SESS_USER", uvo); // 세션에 사용자 정보 저장
			return "redirect:/user/mypage.jsp"; // 마이페이지로 이동
		}
	}



	// 이메일 업데이트 요청 처리
	@RequestMapping(value = "/updateEmail", method = RequestMethod.POST)
	public String updateEmail(@RequestParam("userEmail") String userEmail,
							  @RequestParam("userNickname") String userNickname,
							  HttpSession session, Model model) {
		UserVO uvo = new UserVO();
		uvo.setUserEmail(userEmail);
		uvo.setUserNickname(userNickname);

		// 이메일 업데이트
		oauthService.updateEmail(uvo);

		// 업데이트 후 새로운 이메일 세션에 설정
		session.setAttribute("SESS_EMAIL", userEmail);
		model.addAttribute("message", "이메일이 성공적으로 업데이트되었습니다.");

		return "/user/mypage"; // 마이페이지로 리다이렉트
	}

	// 비밀번호 업데이트 요청 처리
	@RequestMapping(value = "/updatePw", method = RequestMethod.POST)
	public String updatePw(@RequestParam("userPw") String userPw, HttpSession session, Model model) {
		String userEmail = (String) session.getAttribute("SESS_EMAIL");

		UserVO uvo = new UserVO();
		uvo.setUserPw(userPw);
		uvo.setUserEmail(userEmail); // 이메일 설정

		// 비밀번호 유효성 검사 추가
		if (userPw == null || userPw.isEmpty()) {
			model.addAttribute("error", "비밀번호를 입력해주세요.");
			return "/user/mypage"; // 마이페이지로 리다이렉트
		}

		oauthService.updatePw(uvo);

		// 세션에 새 비밀번호 저장
		session.setAttribute("SESS_PW", userPw);
		model.addAttribute("message", "비밀번호가 성공적으로 업데이트되었습니다.");

		return "/user/mypage"; // 마이페이지로 리다이렉트
	}

	// 닉네임 업데이트 요청 처리
	@RequestMapping(value = "/updateNickname", method = RequestMethod.POST)
	public String updateNickname(@RequestParam("userNickname") String userNickname, HttpSession session, Model model) {
		String userEmail = (String) session.getAttribute("SESS_EMAIL");

		UserVO uvo = new UserVO();
		uvo.setUserNickname(userNickname);
		uvo.setUserEmail(userEmail); // 이메일 설정

		oauthService.updateNickname(uvo);

		// 세션에 새로운 닉네임 설정
		session.setAttribute("SESS_NICKNAME", userNickname);
		model.addAttribute("message", "닉네임이 성공적으로 업데이트되었습니다.");

		return "/user/mypage"; // 마이페이지로 리다이렉트
	}

	// 회원 탈퇴 요청 처리
	@RequestMapping(value="/userDelete", method = RequestMethod.POST)
	public String userDelete (@RequestParam int userSeq, HttpServletRequest request) {
		int deleteRows = oauthService.userDelete(userSeq);
		System.out.println("삭제 : " + deleteRows);
		request.getSession().invalidate();
		request.getSession().setMaxInactiveInterval(0);
		return "redirect:/user/index.jsp";
	}

	@RequestMapping(value="/allUser", method = RequestMethod.POST)
	public String allUser(Model model) {
		List<UserVO> list = oauthService.allUser();
		System.out.println(list.toString());
		model.addAttribute("USER_LIST", list); // 사용자 목록을 모델에 추가

		return "user/admin"; // admin.jsp로 직접 이동
	}

}