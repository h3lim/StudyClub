<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>Room Details</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.5.3/css/bootstrap.min.css">
    <link rel="stylesheet" href="/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="/assets/css/owl.carousel.min.css">
    <link rel="stylesheet" href="/assets/css/slicknav.css">
    <link rel="stylesheet" href="/assets/css/flaticon.css">
    <link rel="stylesheet" href="/assets/css/progressbar_barfiller.css">
    <link rel="stylesheet" href="/assets/css/gijgo.css">
    <link rel="stylesheet" href="/assets/css/animate.min.css">
    <link rel="stylesheet" href="/assets/css/animated-headline.css">
    <link rel="stylesheet" href="/assets/css/magnific-popup.css">
    <link rel="stylesheet" href="/assets/css/fontawesome-all.min.css">
    <link rel="stylesheet" href="/assets/css/themify-icons.css">
    <link rel="stylesheet" href="/assets/css/slick.css">
    <link rel="stylesheet" href="/assets/css/nice-select.css">
    <link rel="stylesheet" href="/assets/css/style.css">
</head>
<body>
<!--? slider Area Start-->
<section class="slider-area slider-area2">
    <div class="slider-active">
        <!-- Single Slider -->
        <div class="single-slider slider-height2" style="min-height: 320px;">
            <div class="container">
                <div class="row">
                    <div class="col-xl-8 col-lg-11 col-md-12">
                        <div class="hero__caption hero__caption2">
                            <h1 data-animation="bounceIn" data-delay="0.2s">스터디 룸</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<div class="container mt-5">
    <div class="card">
        <div class="card-header">
            <h2>${KEY_ROOMVO.roomName}</h2>
        </div>
        <div class="card-body">
            <p><strong>Description:</strong> ${KEY_ROOMVO.roomDescription}</p>
            <p><strong>Date:</strong> ${KEY_ROOMVO.roomDate}</p>
            <p><strong>User Count:</strong> ${KEY_ROOMVO.userCount}</p>
            <p><strong>Max User Count:</strong> ${KEY_ROOMVO.maxUserCount}</p>
        </div>
        <div class="card-footer">
            <a href="video?roomId=${KEY_ROOMVO.roomId}" class="btn btn-primary" style="background-color: #3e7cd6;">1:1면접보기</a>

            <!-- 현재 세션 닉네임과 작성자 닉네임 비교 -->
            <c:choose>
                <c:when test="${sessionScope.SESS_NICKNAME == KEY_ROOMVO.userNickname}">
                    <a href="/cam-room.jsp?type=host&nickname=${KEY_ROOMVO.userNickname}" class="btn btn-primary" style="background-color: #6ea4f1;">회의하기</a>
                    <a href="roomUpdate?roomId=${KEY_ROOMVO.roomId}" class="btn btn-outline-warning" style="background-color: #d7b4dc;">수정</a>
                    <a href="#" class="btn btn-outline-danger" id="confirmDeleteBtn" style="background-color: #b55656;">삭제</a>
                </c:when>
                <c:otherwise>
                    <a href="/cam-room.jsp?type=client&room=${KEY_ROOMVO.roomId}&nickname=${sessionScope.SESS_NICKNAME}" class="btn btn-success">참여하기</a>
                </c:otherwise>
            </c:choose>


            <a href="roomList" class="btn btn-secondary" style="background-color: #61656e;">뒤로가기</a>
        </div>
    </div>
</div>

<!-- 삭제 확인 모달 -->
<div class="modal fade" id="confirmDeleteModal" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmDeleteModalLabel">삭제 확인</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                정말 삭제하시겠습니까?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">아니오</button>
                <a href="#" class="btn btn-danger" id="deleteConfirmBtn">예</a>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

<script>
    $(document).ready(function() {
        // 삭제 버튼 클릭 시 모달 열기
        $("#confirmDeleteBtn").click(function() {
            $("#confirmDeleteModal").modal("show");
        });

        // 모달에서 삭제 확인 버튼 클릭 시 roomId를 포함한 폼 생성하여 전송
        $("#deleteConfirmBtn").click(function() {
            var roomId = "${KEY_ROOMVO.roomId}";
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = 'roomDelete';

            var input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'roomId';
            input.value = roomId;

            form.appendChild(input);
            document.body.appendChild(form);
            form.submit();

            // 모달 닫기
            $("#confirmDeleteModal").modal("hide");
        });
    });
</script>
<!-- JS here -->
<script src="/assets/js/vendor/modernizr-3.5.0.min.js"></script>
<!-- Jquery, Popper, Bootstrap -->
<script src="/assets/js/vendor/jquery-1.12.4.min.js"></script>
<script src="/assets/js/popper.min.js"></script>
<script src="/assets/js/bootstrap.min.js"></script>
<!-- Jquery Mobile Menu -->
<script src="/assets/js/jquery.slicknav.min.js"></script>

<!-- Jquery Slick , Owl-Carousel Plugins -->
<script src="/assets/js/owl.carousel.min.js"></script>
<script src="/assets/js/slick.min.js"></script>
<!-- One Page, Animated-HeadLin -->
<script src="/assets/js/wow.min.js"></script>
<script src="/assets/js/animated.headline.js"></script>
<script src="/assets/js/jquery.magnific-popup.js"></script>

<!-- Date Picker -->
<script src="/assets/js/gijgo.min.js"></script>
<!-- Nice-select, sticky -->
<script src="/assets/js/jquery.nice-select.min.js"></script>
<script src="/assets/js/jquery.sticky.js"></script>
<!-- Progress -->
<script src="/assets/js/jquery.barfiller.js"></script>

<!-- counter , waypoint,Hover Direction -->
<script src="/assets/js/jquery.counterup.min.js"></script>
<script src="/assets/js/waypoints.min.js"></script>
<script src="/assets/js/jquery.countdown.min.js"></script>
<script src="/assets/js/hover-direction-snake.min.js"></script>

<!-- contact js -->
<script src="/assets/js/contact.js"></script>
<script src="/assets/js/jquery.form.js"></script>
<script src="/assets/js/jquery.validate.min.js"></script>
<script src="/assets/js/mail-script.js"></script>
<script src="/assets/js/jquery.ajaxchimp.min.js"></script>

<!-- Jquery Plugins, main Jquery -->
<script src="/assets/js/plugins.js"></script>
<script src="/assets/js/main.js"></script>
</body>
</html>
