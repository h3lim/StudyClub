<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type = "text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
    <title>웹소켓 테스트</title>
</head>
<body>
<button onclick="createOffer();"> Peer Offer On</button><br>
<button onclick="toggleVideo();">Toggle Video</button>
<button onclick="toggleAudio();">Toggle Audio</button><br>
 <div> 내 영상 </div>
     <video id = "myFace" playsinline autoplay width="300" height="300"></video>
     <br>

 <div> Peer의 영상</div>
    <video id = "peerFace" playsinline autoplay width="300" height="300"></video>
</body>
<script>
    // Socket Connection
    var sock = new SockJS("https://jw7469.iptime.org:8447/websocketprj/socket/");
    // RTC STUN Server Object
    var configuration = {
        "iceServers" : [{
            "url" : "stun:stun.l.google.com:19302"
        }]
    }
    var myPeerConnection = new RTCPeerConnection(configuration);

    myPeerConnection.onicecandidate = function(event) {
       if(event.candidate){
        send({
            event:"candidate",
            data:event.candidate
        });
       }
    };

    //Connect 성공시 peer 스트림이 나의 RTC객체에 등록이 되면 시작하는 메서드
    myPeerConnection.addEventListener("addstream", handleAddStream);
    function handleAddStream(data){
        console.log("Receive Streaming Data");
        var peerFace = document.getElementById("peerFace");
        peerFace.srcObject = data.stream;
    }

    //Socket 연결시 콜백함수
    sock.onopen = function() {
        console.log("Web Socket Connect Success");
    };

    //Socket Send Message 콜백함수
    sock.onmessage = async function(msg){
        var content = JSON.parse(msg.data);
        if(content.event === "offer"){
            console.log("Come Offer");

            //offer가 오면 Remote description으로 등록
            var offer = content.data;
            await myPeerConnection.setRemoteDescription(offer);

            //받는 쪽에 나의 media on
            await getMedia();
            myStream.getTracks().forEach((track) => myPeerConnection.addTrack(track,myStream));

            //Send Answer
            var answer = await myPeerConnection.createAnswer();
            await myPeerConnection.setLocalDescription(answer);
            console.log("Send Answer");
            send({
                event: "answer",
                data: answer
            })
        } else if (content.event === "answer"){
            console.log("Come Answer");
            answer = content.data;
            await myPeerConnection.setRemoteDescription(answer);
        } else if (content.event === "candidate"){
            console.log("Come Candidate");
            // remoteDescription의 peer와 연결방식을 결정
            await myPeerConnection.addIceCandidate(content.data);
        } else if (content.event === "toggleVideo"){
            console.log("Peer Video Toggle");
            const videoTrack = peerFace.srcObject.getVideoTracks()[0];
            videoTrack.enabled = !videoTrack.enabled;
        } else if (content.event === "toggleAudio"){
            console.log("Peer Audio Toggle");
            const audioTrack = peerFace.srcObject.getAudioTracks()[0];
            audioTrack.enabled = !audioTrack.enabled;
        }
    }
    //socket message전송 함수
    function send(message){
        sock.send(JSON.stringify(message));
    }

    // media 관련 변수 선언, myFace는 element를 받음
    // myStream에는 영상 내용을 담음
    const myFace = document.getElementById("myFace");
    const peerFace = document.getElementById("peerFace");
    let myStream;

    //media의 내용을 받는 함수
    async function getMedia(){
        try{
            console.log("getUserMedia 요청중..");
            myStream = await navigator.mediaDevices.getUserMedia({
                audio: true,
                video: true
            });
            console.log("getUserMedia 받기성공!")
            myFace.srcObject = myStream;
        } catch (e){
            console.log("Media Transmission Error",e);
        }
    }

    // 오퍼 생성 버튼 클릭시 메서드 실행
    async function createOffer(){
        console.log("Send Offer");
        // Camera on, myStream에 정보 담기
        await getMedia();

        // getMedia에서 가져온 video, audio를 myPeerConnection에 등록
        myStream.getTracks().forEach((track) => myPeerConnection.addTrack(track, myStream));

        // 위에서 RTC객체 생성과 나의 media에 RTC객체를 담았고 이제 오퍼 생성
        var offer = await myPeerConnection.createOffer();
        console.log("Offer Transmisson Start")

        //send 함수로 socket에 나의 offer를 전송
        await send({
            event:"offer",
            data: offer
        })
        console.log("Offer Transmisson Success")
        await myPeerConnection.setLocalDescription(offer);
    }
    // Toggle Video
    function toggleVideo() {
        const videoTrack = myStream.getVideoTracks()[0];
        if (videoTrack.enabled) {
            videoTrack.enabled = false;
            console.log("Video off");
        } else {
            videoTrack.enabled = true;
            console.log("Video on");
        }
        send({
            event: "toggleVideo"
        });
    }

    // Toggle Audio
    function toggleAudio() {
        const audioTrack = myStream.getAudioTracks()[0];
        if (audioTrack.enabled) {
            audioTrack.enabled = false;
            console.log("Audio off");
        } else {
            audioTrack.enabled = true;
            console.log("Audio on");
        }
        send({
            event: "toggleAudio"
        });
    }
</script>
</html>
