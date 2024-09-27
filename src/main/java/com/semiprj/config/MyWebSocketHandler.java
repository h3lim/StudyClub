package com.semiprj.config;

import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

@RequestMapping("/socket")
public class MyWebSocketHandler extends TextWebSocketHandler {

    private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();

//    private static Logger logger = LoggerFactory.getLogger(MyWebSocketHandler.class);
    //소켓 열림
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        System.out.println("연결! : " + session);
//        sessions.add(session);
//        session.getAttributes().put(session.getId(), session);
        sessions.add(session);
    }

    //전체채팅
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
//       String id = session.getId();
//       String msgAndId = id + " : " + message.getPayload();

        for (WebSocketSession webSocketSession : sessions) {
            if (webSocketSession.isOpen() && !session.getId().equals(webSocketSession.getId())) {
                webSocketSession.sendMessage(message);
            }

//        System.out.println("#ChattingHandler, handleMessage");
//        System.out.println(session.getId() + ": " + message);
//
//        for(WebSocketSession s :  sessions) {
//            s.sendMessage(new TextMessage(session.getAttributes().get("userNickname") + ":" + message.getPayload()));
//        }
        }
    }

    //socket close
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessions.remove(session);
        System.out.println("연결해제!" + session + " : " + session.getId());
    }
}
