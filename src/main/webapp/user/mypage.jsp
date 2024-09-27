<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!doctype html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>사용자 정보</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="manifest" href="site.webmanifest">
    <link rel="shortcut icon" type="image/x-icon" href="<c:url value='/assets/img/favicon.ico'/>">

    <!-- CSS here -->
    <link rel="stylesheet" href="../assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/css/owl.carousel.min.css">
    <link rel="stylesheet" href="../assets/css/slicknav.css">
    <link rel="stylesheet" href="../assets/css/flaticon.css">
    <link rel="stylesheet" href="../assets/css/progressbar_barfiller.css">
    <link rel="stylesheet" href="../assets/css/gijgo.css">
    <link rel="stylesheet" href="../assets/css/animate.min.css">
    <link rel="stylesheet" href="../assets/css/animated-headline.css">
    <link rel="stylesheet" href="../assets/css/magnific-popup.css">
    <link rel="stylesheet" href="../assets/css/fontawesome-all.min.css">
    <link rel="stylesheet" href="../assets/css/themify-icons.css">
    <link rel="stylesheet" href="../assets/css/slick.css">
    <link rel="stylesheet" href="../assets/css/nice-select.css">
    <link rel="stylesheet" href="../assets/css/style.css">
</head>
<body>
    <!-- Preloader Start -->
    <div id="preloader-active">
        <div class="preloader d-flex align-items-center justify-content-center">
            <div class="preloader-inner position-relative">
                <div class="preloader-circle"></div>
                <div class="preloader-img pere-text">
                    <img src="<c:url value='/assets/img/logo/loder.png'/>" alt="">
                </div>
            </div>
        </div>
    </div>
    <!-- Preloader End -->

    <!-- User Info -->
    <main class="login-body" style="background-color: #AEEEEE; padding: 20px; border-radius: 10px; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);">
        <div class="login-form">
            <div class="logo-login text-center">
                <a href="${pageContext.request.contextPath}/index.jsp"><img src="../assets/img/logo/loder.png" alt=""></a>
            </div>
            <h2 class="text-center">사용자 정보</h2>

            <div class="form-input">
                <label for="userEmail">이메일:</label>
                <form action="<c:url value='${pageContext.request.contextPath}/updateEmail'/>" method="post">
                    <input type="text" id="userEmail" name="userEmail"
                           value="<%= (session.getAttribute("SESS_EMAIL") != null) ? session.getAttribute("SESS_EMAIL") : "" %>"
                           class="form-control" placeholder="새 이메일을 입력하세요" required>

                    <input type="hidden" id="userNickname" name="userNickname"
                           value="<%= (session.getAttribute("SESS_NICKNAME") != null) ? session.getAttribute("SESS_NICKNAME") : "" %>">

                    <c:if test="${sessionScope.SESS_PROVIDER == 'local'}">
                        <button type="submit" class="button"
                                style="padding: 5px 10px; background-color: #007BFF; color: white; border-radius: 5px;">수정</button>
                    </c:if>
                </form>
            </div>

            <c:if test="${sessionScope.SESS_PROVIDER == 'local'}">
                <div class="form-input">
                    <label for="userPw">비밀번호:</label>
                    <form action="<c:url value='${pageContext.request.contextPath}/updatePw'/>" method="post">
                        <input type="text" id="userPw" name="userPw"
                               value="<%= (session.getAttribute("SESS_PW") != null) ? session.getAttribute("SESS_PW") : "" %>"
                               class="form-control" placeholder="새 비밀번호를 입력하세요" required>
                        <button type="submit" class="button"
                                style="padding: 5px 10px; background-color: #007BFF; color: white; border-radius: 5px;">수정</button>
                    </form>
                </div>
            </c:if>

            <div class="form-input">
                <label for="userNickname">닉네임:</label>
                <form action="<c:url value='${pageContext.request.contextPath}/updateNickname'/>" method="post">
                    <input type="text" id="userNickname" name="userNickname"
                           value="<%= (session.getAttribute("SESS_NICKNAME") != null) ? session.getAttribute("SESS_NICKNAME") : "" %>"
                           class="form-control" placeholder="새 닉네임을 입력하세요" required>
                    <c:if test="${sessionScope.SESS_PROVIDER == 'local'}">
                        <button type="submit" class="button"
                                style="padding: 5px 10px; background-color: #007BFF; color: white; border-radius: 5px;">수정</button>
                    </c:if>
                </form>
            </div>

            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>

            <!-- Home으로 돌아가기 버튼 추가 -->
            <div class="form-input pt-20 text-center">
                <c:if test="${sessionScope.SESS_USER.userGubun == 'a'}">
                    <a href="admin.jsp" class="button" style="padding: 10px 20px; background-color: #007BFF; color: white; border-radius: 5px; text-decoration: none;">Admin 페이지로 가기</a>
                </c:if>
                <c:if test="${sessionScope.SESS_USER.userGubun != 'a'}">
                    <a href="${pageContext.request.contextPath}/index.jsp" class="button" style="padding: 10px 20px; background-color: #007BFF; color: white; border-radius: 5px; text-decoration: none;">Home으로 돌아가기</a>
                </c:if>
            </div>

            <!-- 회원 탈퇴 버튼 추가 -->
            <div class="form-input pt-20 text-center">
                <form action="userDelete" method="post" onsubmit="return confirm('정말로 회원 탈퇴를 진행하시겠습니까?');">
                    <input type="hidden" name="userSeq" value="${sessionScope.SESS_USERSEQ}"/>
                    <button type="submit" class="button" style="padding: 10px 20px; background-color: red; color: white; border-radius: 5px;">회원 탈퇴</button>
                </form>
            </div>
        </div>
    </main>

    <script src="<c:url value='/assets/js/vendor/modernizr-3.5.0.min.js'/>"></script>
    <!-- Jquery, Popper, Bootstrap -->
    <script src="<c:url value='/assets/js/vendor/jquery-1.12.4.min.js'/>"></script>
    <script src="<c:url value='/assets/js/popper.min.js'/>"></script>
    <script src="<c:url value='/assets/js/bootstrap.min.js'/>"></script>
    <!-- Jquery Mobile Menu -->
    <script src="<c:url value='/assets/js/jquery.slicknav.min.js'/>"></script>
    <!-- Video bg -->
    <script src="<c:url value='/assets/js/jquery.vide.js'/>"></script>
    <!-- Jquery Slick , Owl-Carousel Plugins -->
    <script src="<c:url value='/assets/js/owl.carousel.min.js'/>"></script>
    <script src="<c:url value='/assets/js/slick.min.js'/>"></script>
    <!-- One Page, Animated-HeadLin -->
    <script src="<c:url value='/assets/js/wow.min.js'/>"></script>
    <script src="<c:url value='/assets/js/animated.headline.js'/>"></script>
    <script src="<c:url value='/assets/js/jquery.magnific-popup.js'/>"></script>
    <!-- Date Picker -->
    <script src="<c:url value='/assets/js/gijgo.min.js'/>"></script>
    <!-- Nice-select, sticky -->
    <script src="<c:url value='/assets/js/jquery.nice-select.min.js'/>"></script>
    <script src="<c:url value='/assets/js/jquery.sticky.js'/>"></script>
    <!-- Progress -->
    <script src="<c:url value='/assets/js/jquery.barfiller.js'/>"></script>
    <!-- counter , waypoint,Hover Direction -->
    <script src="<c:url value='/assets/js/jquery.counterup.min.js'/>"></script>
    <script src="<c:url value='/assets/js/waypoints.min.js'/>"></script>
    <script src="<c:url value='/assets/js/jquery.countdown.min.js'/>"></script>
    <script src="<c:url value='/assets/js/hover-direction-snake.min.js'/>"></script>
    <!-- contact js -->
    <script src="<c:url value='/assets/js/contact.js'/>"></script>
    <script src="<c:url value='/assets/js/jquery.form.js'/>"></script>
    <script src="<c:url value='/assets/js/jquery.validate.min.js'/>"></script>
    <script src="<c:url value='/assets/js/mail-script.js'/>"></script>
    <script src="<c:url value='/assets/js/jquery.ajaxchimp.min.js'/>"></script>
    <!-- Jquery Plugins, main Jquery -->
    <script src="<c:url value='/assets/js/plugins.js'/>"></script>
    <script src="<c:url value='/assets/js/main.js'/>"></script>
</body>
</html>
