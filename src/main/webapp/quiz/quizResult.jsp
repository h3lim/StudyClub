<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>퀴즈 결과</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

<div class="container mt-5">
    <div class="card">
        <div class="card-header text-center">
            <h2>퀴즈 결과</h2>
        </div>
        <div class="card-body">
            <h3 class="card-title text-center">최근 시도</h3>
            <div class="row justify-content-center">
                <div class="col-md-8 text-center">
                    <h4>점수: ${latestResult.score} / ${total}</h4>
                    <h4>날짜: <fmt:formatDate value="${latestResult.submitDate}" pattern="yyyy-MM-dd HH:mm"/></h4>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <h3 class="text-center">이전 시도</h3>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>점수</th>
                        <th>날짜</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="result" items="${previousResults}">
                        <tr>
                            <td>${result.score} / ${result.totalQuestions} </td> <!-- Use result.totalQuestions -->
                            <td>
                                <fmt:formatDate value="${result.submitDate}" pattern="yyyy-MM-dd HH:mm"/>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="text-center mt-3">
                <a href="<c:url value='/quiz/list/${userNickname}'/>" class="btn btn-primary">퀴즈 목록으로 돌아가기</a>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
