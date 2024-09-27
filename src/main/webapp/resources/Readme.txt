WebRTC 설정을 위해서는 필수로 해야 할 작업들이 있다.

WebRTC의 peerConnection을 하기 위해서는
1. HTTPS에 연결하기 위한 SSL(Secure Sockets Layer) 웹브라우저와 서버간 암호화 통신을 위한 프로토콜  KEYSTORE.p12// p12 확장자의 인증키가 필요하다.
   해당 인증서는 공인 인증기관을 거치지 않고 만들었기 때문에 해당 인증서로 HTTPS연결을 하면 경고창이 발생한다.
2. Tomcat Sever에 HTTPS를 위한 포트 연결을 해줘야한다. Server.xml에 HTTPS 연결을 해준다.
3. WebRTC Script에서는 STUN Server를 거처야 상대방과 연결이 가능하다.
4. 해당 resources의 재훈씨 코드는 def의 endpoint 주소가 필요
5. web.xml Filter에 <async-supported>true</async-supported> 추가 필요