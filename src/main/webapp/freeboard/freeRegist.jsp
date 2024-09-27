<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Free Board</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="manifest" href="site.webmanifest">
	<link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">

	<!-- CSS here -->
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
<section class="slider-area slider-area2">
	<div class="slider-active">
		<!-- Single Slider -->
		<div class="single-slider slider-height2" style="min-height: 320px;">
			<div class="container">
				<div class="row">
					<div class="col-xl-8 col-lg-11 col-md-12">
						<div class="hero__caption hero__caption2">
							<h1 data-animation="bounceIn" data-delay="0.2s">자유게시판</h1>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<br>
<br>
<section>
	<div class="container">
		<div class="row">
			<div class="col-xs-12 content-wrap">

				<form action="${pageContext.request.contextPath}/freeboard/freeRegist"
					method="post">
					<table class="table">
						<tbody class="t-control">
							<tr>
								<td class="t-title">NAME</td>
								<td><input class="form-control input-sm" name="writer"
									value="<c:out value='${sessionScope.SESS_NICKNAME}' />" readonly></td>
							</tr>
							<tr>
								<td class="t-title">TITLE</td>
								<td><input class="form-control input-sm" name="title"></td>
							</tr>
							<tr>
								<td class="t-title">CONTENT</td>
								<td><textarea class="form-control" rows="7" name="content"></textarea>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="titlefoot">
						<button class="btn" type="submit">등록</button>
						<button type="button" class="btn"
							onclick="location.href='${pageContext.request.contextPath}/freeboard/freeList'">목록</button>
					</div>
				</form>

			</div>
		</div>
	</div>
</section>

<!-- 푸터자리 -->
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
<br>
<br>
</body>
</html>
<%@include file="/footer.jsp"%>