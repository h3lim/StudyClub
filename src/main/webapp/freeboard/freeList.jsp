<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@include file="/header.jsp"%>
<%@ page isELIgnored="false" %>
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
    <style>
        .search-btn {
            padding: 5px 5px;
            color: #787878;
            font-size: 14px;
            outline: none;
            box-shadow: none;
        }
        .search-btn:focus {
            outline: none;
            box-shadow: none;
        }

         a.black-link {
             color: black;
             text-decoration: none; /* 밑줄 제거 */
         }
        a.black-link:hover {
            color: black; /* 링크를 마우스로 가리킬 때도 검정색 유지 */
        }

    </style>
</head>
<body>
<main>
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
        <div class="container-fluid">
            <div class="row justify-content-center">
                <div class="col-lg-9 col-xs-12 mx-auto board-table">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th class="board-title">제목</th>
                                <th>작성자</th>
                                <th>등록일</th>
                                <th>수정일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="vo" items="${boardList}">
                            	<tr>
                            		<td>${vo.bno}</td>
	                            	<td>
	                            		<a href="${pageContext.request.contextPath}/freeboard/content/${vo.bno}?pageNum=${pc.paging.pageNum}&cpp=${pc.paging.cpp}&keyword=${pc.paging.keyword}&condition=${pc.paging.condition}" class="black-link">${vo.title}</a>
                                        &nbsp;
                                        <strong>[${vo.replyCnt}]</strong>
                                    </td>
	                            	<td>${vo.writer}</td>
	                            	<td>
	                            		<fmt:parseDate value="${vo.regDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
	                            		<fmt:formatDate value="${parsedDateTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
	                            	</td>
	                            	<td>
	                            		<fmt:parseDate value="${vo.updateDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedUpdateTime" type="both" />
	                            		<fmt:formatDate value="${parsedUpdateTime}" pattern="yyyy년 MM월 dd일 HH시 mm분" />
	                            	</td>
                            	</tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <!--form select를 가져온다 -->
                    <form action="freeboard/freeList" class="form-inline">
                        <div class="search-wrap">
                            <input type="text" name="keyword" class="form-control search-input mr-2" value="${pc.paging.keyword}" placeholder="검색어를 입력하세요" style="width: 300px; height: 40px">
                            <select name="condition" class="form-control search-select mr-2">
                                <option value="title" ${pc.paging.condition == 'title' ? 'selected' : ''}>제목</option>
                                <option value="content" ${pc.paging.condition == 'content' ? 'selected' : ''}>내용</option>
                                <option value="writer" ${pc.paging.condition == 'writer' ? 'selected' : ''}>작성자</option>
                                <option value="titleContent" ${pc.paging.condition == 'titleContent' ? 'selected' : ''}>제목+내용</option>
                            </select>
                            <button type="submit" class="btn-primary " style="border-radius: 9px; padding: 8px;">검색</button>
                        </div>
                    </form>
		        <!--페이지 네이션을 가져옴-->
		    <form action="${pageContext.request.contextPath}/freeboard/freeList" name="pageForm">
                    <div class="text-center">
                    <hr>
                    <ul id="pagination" class="pagination pagination-sm">
                    	<c:if test="${pc.prev}">
                        	<li><a href="#" data-pagenum="${pc.beginPage-1}">이전</a></li>
                        </c:if>

                        <c:forEach var="num" begin="${pc.beginPage}" end="${pc.endPage}">
	                        <li class="${pc.paging.pageNum == num ? 'active' : ''}">
	                        	<a href="#" data-pagenum="${num}">${num}</a>
	                        </li>
                        </c:forEach>

                        <c:if test="${pc.next}">
                        	<li><a href="#" data-pagenum="${pc.endPage+1}">다음</a></li>
                        </c:if>
                    </ul>
                        <div class="text-center">
                            <a href="${pageContext.request.contextPath}/freeboard/freeRegist" class="button btn-block" style="padding: 10px 20px; background-color: #28A745; color: white; border-radius: 5px; text-decoration: none;">글쓰기</a>
                        </div>
                    </div>
                    <input type="hidden" name="pageNum" value="${pc.paging.pageNum}">
                    <input type="hidden" name="cpp" value="${pc.paging.cpp}">
                    <input type="hidden" name="keyword" value="${pc.paging.keyword}">
                    <input type="hidden" name="condition" value="${pc.paging.condition}">
		    </form>
                </div>
            </div>
        </div>
	</section>
</main>
	<!-- 푸터자리 -->
	<script>
        window.onload = function() {

            document.getElementById('pagination').addEventListener('click', e => {
                if(!e.target.matches('a')) {
                    return;
                }
                e.preventDefault();

                const value = e.target.dataset.pagenum;

                document.pageForm.pageNum.value = value;
                document.pageForm.submit();

            });
        }

	</script>
<br>
<br>
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
	
	
	