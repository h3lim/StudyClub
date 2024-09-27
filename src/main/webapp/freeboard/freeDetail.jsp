<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page isELIgnored="false" %>
<%@include file="/header.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>Detail Board</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="manifest" href="site.webmanifest">
	<link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
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
				<div class="col-xs-12 col-md-9 write-wrap">

					<form action="<c:url value='${pageContext.request.contextPath}/freeboard/modify' />" method="post">
						<div>
							<label>DATE</label>
							<c:if test="${article.updateDate == null}">
								<p>
									<fmt:parseDate value="${article.regDate}"
										pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime"
										type="both" />
									<fmt:formatDate value="${parsedDateTime}"
										pattern="yyyy년 MM월 dd일 HH시 mm분" />

								</p>
							</c:if>
							<c:if test="${article.updateDate != null}">
								<p>
									<fmt:parseDate value="${article.updateDate}"
										pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime"
										type="both" />
									<fmt:formatDate value="${parsedDateTime}"
										pattern="yyyy년 MM월 dd일 HH시 mm분" />
								</p>
							</c:if>
						</div>
						<div class="form-group">
							<label>번호</label> <input class="form-control" name="bno"
								value="${article.bno}" readonly>
						</div>
						<div class="form-group">
							<label>작성자</label> <input class="form-control" name="writer"
								value="${article.writer}" readonly>
						</div>
						<div class="form-group">
							<label>제목</label> <input class="form-control" name="title"
								value="${article.title}" readonly>
						</div>

						<div class="form-group">
							<label>내용</label>
							<textarea class="form-control" rows="10" name="content" readonly>${article.content}</textarea>
						</div>
						<c:choose>
							<c:when test="${sessionScope.SESS_NICKNAME == article.writer}">
						<button type="submit" class="btn btn-primary"
							onclick="return confirm('변경 페이지로 이동합니다.')">변경</button>
						<a href="#" class="btn btn-outline-danger" id="confirmDeleteBtn">삭제</a>
							</c:when>
						</c:choose>
						<button type="button" class="btn btn-dark"
							onclick="location.href='${pageContext.request.contextPath}/freeboard/freeList?pageNum=${p.pageNum}&cpp=${p.cpp}&keyword=${p.keyword}&condition=${p.condition}'">목록</button>
					</form>
				</div>
			</div>
		</div>

	</section>
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
<script>
	$(document).ready(function() {
		// 삭제 버튼 클릭 시 모달 열기
		$("#confirmDeleteBtn").click(function() {
			$("#confirmDeleteModal").modal("show");
		});

		// 모달에서 삭제 확인 버튼 클릭 시 게시글 번호를 포함한 폼 생성하여 전송
		$("#deleteConfirmBtn").click(function() {
			var bno = "${article.bno}";  // 현재 게시글 번호

			if (!bno) {
				console.error("게시글 번호가 없습니다.");
				return;
			}

			var form = document.createElement('form');
			form.method = 'POST';
			form.action = 'delete';

			var input = document.createElement('input');
			input.type = 'hidden';
			input.name = 'bno';
			input.value = bno;

			form.appendChild(input);
			document.body.appendChild(form);
			form.submit();

			// 모달 닫기
			$("#confirmDeleteModal").modal("hide");
		});
	});
</script>

	<!-- 댓글 영역 시작부분 -->
	<section style="margin-top: 80px;">
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-md-9 write-wrap">
					<form class="reply-wrap">
						<!--여기에 접근 반복-->
						<div id="replyList">

							<!-- 자바스크립트 단에서 반복문을 이용해서 댓글의 개수만큼 반복 표현.
                        <div class='reply-wrap'>
                            <div class='reply-image'>
                                <img src='../resources/img/profile.png'>
                            </div>
                            <div class='reply-content'>
                                <div class='reply-group'>
                                    <strong class='left'>honggildong</strong>
                                    <small class='left'>2019/12/10</small>
                                    <a href='#' class='right'><span class='glyphicon glyphicon-pencil'></span>수정</a>
                                    <a href='#' class='right'><span class='glyphicon glyphicon-remove'></span>삭제</a>
                                </div>
                                <p class='clearfix'>여기는 댓글영역</p>
                            </div>
                        </div>
                        -->

						</div>
						<!--form-control은 부트스트랩의 클래스입니다-->
						<div class="reply-content">
							<textarea class="form-control" rows="3" id="reply"></textarea>
							<div class="reply-group">
								<div class="reply-input">
									<input type="text" class="form-control" id="replyId"
										placeholder="이름"> <input type="password"
										class="form-control" id="replyPw" placeholder="비밀번호">
								</div>

								<button type="button" id="replyRegist"
									class="right btn btn-info">등록하기</button>
							</div>

						</div>
					</form>


					<button type="button" class="form-control" id="moreList"
						style="display: none;">더보기(페이징)</button>
				</div>
			</div>
		</div>
	</section>

	<!-- 모달 -->
	<div class="modal fade" id="replyModal" role="dialog">
		<div class="modal-dialog modal-md">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="btn btn-default pull-right"
						data-dismiss="modal">닫기</button>
					<h4 class="modal-title">댓글 수정</h4>
				</div>
				<div class="modal-body">
					<!-- 수정폼 id값을 확인하세요-->
					<div class="reply-content">
						<textarea class="form-control" rows="4" id="modalReply"
							placeholder="내용입력"></textarea>
						<div class="reply-group">
							<div class="reply-input">
								<input type="hidden" id="modalRno"> <input
									type="password" class="form-control" placeholder="비밀번호"
									id="modalPw">
							</div>
							<button class="right btn btn-info" id="modalModBtn">수정하기</button>
							<button class="right btn btn-info" id="modalDelBtn">삭제하기</button>
						</div>
					</div>
					<!-- 수정폼끝 -->
				</div>
			</div>
		</div>
	</div>

	<script>
    window.onload = function () {

        document.getElementById('replyRegist').onclick = () => {

            console.log('댓글 등록 이벤트 발생!');

            const bno = '${article.bno}'; //현재 게시글 번호
            const reply = document.getElementById('reply').value;
            const replyId = document.getElementById('replyId').value;
            const replyPw = document.getElementById('replyPw').value;

            if (reply === '' || replyId === '' || replyPw === '') {
                alert('이름, 비밀번호, 내용을 입력하세요!');
                return;
            }

            //요청에 관련된 정보 객체
            const reqObj = {
                method: 'post',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    'bno': bno,
                    'reply': reply,
                    'replyId': replyId,
                    'replyPw': replyPw
                })
            };

            fetch('${pageContext.request.contextPath}/reply/regist', reqObj)
                .then(res => res.text())
                .then(data => {
                    console.log('통신 성공!: ' + data);
                    document.getElementById('reply').value = '';
                    document.getElementById('replyId').value = '';
                    document.getElementById('replyPw').value = '';
                    //등록 완료 후 댓글 목록 함수를 호출해서 비동기식으로 목록 표현.
                    getList(1, true);
                });

        } //댓글 등록 이벤트 끝.

        
        
        //더보기 버튼 처리(클릭 시 전역 변수 page에 +1 한 값을 요청)
        document.getElementById('moreList').onclick = () => {
            /*
            왜 falss?
            더보기잖아요. 댓글을 누적해서 보여줘야 함.
            1페이지의 댓글 내용 밑에다가 2페이지를 누적해서 깔앙랴지
            1페이지 내용을 없애고 2페이지를 보여주자는 것은 아니기에.
            */
            getList(++page, false);
        }



        let page = 1; //전역 의미로 사용할 페이지 번호
        let strAdd = ''; //화면에 그려넣을 태그를 문자열의 형태로 추가할 변수
        const $replyList = document.getElementById('replyList');

        //게시글 상세보기 화면에 처음 진입했을 시 댓글 리스트를 한 번 불러오자.
        getList(1, true);

        
        
        
        
        
        
        
        function getList(pageNum, reset) {
            strAdd = '';
            const bno = '${article.bno}'; //게시글 번호
            
            //get방식으로 댓글 목록을 요청(비동기)
            fetch('${pageContext.request.contextPath}/reply/getList/' + bno + '/' + pageNum)
                .then(res => res.json())
                .then(data => {
                    console.log(data);

                    let total = data.total; //총 댓글 수
                    let replyList = data.list; //댓글 리스트

                    if (reset) {
                        while ($replyList.firstChild) {
                            $replyList.firstChild.remove();
                        }
                        page = 1;
                    }

                    if (replyList.length <= 0) return;


                    console.log('현재 페이지: ' + page);
                    if (total <= page * 5) {
                        document.getElementById('moreList').style.display = 'none';
                    } else {
                        document.getElementById('moreList').style.display = 'block';
                    }

                    //replyList의 개수만큼 태그를 문자열 형태로 직접 그림.
                    //중간에 들어갈 글쓴이, 날짜, 댓글 내용은 목록에서 꺼내서 표현.
                    for (let i = 0; i < replyList.length; i++) {
                        strAdd += `
                        <div class='reply-wrap'>

                        <div class='reply-content'>
                            <div class='reply-group'>
                                <strong class='left'>` + replyList[i].replyId + ` </strong>
                                <small class='left'>` + (replyList[i].updateDate != null ? parseTime(replyList[i].updateDate) + ' (수정됨)' : parseTime(replyList[i].replyDate)) + `</small>
                                <a href='` + replyList[i].rno + `' class='right replyDelete'><span class='glyphicon glyphicon-remove'></span>삭제</a> &nbsp;
                                <a href='` + replyList[i].rno + `' class='right replyModify'><span class='glyphicon glyphicon-pencil'></span>수정</a>
                            </div>
                            <p class='clearfix'>` + replyList[i].reply + `</p>
                        </div>
                    </div>`;

                    }

                    //id가 replyList라는 div 영역에 문자열 형식으로 모든 댓글을 추가.
                    if (!reset) { //댓글이 추가되면서 보는 것
                        document.getElementById('replyList').insertAdjacentHTML('beforeend', strAdd);
                    } else { //다 삭제하고 보는 것
                        document.getElementById('replyList').insertAdjacentHTML('afterbegin', strAdd);
                    }


                })
                .catch(error => {
                    console.error('댓글 목록을 불러오는 중 오류 발생:', error);
                });
        } // end getList();


        
        
        
        document.getElementById('replyList').addEventListener('click', e => {
            e.preventDefault(); //태그의 고유 기능을 중지.

            if (!e.target.matches('a')) {
                return;
            }

            const rno = e.target.getAttribute('href');
            console.log('댓글 번호: ' + rno);
            document.getElementById('modalRno').value = rno;

            const content = e.target.parentNode.nextElementSibling.textContent;
            console.log('댓글 내용: ' + content);

     
            if (e.target.classList.contains('replyModify')) {
                document.querySelector('.modal-title').textContent = '댓글 수정';
                document.getElementById('modalReply').style.display = 'inline'; //댓글창
                document.getElementById('modalReply').value = content;
                document.getElementById('modalModBtn').style.display = 'inline';
                document.getElementById('modalDelBtn').style.display = 'none';

                $('#replyModal').modal('show');

            } else {
                document.querySelector('.modal-title').textContent = '댓글 삭제';
                document.getElementById('modalReply').style.display = 'none'; //댓글창
                document.getElementById('modalModBtn').style.display = 'none';
                document.getElementById('modalDelBtn').style.display = 'inline';
                $('#replyModal').modal('show');
            }
        }); //수정 or 삭제 버튼 클릭 이벤트 끝.


        document.getElementById('modalModBtn').onclick = () => {

            const reply = document.getElementById('modalReply').value;
            const rno = document.getElementById('modalRno').value;
            const replyPw = document.getElementById('modalPw').value;

            if (reply === '' || replyPw === '') {
                alert('내용, 비밀번호를 확인하세요!');
                return;
            }

            //요청에 관련된 정보 객체
            const reqObj = {
                method: 'put',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    'reply': reply,
                    'replyPw': replyPw
                })
            };

            fetch('${pageContext.request.contextPath}/reply/' + rno, reqObj)
                .then(res => res.text())
                .then(data => {
                    if (data === 'pwFail') {
                        alert('비밀번호를 확인하세요.');
                        document.getElementById('modalPw').value = '';
                        document.getElementById('modalPw').focus();
                    } else {
                        alert('정상 수정 되었습니다.');
                        document.getElementById('modalReply').value = '';
                        document.getElementById('modalPw').value = '';
                        //제이쿼리 문법으로 bootstrap 모달 닫아주기
                        $('#replyModal').modal('hide');
                        getList(1, true);
                    }
                });
        } //end update event

        //삭제 이벤트
        document.getElementById('modalDelBtn').onclick = () => {

            const rno = document.getElementById('modalRno').value;
            const replyPw = document.getElementById('modalPw').value;

            if (replyPw === '') {
                alert('비밀번호를 확인하세요!');
                return;
            }

            fetch('${pageContext.request.contextPath}/reply/' + rno, {
                    method: 'delete',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        'replyPw': replyPw
                    })
                })
                .then(res => res.text())
                .then(data => {
                    if (data === 'delSuccess') {
                        alert('댓글이 삭제되었습니다.');
                        document.getElementById('modalPw').value = '';
                        $('#replyModal').modal('hide');
                        getList(1, true);
                    } else {
                        alert('비밀번호가 틀렸습니다.');
                        document.getElementById('modalPw').value = '';
                        document.getElementById('modalPw').focus();
                    }
                });

        } //end delete event


        //댓글 날짜 변환 함수
        function parseTime(regDateTime) {
            let year, month, day, hour, minute, second;

            if(regDateTime.length === 5) {
                [year, month, day, hour, minute] = regDateTime;
                second = 0;
            } else {
                [year, month, day, hour, minute, second] = regDateTime;
            }

            console.log(`${year}, ${month}, ${day}, ${hour}, ${minute}, ${second}`);

            //원하는 날짜로 객체를 생성
            const regTime = new Date(year, month-1, day, hour, minute, second);
            console.log(regTime);
            const date = new Date();
            console.log(date);
            const gap = date.getTime() - regTime.getTime();

            let time;
            if(gap < 60 * 60 * 24 * 1000) {
                if(gap < 60 * 60 * 1000) {
                    time = '방금 전';
                } else {
                    time = parseInt(gap / (1000 * 60 * 60)) + '시간 전';
                }
            } else if(gap < 60 * 60 * 24 * 30 * 1000) {
                time = parseInt(gap / (1000 * 60 * 60 * 24)) + '일 전';
            } else {
                time = `${regTime.getFullYear()}년 ${regTime.getMonth()-1}월 ${regTime.getDate()}일`;
            }

            return time;
        }





    } //window.onload
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
<%@include file="/footer.jsp"%>