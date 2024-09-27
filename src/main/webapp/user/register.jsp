<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!doctype html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>회원가입</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="manifest" href="site.webmanifest">
    <link rel="shortcut icon" type="image/x-icon" href="../assets/img/favicon.ico">

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
                    <img src="../assets/img/logo/loder.png" alt="">
                </div>
            </div>
        </div>
    </div>
    <!-- Preloader End -->

   <!-- Register -->
   <main class="login-body" style="background-color: #ffffff;">
           <form class="form-default" action="${pageContext.request.contextPath}/form_join_process" method="post">
               <div class="login-form" style="background-color: rgba(0,0,0,0.59)">
                   <h2 class="text-center">회원가입</h2>
                   <div class="form-input">
                       <label for="userEmail" style="font-size: 18px;">이메일:</label>
                       <input type="email" id="userEmail" name="userEmail"
                              placeholder="이메일을 입력하세요"
                              value="${not empty userEmail ? userEmail : ''}" required style="font-size: 12px;">
                   </div>
                   <div class="form-input">
                       <label for="userPw" style="font-size: 18px;">비밀번호:</label>
                       <input type="password" id="userPw" name="userPw"
                              placeholder="비밀번호를 입력하세요" required style="font-size: 12px;">
                   </div>
                   <div class="form-input">
                       <label for="confirmPassword" style="font-size: 18px;">비밀번호 확인:</label>
                       <input type="password" id="confirmPassword" name="confirmPassword"
                              placeholder="비밀번호를 다시 입력하세요" required style="font-size: 12px;">
                   </div>
                   <div class="form-input">
                       <label for="userNickname" style="font-size: 18px;">닉네임:</label>
                       <input type="text" id="userNickname" name="userNickname"
                              placeholder="닉네임을 입력하세요"
                              value="${not empty userNickname ? userNickname : ''}" required style="font-size: 12px;">
                   </div>
                   <div class="text-center">
                       <input type="submit" name="submit" value="회원가입" class="btn btn btn-block" style="background-color: rgba(0,0,0,0.45);">
                   </div>
                  <div class="form-input pt-20 text-center">
                      <a href="login.jsp" class="button btn-block" style="padding: 10px 20px; background-color: #28A745; color: white; border-radius: 5px; text-decoration: none;">로그인</a>
                      <a href="../index.jsp" class="button btn-block" style="padding: 10px 20px; background-color: #007BFF; color: white; border-radius: 5px; text-decoration: none;">홈으로 돌아가기</a>
                  </div>
               </div>
           </form>
       </main>


   <script>
       <c:if test="${not empty error}">
           alert("${error}");
       </c:if>
   </script>


    <!-- JS here -->
    <script src="../assets/js/vendor/modernizr-3.5.0.min.js"></script>
    <!-- Jquery, Popper, Bootstrap -->
    <script src="../assets/js/vendor/jquery-1.12.4.min.js"></script>
    <script src="../assets/js/popper.min.js"></script>
    <script src="../assets/js/bootstrap.min.js"></script>
    <!-- Jquery Mobile Menu -->
    <script src="../assets/js/jquery.slicknav.min.js"></script>

    <!-- Jquery Slick , Owl-Carousel Plugins -->
    <script src="../assets/js/owl.carousel.min.js"></script>
    <script src="../assets/js/slick.min.js"></script>
    <!-- One Page, Animated-HeadLin -->
    <script src="../assets/js/wow.min.js"></script>
    <script src="../assets/js/animated.headline.js"></script>
    <script src="../assets/js/jquery.magnific-popup.js"></script>

    <!-- Date Picker -->
    <script src="../assets/js/gijgo.min.js"></script>
    <!-- Nice-select, sticky -->
    <script src="../assets/js/jquery.nice-select.min.js"></script>
    <script src="../assets/js/jquery.sticky.js"></script>
    <!-- Progress -->
    <script src="../assets/js/jquery.barfiller.js"></script>

    <!-- counter , waypoint,Hover Direction -->
    <script src="../assets/js/jquery.counterup.min.js"></script>
    <script src="../assets/js/waypoints.min.js"></script>
    <script src="../assets/js/jquery.countdown.min.js"></script>
    <script src="../assets/js/hover-direction-snake.min.js"></script>

    <!-- contact js -->
    <script src="../assets/js/contact.js"></script>
    <script src="../assets/js/jquery.form.js"></script>
    <script src="../assets/js/jquery.validate.min.js"></script>
    <script src="../assets/js/mail-script.js"></script>
    <script src="../assets/js/jquery.ajaxchimp.min.js"></script>

    <!-- Jquery Plugins, main Jquery -->
    <script src="../assets/js/plugins.js"></script>
    <script src="../assets/js/main.js"></script>
</body>
</html>
