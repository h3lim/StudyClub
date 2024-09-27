<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>웹소켓 테스트</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.5.3/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        .video-container {
            display: flex;
            justify-content: space-around;
            align-items: center;
            flex-wrap: wrap;
        }
        video {
            border: 1px solid #dee2e6;
            border-radius: 5px;
            margin: 10px;
        }
        .controls {
            margin-bottom: 20px;
        }
        .icon {
            margin-left: 5px;
            font-size: 1.5em;
        }
    </style>
</head>
<body>
<div class="container text-center">
    <h1 class="display-4 mb-4">웹 소켓 화상면접 시스템</h1>
    <div class="controls mb-4">
        <button id="offerButton" class="btn btn-primary btn-lg mx-2 mb-2" onclick="createOffer();">Peer Offer On</button>
        <button class="btn btn-secondary btn-lg mx-2 mb-2" onclick="toggleVideo();">Toggle Video <i id="videoIcon" class="icon"></i></button>
        <button class="btn btn-secondary btn-lg mx-2 mb-2" onclick="toggleAudio();">Toggle Audio <i id="audioIcon" class="icon"></i></button>
    </div>
    <div class="video-container">
        <div>
            <div class="h5 mb-2">내 영상</div>
            <video id="myFace" playsinline autoplay width="500" height="500"></video>
        </div>
        <div>
            <div class="h5 mb-2">Peer의 영상</div>
            <video id="peerFace" playsinline autoplay width="500" height="500"></video>
        </div>
    </div>
</div>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script>
    // Socket Connection
    const sock = new SockJS("https://jw7469.iptime.org:8447/socket/");
    // RTC STUN Server Object
    const configuration = {
        "iceServers": [{
            "url": "stun:stun.l.google.com:19302"
        }]
    }
    let myPeerConnection;
    let offerInProgress = false;
    let isConnected = false;
    let isVideoEnabled = true;
    let isAudioEnabled = true;

    // Icons
    const videoIcon = document.getElementById("videoIcon");
    const audioIcon = document.getElementById("audioIcon");

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
            isVideoEnabled = videoTrack.enabled;
            updateVideoIcon();
        } else if (content.event === "toggleAudio") {
            console.log("Peer Audio Toggle");
            const audioTrack = peerFace.srcObject.getAudioTracks()[0];
            audioTrack.enabled = !audioTrack.enabled;
            isAudioEnabled = audioTrack.enabled;
            updateAudioIcon();
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
            updateVideoIcon();
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
            updateAudioIcon();
            send({
                event: "toggleAudio"
            });
        }
    }

    function updateVideoIcon() {
        videoIcon.className = isVideoEnabled ? "fas fa-video text-success icon" : "fas fa-video-slash text-danger icon";
    }

    function updateAudioIcon() {
        audioIcon.className = isAudioEnabled ? "fas fa-volume-up text-success icon" : "fas fa-volume-mute text-danger icon";
    }
    // 초기 아이콘 상태 업데이트
    updateVideoIcon();
    updateAudioIcon();
</script>
</body>
</html>
