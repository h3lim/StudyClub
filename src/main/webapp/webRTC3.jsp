<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
    <title>웹소켓 테스트</title>
</head>
<body>
<button id="offerButton" onclick="createOffer();">Peer Offer On</button><br>
<button onclick="toggleVideo();">Toggle Video</button>
<button onclick="toggleAudio();">Toggle Audio</button><br>
<div> 내 영상 </div>
<video id="myFace" playsinline autoplay width="300" height="300"></video>
<br>

<div> Peer의 영상</div>
<video id="peerFace" playsinline autoplay width="300" height="300"></video>
</body>
<script>
    // Socket Connection
    const sock = new SockJS("https://jw7469.iptime.org:8447/socket/");
    const configuration = {
        iceServers: [{ url: "stun:stun.l.google.com:19302" }]
    };
    let myPeerConnection;
    let myStream;
    let offerInProgress = false;
    let isConnected = false;

    function initializePeerConnection() {
        if (myPeerConnection) {
            myPeerConnection.close();
        }
        myPeerConnection = new RTCPeerConnection(configuration);

        myPeerConnection.onicecandidate = (event) => {
            if (event.candidate) {
                send({ event: "candidate", data: event.candidate });
            }
        };
        myPeerConnection.addEventListener("track", handleAddStream);
    }

    function handleAddStream(event) {
        console.log("Receive Streaming Data");
        const peerFace = document.getElementById("peerFace");
        peerFace.srcObject = event.streams[0];
    }

    sock.onopen = () => {
        console.log("Web Socket Connect Success");
        isConnected = true;
    };

    sock.onclose = () => {
        console.log("Web Socket Closed");
        isConnected = false;
    };

    sock.onmessage = async (msg) => {
        const content = JSON.parse(msg.data);
        switch (content.event) {
            case "offer":
                await handleOffer(content.data);
                break;
            case "answer":
                await handleAnswer(content.data);
                break;
            case "candidate":
                await myPeerConnection.addIceCandidate(content.data);
                break;
            case "toggleVideo":
                togglePeerVideo();
                break;
            case "toggleAudio":
                togglePeerAudio();
                break;
        }
    };

    async function handleOffer(offer) {
        console.log("Come Offer");
        initializePeerConnection();
        await myPeerConnection.setRemoteDescription(offer);
        await getMediaIfNeeded();
        myStream.getTracks().forEach((track) => myPeerConnection.addTrack(track, myStream));
        const answer = await myPeerConnection.createAnswer();
        await myPeerConnection.setLocalDescription(answer);
        send({ event: "answer", data: answer });
    }

    async function handleAnswer(answer) {
        console.log("Come Answer");
        await myPeerConnection.setRemoteDescription(answer);
    }

    function send(message) {
        if (isConnected) {
            sock.send(JSON.stringify(message));
        }
    }

    const myFace = document.getElementById("myFace");
    let isVideoEnabled = true;
    let isAudioEnabled = true;

    async function getMediaIfNeeded() {
        if (!myStream) {
            try {
                console.log("getUserMedia 요청중..");
                myStream = await navigator.mediaDevices.getUserMedia({ audio: true, video: true });
                console.log("getUserMedia 받기성공!");
                myFace.srcObject = myStream;
            } catch (e) {
                console.log("Media Transmission Error", e);
            }
        } else {
            // 상태 유지
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
        await getMediaIfNeeded();
        myStream.getTracks().forEach((track) => myPeerConnection.addTrack(track, myStream));

        const offer = await myPeerConnection.createOffer();
        await myPeerConnection.setLocalDescription(offer);
        send({ event: "offer", data: offer });

        offerInProgress = false;
        offerButton.disabled = false;
    }

    function toggleVideo() {
        if (myStream) {
            const videoTrack = myStream.getVideoTracks()[0];
            videoTrack.enabled = !videoTrack.enabled;
            isVideoEnabled = videoTrack.enabled;
            console.log(videoTrack.enabled ? "Video on" : "Video off");
            send({ event: "toggleVideo" });
        }
    }

    function toggleAudio() {
        if (myStream) {
            const audioTrack = myStream.getAudioTracks()[0];
            audioTrack.enabled = !audioTrack.enabled;
            isAudioEnabled = audioTrack.enabled;
            console.log(audioTrack.enabled ? "Audio on" : "Audio off");
            send({ event: "toggleAudio" });
        }
    }

    function togglePeerVideo() {
        const peerFace = document.getElementById("peerFace");
        const videoTrack = peerFace.srcObject.getVideoTracks()[0];
        videoTrack.enabled = !videoTrack.enabled;
    }

    function togglePeerAudio() {
        const peerFace = document.getElementById("peerFace");
        const audioTrack = peerFace.srcObject.getAudioTracks()[0];
        audioTrack.enabled = !audioTrack.enabled;
    }
</script>
</html>
