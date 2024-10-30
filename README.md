# STUDYCLUB

STUDYCLUB은 실시간 화상 회의, 채팅, 자유게시판 및 퀴즈 기능을 통해 스터디 활동을 제공하는 웹 애플리케이션입니다. 사용자는 OAuth를 통해 소셜 로그인을 할 수 있으며, 스터디 룸을 생성하여 화상 회의와 채팅을 진행하거나 퀴즈 기능을 통해 스터디 활동을 진행 할 수 있습니다.  

## 목차
- [프로젝트 구조](#프로젝트-구조)
- [주요 기능](#주요-기능)
  - [실시간 화상 회의 및 채팅](#실시간-화상-회의-및-채팅)
  - [사용자 관리 및 소셜 로그인](#사용자-관리-및-소셜-로그인)
  - [게시판 및 댓글 기능](#게시판-및-댓글-기능)
  - [퀴즈 생성 및 풀이](#퀴즈-생성-및-풀이)
- [사용 기술](#사용-기술)
  - [백엔드](#백엔드)
  - [프론트엔드](#프론트엔드)
  - [API](#api)
  - [서버](#서버)
  - [데이터베이스](#데이터베이스)
  - [빌드 도구](#빌드-도구)
- [참고 사항](#참고-사항)
  - [CORS 설정](#cors-설정)
  - [OAuth 설정](#oauth-설정)
  - [SSE 연결](#sse-연결)
  - [로컬 개발 환경](#로컬-개발-환경)

---
## 프로젝트 구조

```bash
STUDYCLUB
└── src
    └── main
        └── java
            └── com
                └── semiprj
                    ├── cap                      # 이벤트 관련 처리 클래스 모음
                    │   ├── AnswerEvent.java          # 특정 조건에서의 답변 이벤트를 처리
                    │   ├── ConnectEvent.java         # 사용자 연결 이벤트를 처리
                    │   ├── EmitterWrapper.java       # SSE Emitter 객체를 감싸는 래퍼 클래스
                    │   ├── EventCapture.java         # 이벤트 처리 인터페이스 정의
                    │   ├── JoinEvent.java            # 사용자 참여 이벤트를 처리
                    │   └── OfferEvent.java           # 특정 조건에서의 제안 이벤트를 처리
                    ├── config                    # 웹 및 소켓 설정과 기본 컨트롤러
                    │   ├── ChatController.java       # 채팅 관련 웹 페이지 연결을 위한 컨트롤러
                    │   ├── MyController.java         # 테스트용 컨트롤러
                    │   ├── MyWebSocketHandler.java   # WebSocket 연결 및 메시지 처리를 위한 핸들러
                    │   ├── WebMvcConfig.java         # Web MVC 설정, CORS 설정 포함
                    │   └── WebSocketConfig.java      # WebSocket 설정
                    ├── controller                # 주요 기능을 제공하는 웹 컨트롤러
                    │   ├── FreeBoardController.java  # 자유게시판 기능을 처리하는 컨트롤러
                    │   ├── OauthController.java      # OAuth 인증 및 사용자 관리 처리
                    │   ├── QuizController.java       # 퀴즈 관련 기능을 처리하는 컨트롤러
                    │   ├── ReplyController.java      # 댓글 기능을 처리하는 컨트롤러
                    │   └── StudyRoomCtl.java         # 스터디 룸 관리 기능을 처리하는 컨트롤러
                    ├── ctr                      # SSE 및 카메라 관련 API 제공 컨트롤러
                    │   ├── CamController.java        # 카메라(화상) 관련 기능 제공
                    │   └── SSEController.java        # 서버 간 실시간 이벤트 기능 제공
                    ├── data                     # 데이터 관련 클래스 및 객체 정의
                    │   ├── CamClient.java            # 카메라 클라이언트 정보
                    │   ├── HandleEvent.java          # 이벤트 데이터 클래스
                    │   ├── Room.java                 # 스터디 룸 정보
                    │   ├── RoomAccessInfo.java       # 스터디 룸 접근 정보
                    │   └── RoomStateEventHandler.java # 룸 상태 이벤트 핸들러
                    ├── mapper                   # 데이터베이스 접근을 위한 매퍼 인터페이스
                    │   ├── FreeBoardMapper.java      # 자유게시판 관련 DB 접근 인터페이스
                    │   ├── QuestionMapper.java       # 질문 관련 DB 접근 인터페이스
                    │   ├── QuizMapper.java           # 퀴즈 관련 DB 접근 인터페이스
                    │   ├── ReplyMapper.java          # 댓글 관련 DB 접근 인터페이스
                    │   ├── StudyRoomMapper.java      # 스터디 룸 관련 DB 접근 인터페이스
                    │   └── UserGradeMapper.java      # 사용자 점수 관련 DB 접근 인터페이스
                    ├── model                    # 주요 데이터 모델 클래스
                    │   ├── FreeBoardVO.java          # 자유게시판 게시글 객체
                    │   ├── QuestionVO.java           # 퀴즈 질문 객체
                    │   ├── QuizForm.java             # 퀴즈 폼 객체
                    │   ├── QuizVO.java               # 퀴즈 객체
                    │   ├── ReplyVO.java              # 댓글 객체
                    │   ├── StudyRoomVO.java          # 스터디 룸 객체
                    │   ├── UserGradeVO.java          # 사용자 점수 객체
                    │   ├── UserOauthVO.java          # 사용자 OAuth 정보 객체
                    │   └── UserVO.java               # 사용자 정보 객체
                    ├── oauth                    # OAuth 관련 클래스
                    │   ├── GoogleOauth.java         # 구글 OAuth 처리 클래스
                    │   ├── KakaoOauth.java          # 카카오 OAuth 처리 클래스
                    │   ├── NaverOauth.java          # 네이버 OAuth 처리 클래스
                    │   ├── Oauth.java               # OAuth 인터페이스
                    │   └── SocialType.java          # 소셜 로그인 타입 열거형
                    ├── service                  # 비즈니스 로직 처리 클래스 모음
                    │   ├── FreeBoardService.java    # 자유게시판 서비스 인터페이스
                    │   ├── FreeBoardServiceImpl.java# 자유게시판 서비스 구현체
                    │   ├── OauthServiceImpl.java    # OAuth 서비스 구현체
                    │   ├── QuestionServiceImpl.java # 질문 서비스 구현체
                    │   ├── QuizServiceImpl.java     # 퀴즈 서비스 구현체
                    │   ├── ReplyService.java        # 댓글 서비스 인터페이스
                    │   ├── ReplyServiceImpl.java    # 댓글 서비스 구현체
                    │   ├── StudyRoomService.java    # 스터디 룸 서비스 인터페이스
                    │   ├── StudyRoomServiceImpl.java# 스터디 룸 서비스 구현체
                    │   ├── TokenAspect.java         # 토큰 만료 처리 AOP 클래스
                    │   └── UserGradeServiceImpl.java# 사용자 점수 서비스 구현체
                    └── srv                       # 서버 관련 클래스
                        ├── RoomService.java         # 스터디 룸 생성 및 관리 서비스
                        └── SSEService.java          # SSE 실시간 이벤트 관리 서비스
                    └── util                     # 공통 유틸리티 클래스
                        ├── PageCreator.java         # 페이지네이션 기능 클래스
                        └── PageVO.java              # 페이지 정보 객체

```

## 주요 기능

### 실시간 화상 회의 및 채팅

- **화상 회의**: 스터디 룸 생성 및 참여 기능. 카메라를 통해 실시간으로 화상 회의 가능.
- **SSE 실시간 채팅**: 서버 간 이벤트 전송을 사용해 참여자 간 실시간 채팅을 지원.

### 사용자 관리 및 소셜 로그인

- **OAuth 로그인**: Google, Kakao, Naver 계정을 통한 소셜 로그인 기능.
- **사용자 정보 관리**: 프로필 정보, 비밀번호 업데이트, 회원가입 및 회원탈퇴 기능.

### 게시판 및 댓글 기능

- **자유게시판**: 사용자 간 소통을 위한 게시글 등록, 수정, 삭제 기능.
- **댓글 기능**: 게시글에 댓글 작성, 수정, 삭제 기능을 제공.

### 퀴즈 생성 및 풀이

- **퀴즈 생성 및 수정**: 사용자 본인의 퀴즈를 생성하고, 문제와 정답을 설정 가능.
- **퀴즈 풀이 및 점수 확인**: 퀴즈에 답변 후 점수와 결과를 확인하는 기능.
---

## 사용 기술

### 백엔드

- **Java (Spring Boot)**
- **Spring MVC**
- **Spring Security (OAuth)** 
- **MyBatis** 
- **AOP (Aspect-Oriented Programming)** 

### 프론트엔드

- **HTML5, CSS3, JavaScript** 
- **WebSocket** 
### API

- **Google OAuth API** 
- **Kakao OAuth API** 
- **Naver OAuth API** 

### 서버

- **Apache Tomcat** 
- **SSE (Server-Sent Events)** 

### 데이터베이스

- **ORACLE Database** 

### 빌드 도구

- **Maven** 
---

## 참고 사항

### CORS 설정

클라이언트와 서버 간의 원활한 통신을 위해 WebMvcConfig 클래스에서 CORS 설정이 필요합니다.

### OAuth 설정

Google, Kakao, Naver OAuth 로그인을 위해 해당 플랫폼의 API 키 및 리디렉션 URI 설정이 필요합니다.

### SSE 연결

SSE를 이용한 실시간 기능 사용 시 클라이언트와 서버 간 연결이 5분 간격으로 갱신되며, 타임아웃 설정에 유의해야 합니다.

### 로컬 개발 환경

로컬 환경에서 WebSocket, OAuth, SSE 기능을 테스트하기 위해 개발용 API 키와 localhost 도메인 설정이 필요합니다.
