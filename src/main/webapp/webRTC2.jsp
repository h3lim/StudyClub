<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type = "text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
    <title>웹소켓 테스트</title>
</head>
<body>
<button id="offerButton" onclick="createOffer();"> Peer Offer On</button><br>
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
    const sock = new SockJS("https://jw7469.iptime.org:8447/websocketprj/socket/");
    // RTC STUN Server Object
    const configuration = {
        "iceServers" : [{
            "url" : "stun:stun.l.google.com:19302"
        }]
    }
    // const myPeerConnection = new RTCPeerConnection(configuration);
    let myPeerConnection;
    let offerInProgress = false;
    let isConnected = false;

    // 초기화 함수
    function initializePeerConnection() {
        if (myPeerConnection) {
            myPeerConnection.close();
        }
        myPeerConnection = new RTCPeerConnection(configuration);
        myPeerConnection.onicecandidate = function(event) {
            if (event.candidate) {
                send({
                    event: "candidate",
                    data: event.candidate
                });
            }
        };
        myPeerConnection.addEventListener("track", handleAddStream);
    }
    function handleAddStream(event) {
        console.log("Receive Streaming Data");
        const peerFace = document.getElementById("peerFace");
        peerFace.srcObject = event.streams[0];
    }

    sock.onopen = function() {
        console.log("Web Socket Connect Success");
        isConnected = true;
    };

    sock.onclose = function() {
        console.log("Web Socket Closed");
        isConnected = false;
    };

    sock.onmessage = async function(msg) {
        const content = JSON.parse(msg.data);
        if (content.event === "offer") {
            console.log("Come Offer");

            initializePeerConnection();

            const offer = content.data;
            if (myPeerConnection.signalingState !== "stable") {
                await Promise.all([
                    myPeerConnection.setLocalDescription({ type: "rollback" }),
                    myPeerConnection.setRemoteDescription(offer)
                ]);
            } else {
                await myPeerConnection.setRemoteDescription(offer);
            }

            await getMediaIfNeeded();
            myStream.getTracks().forEach((track) => myPeerConnection.addTrack(track, myStream));

            const answer = await myPeerConnection.createAnswer();
            await myPeerConnection.setLocalDescription(answer);
            console.log("Send Answer");
            send({
                event: "answer",
                data: answer
            });
        } else if (content.event === "answer") {
            console.log("Come Answer");
            const answer = content.data;
            if (myPeerConnection.signalingState === "have-local-offer") {
                await myPeerConnection.setRemoteDescription(answer);
            } else {
                console.error("Failed to set remote answer SDP in the wrong state:", myPeerConnection.signalingState);
            }
        } else if (content.event === "candidate") {
            console.log("Come Candidate");
            await myPeerConnection.addIceCandidate(content.data);
        } else if (content.event === "toggleVideo") {
            console.log("Peer Video Toggle");
            const videoTrack = peerFace.srcObject.getVideoTracks()[0];
            videoTrack.enabled = !videoTrack.enabled;
        } else if (content.event === "toggleAudio") {
            console.log("Peer Audio Toggle");
            const audioTrack = peerFace.srcObject.getAudioTracks()[0];
            audioTrack.enabled = !audioTrack.enabled;
        }
    }

    function send(message) {
        if (isConnected) {
            sock.send(JSON.stringify(message));
        }
    }

    const myFace = document.getElementById("myFace");
    const peerFace = document.getElementById("peerFace");
    let myStream;
    let isVideoEnabled = true;
    let isAudioEnabled = true;

    async function getMediaIfNeeded() {
        if (!myStream) {
            try {
                console.log("getUserMedia 요청중..");
                myStream = await navigator.mediaDevices.getUserMedia({
                    audio: true,
                    video: true
                });
                console.log("getUserMedia 받기성공!")
                myFace.srcObject = myStream;
                // 초기 비디오 및 오디오 상태 설정
                myStream.getVideoTracks()[0].enabled = isVideoEnabled;
                myStream.getAudioTracks()[0].enabled = isAudioEnabled;
            } catch (e) {
                console.log("Media Transmission Error", e);
            }
        } else {
            // 기존 스트림이 있을 경우 상태를 유지합니다.
            myStream.getVideoTracks()[0].enabled = isVideoEnabled;
            myStream.getAudioTracks()[0].enabled = isAudioEnabled;
        }
    }

    async function createOffer() {
        if (offerInProgress || !isConnected) return;
        offerInProgress = true;
        const offerButton = document.getElementById("offerButton");
        offerButton.disabled = true;

        initializePeerConnection();

        console.log("Send Offer");
        await getMediaIfNeeded();
        myStream.getTracks().forEach((track) => myPeerConnection.addTrack(track, myStream));

        let offer = await myPeerConnection.createOffer();
        console.log("Offer Transmission Start");
        await myPeerConnection.setLocalDescription(offer);
        await send({
            event: "offer",
            data: offer
        });
        console.log("Offer Transmission Success");

        offerInProgress = false;
        offerButton.disabled = false;
    }

    function toggleVideo() {
        if (myStream) {
            const videoTrack = myStream.getVideoTracks()[0];
            videoTrack.enabled = !videoTrack.enabled;
            isVideoEnabled = videoTrack.enabled;
            console.log(videoTrack.enabled ? "Video on" : "Video off");
            send({
                event: "toggleVideo"
            });
        }
    }

    function toggleAudio() {
        if (myStream) {
            const audioTrack = myStream.getAudioTracks()[0];
            audioTrack.enabled = !audioTrack.enabled;
            isAudioEnabled = audioTrack.enabled;
            console.log(audioTrack.enabled ? "Audio on" : "Audio off");
            send({
                event: "toggleAudio"
            });
        }
    }
</script>
</html>
