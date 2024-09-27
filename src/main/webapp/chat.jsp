
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type = "text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
    <title>웹소켓 테스트</title>


</head>
<body>
 <div id = "messageArea"></div>
 <input type="text" id="message"/>
 <input type="button" id="sendBtn" value="submit"/>

</body>
<script type="text/javascript">
    $("#sendBtn").click(function (){
        sendMessage();
        $('#message').val('')
    });
    let sock = new SockJS("https://jw7469.iptime.org:8447/websocketprj/socket/");
    sock.onmessage = onMessage;
    sock.onclose = onClose;
    //메시지 전송
    function sendMessage(){
        sock.send($("#message").val());
    }
    //서버 메시지
    function onMessage(msg){
        var data = msg.data;
        $("#messageArea").append(data + "<br/>");
    }
    //서버 연결 끊음
    function onClose(evt){
        $("#messageArea").append("연결 끊김");
    }
</script>
</html>
