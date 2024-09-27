<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="com.semiprj.model.UserVO" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>전체 사용자 목록 | 교육</title>
    <link rel="shortcut icon" type="image/x-icon" href="<c:url value='../assets/img/favicon.ico'/>">
    <link rel="stylesheet" href="<c:url value='/assets/css/bootstrap.min.css' />">
    <link rel="stylesheet" href="<c:url value='/assets/css/style.css' />">
</head>
<body>
    <header>
        <div class="header-area header-transparent">
            <div class="main-header">
                <div class="header-bottom header-sticky">
                    <div class="container-fluid">
                        <div class="row align-items-center">
                            <div class="col-xl-2 col-lg-2">
                                <div class="logo">
                                    <a href="<c:url value='${pageContext.request.contextPath}/index.jsp' />"><img src="<c:url value='/assets/img/logo/logo.png' />" alt=""></a>
                                </div>
                            </div>
                            <div class="col-xl-10 col-lg-10">
                                <div class="menu-wrapper d-flex align-items-center justify-content-end">
                                    <div class="main-menu d-none d-lg-block">
                                        <nav>
                                            <ul id="navigation">
                                                <c:if test="${not empty sessionScope.SESS_USER}">
                                                    <li class="button-header margin-left">
                                                        <form action="<c:url value='/form_logout_process' />" method="POST" style="display:inline;">
                                                            <button type="submit" class="btn">로그아웃</button>
                                                        </form>
                                                    </li>
                                                </c:if>
                                                <c:if test="${empty sessionScope.SESS_USER}">
                                                    <li class="button-header margin-left"><a href="<c:url value='/user/register.jsp' />" class="btn">회원가입</a></li>
                                                    <li class="button-header"><a href="<c:url value='/user/login.jsp' />" class="btn btn3">로그인</a></li>
                                                </c:if>
                                            </ul>
                                        </nav>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <main>
        <section class="slider-area">
            <div class="slider-active">
                <div class="single-slider slider-height d-flex align-items-center">
                    <div class="container">
                        <div class="row">
                            <div class="col-xl-12">
                                <div class="user-info">
                                    <h2>전체 사용자 목록</h2>
                                    <form class="form-default" action="<c:url value='/allUser' />" method="POST">
                                        <button type="submit" class="btn btn-primary">전체 사용자 조회</button>
                                    </form>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>사용자 시퀀스</th>
                                                <th>이메일</th>
                                                <th>닉네임</th>
                                                <th>가입 날짜</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="user" items="${USER_LIST}">
                                                <tr>
                                                    <td>${user.userSeq}</td>
                                                    <td>${user.userEmail}</td>
                                                    <td>${user.userNickname}</td>
                                                    <td>${user.userDate}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <footer>
        <div class="footer-wrapper footer-bg">
            <div class="footer-area footer-padding">
                <div class="container">
                    <div class="row justify-content-between">
                        <div class="col-xl-4 col-lg-5 col-md-4 col-sm-6">
                            <div class="single-footer-caption mb-50">
                                <div class="footer-logo mb-25">
                                    <a href="/user/index.jsp"><img src="<c:url value='/assets/img/logo/logo2_footer.png' />" alt=""></a>
                                </div>
                                <div class="footer-title">
                                    <p>자동화된 프로세스는 당신의 옷이 기계에 들어가는 순간 시작됩니다.</p>
                                </div>
                                <div class="footer-social">
                                    <a href="#"><i class="fab fa-twitter"></i></a>
                                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                                    <a href="#"><i class="fab fa-pinterest-p"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="footer-bottom-area">
                    <div class="container">
                        <div class="footer-border">
                            <div class="row d-flex align-items-center">
                                <div class="col-xl-12">
                                    <div class="footer-copy-right text-center">
                                        <p>Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <div id="back-top">
        <a title="Go to Top" href="#">
            <i class="fas fa-level-up-alt"></i>
        </a>
    </div>
    <script src="<c:url value='/assets/js/vendor/jquery-1.12.4.min.js' />"></script>
    <script src="<c:url value='/assets/js/bootstrap.min.js' />"></script>
    <script src="<c:url value='/assets/js/main.js' />"></script>
</body>
</html>
