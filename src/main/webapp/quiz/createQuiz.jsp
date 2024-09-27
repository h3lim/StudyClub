<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>퀴즈 만들기</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

<div class="container mt-5">
    <div class="card">
        <div class="card-header text-center">
            <h2>새 퀴즈 만들기</h2>
        </div>
        <div class="card-body">
            <form:form method="post" action="${pageContext.request.contextPath}/quiz/create" modelAttribute="quizVO">
                <div class="form-group">
                    <label for="quizTitle">퀴즈 제목:</label>
                    <form:input path="quizTitle" id="quizTitle" class="form-control"/>
                    <form:errors path="quizTitle" cssClass="text-danger"/>
                </div>
                <div class="form-group">
                    <label for="questionCnt">질문 수:</label>
                    <form:input type="number" path="questionCnt" id="questionCnt" class="form-control"/>
                    <form:errors path="questionCnt" cssClass="text-danger"/>
                </div>
                <!-- Use hidden input for userNickname -->
                <form:hidden path="userNickname"/>
                <div class="text-center">
                    <input type="submit" value="퀴즈 만들기" class="btn btn-primary"/>
                </div>
            </form:form>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
