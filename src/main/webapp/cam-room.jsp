<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="resources/cam-room.css">
    <script type="module" src="resources/cam-room.js"></script>
</head>
<body>
    <div class="frame">
        <div class="top-box">
            <canvas class="canvas">
            </canvas>
            <div class="control-box-wrap">
                <input class="line-width" type="range" min="0.1" max="1.5" step="0.05">
                <div class="btn-group">
                    <button class="eraser-btn">
                        <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="currentColor" class="bi bi-eraser"
                            viewBox="0 0 16 16">
                            <path
                                d="M8.086 2.207a2 2 0 0 1 2.828 0l3.879 3.879a2 2 0 0 1 0 2.828l-5.5 5.5A2 2 0 0 1 7.879 15H5.12a2 2 0 0 1-1.414-.586l-2.5-2.5a2 2 0 0 1 0-2.828l6.879-6.879zm2.121.707a1 1 0 0 0-1.414 0L4.16 7.547l5.293 5.293 4.633-4.633a1 1 0 0 0 0-1.414l-3.879-3.879zM8.746 13.547 3.453 8.254 1.914 9.793a1 1 0 0 0 0 1.414l2.5 2.5a1 1 0 0 0 .707.293H7.88a1 1 0 0 0 .707-.293l.16-.16z">
                            </path>
                        </svg>
                        
                    <!-- <button class="mode-btn">
                        <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="currentColor" class="bi bi-brush"
                            viewBox="0 0 16 16">
                            <path
                                d="M15.825.12a.5.5 0 0 1 .132.584c-1.53 3.43-4.743 8.17-7.095 10.64a6.067 6.067 0 0 1-2.373 1.534c-.018.227-.06.538-.16.868-.201.659-.667 1.479-1.708 1.74a8.118 8.118 0 0 1-3.078.132 3.659 3.659 0 0 1-.562-.135 1.382 1.382 0 0 1-.466-.247.714.714 0 0 1-.204-.288.622.622 0 0 1 .004-.443c.095-.245.316-.38.461-.452.394-.197.625-.453.867-.826.095-.144.184-.297.287-.472l.117-.198c.151-.255.326-.54.546-.848.528-.739 1.201-.925 1.746-.896.126.007.243.025.348.048.062-.172.142-.38.238-.608.261-.619.658-1.419 1.187-2.069 2.176-2.67 6.18-6.206 9.117-8.104a.5.5 0 0 1 .596.04zM4.705 11.912a1.23 1.23 0 0 0-.419-.1c-.246-.013-.573.05-.879.479-.197.275-.355.532-.5.777l-.105.177c-.106.181-.213.362-.32.528a3.39 3.39 0 0 1-.76.861c.69.112 1.736.111 2.657-.12.559-.139.843-.569.993-1.06a3.122 3.122 0 0 0 .126-.75l-.793-.792zm1.44.026c.12-.04.277-.1.458-.183a5.068 5.068 0 0 0 1.535-1.1c1.9-1.996 4.412-5.57 6.052-8.631-2.59 1.927-5.566 4.66-7.302 6.792-.442.543-.795 1.243-1.042 1.826-.121.288-.214.54-.275.72v.001l.575.575zm-4.973 3.04.007-.005a.031.031 0 0 1-.007.004zm3.582-3.043.002.001h-.002z">
                            </path>
                        </svg></button>
                    </button> -->
                </div>
                <div class="color-group">
                    <input class="color-picker" type="color">
                    <div class="color-option" style="background-color: #e57373" data-color="#e57373"></div>
                    <div class="color-option" style="background-color: #ff8a65" data-color="#ff8a65"></div>
                    <div class="color-option" style="background-color: #ffb74d" data-color="#ffb74d"></div>
                    <div class="color-option" style="background-color: #ffd54f" data-color="#ffd54f"></div>
                    <div class="color-option" style="background-color: #dce775" data-color="#dce775"></div>
                    <div class="color-option" style="background-color: #aed581" data-color="#aed581"></div>
                    <div class="color-option" style="background-color: #4db6ac" data-color="#4db6ac"></div>
                    <div class="color-option" style="background-color: #4dd0e1" data-color="#4dd0e1"></div>
                    <div class="color-option" style="background-color: #64b5f6" data-color="#64b5f6"></div>
                    <div class="color-option" style="background-color: #7986cb" data-color="#7986cb"></div>
                    <div class="color-option" style="background-color: #9575cd" data-color="#9575cd"></div>
                    <div class="color-option" style="background-color: #ba68c8" data-color="#BA68C8"></div>
                  </div>
            </div>
        </div>
        <div class="bottom-box">
            <div class="con-box">
                <video class="local-video video" playsinline autoplay></video>
            </div>
        </div>
      
        <div class="chat_wrap">
            <div class="header">
                CHAT
            </div>
            <div class="chat">
                <ul class="chat-spawn-box">
                </ul>
            </div>
            <div class="input-div">
                <textarea class="chat-input" placeholder="Press Enter for send message."></textarea>
            </div>
    
    </div>
</body>
</html>