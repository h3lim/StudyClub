<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false" %>
<%@include file="/header.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>방 목록</title>
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
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <style>

        .room-card {
            width: 100%;
            height: 300px;
            margin: 10px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            border: 1px solid #dee2e6;
            border-radius: 15px;
            transition: transform 0.2s;
            background-color: #f8f9fa;
        }
        .room-card:hover {
            transform: scale(1.07);
        }
        .no-room {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
            height: 300px;
            border: 1px dashed #dee2e6;
            border-radius: 15px;
            background-color: #f0f2f4;
        }
        .error-message {
            color: red;
            margin-bottom: 20px;
        }
    </style>
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
<br>
<br>
<div class="container text-center">
    <h1 class="display-4 mb-4">방 목록</h1>
    <div class="mb-4">
        <a href="${pageContext.request.contextPath}/roomInsert" class="btn btn-success" style="background-color: #3e7cd6;">새 방 만들기</a>
    </div>
    <div class="row justify-content-center">
        <c:if test="${not empty errorMessage}">
            <div class="col-12">
                <p class="error-message">${errorMessage}</p>
            </div>
        </c:if>
        <c:choose>
            <c:when test="${not empty KEY_ROOMLIST}">
                <c:forEach var="room" items="${KEY_ROOMLIST}">
                    <div class="col-12 col-sm-6 col-md-4">
                        <div class="room-card">
                            <h5>${room.roomName}</h5>
                            <p>${room.roomDescription}</p>
                            <p>작성자 : ${room.userNickname}</p>
                            <br>
                            <c:if test="${room.roomPwd != null}">
                                <p>잠금방</p>
                                <c:choose>
                                <c:when test="${not empty sessionScope.SESS_NICKNAME}">
                                <button class="btn btn-primary" data-toggle="modal" data-target="#passwordModal" data-room-id="${room.roomId}">입장하기</button>
                                </c:when>
                                <c:otherwise>
                                    <p>로그인 후 이용가능합니다</p>
                                </c:otherwise>
                                </c:choose>
                            </c:if>
                            <c:if test="${room.roomPwd == null}">
                                <p>오픈방</p>

                            <c:choose>
                                <c:when test="${not empty sessionScope.SESS_NICKNAME}">
                                    <a href="roomDetail?roomId=${room.roomId}" class="btn btn-primary">입장하기</a>
                                </c:when>
                                <c:otherwise>
                                    <p>로그인 후 이용가능합니다</p>
                                </c:otherwise>
                            </c:choose>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="col-12 col-sm-6 col-md-4">
                    <div class="room-card no-room">
                        <p>방이 없습니다.</p>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Password Modal -->
<div class="modal fade" id="passwordModal" tabindex="-1" role="dialog" aria-labelledby="passwordModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="passwordModalLabel">비밀번호 입력</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="passwordForm" method="POST" action="checkPassword">
                <div class="modal-body">
                    <input type="hidden" name="roomId" id="modalRoomId">
                    <div class="form-group">
                        <label for="password" class="col-form-label">비밀번호:</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                    <button type="submit" class="btn btn-primary">입장</button>
                </div>
            </form>
        </div>
    </div>
</div>
<br>
<br>
<script>
    $('#passwordModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var roomId = button.data('room-id');
        var modal = $(this);
        modal.find('#modalRoomId').val(roomId);
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
<%@include file="/footer.jsp"%>