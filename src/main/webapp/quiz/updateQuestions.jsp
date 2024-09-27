<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>질문 수정</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

<div class="container mt-5">
    <div class="card">
        <div class="card-header text-center">
            <h2>질문 수정</h2>
        </div>
        <div class="card-body">
            <form:form method="post" action="${pageContext.request.contextPath}/quiz/updateQuestions" modelAttribute="quizForm">
                <form:hidden path="quizSeq"/>
                <form:hidden path="userNickname" value="${quizForm.userNickname}"/>

                <c:forEach items="${quizForm.questions}" var="question" varStatus="status">
                    <div class="mb-4">
                        <label class="font-weight-bold">질문 ${status.index + 1}</label>
                        <form:hidden path="questions[${status.index}].questionSeq"/>

                        <div class="form-group">
                            <label for="questionText${status.index}">질문 내용:</label>
                            <form:input path="questions[${status.index}].questionText" placeholder="질문 내용을 입력하세요" class="form-control mb-2" id="questionText${status.index}"/>
                            <form:errors path="questions[${status.index}].questionText" cssClass="text-danger"/>
                        </div>

                        <div class="form-group">
                            <label for="choice1${status.index}">선택지 1:</label>
                            <form:input path="questions[${status.index}].choice1" placeholder="선택지 1을 입력하세요" class="form-control" id="choice1${status.index}"/>
                            <form:errors path="questions[${status.index}].choice1" cssClass="text-danger"/>
                        </div>

                        <div class="form-group">
                            <label for="choice2${status.index}">선택지 2:</label>
                            <form:input path="questions[${status.index}].choice2" placeholder="선택지 2을 입력하세요" class="form-control" id="choice2${status.index}"/>
                            <form:errors path="questions[${status.index}].choice2" cssClass="text-danger"/>
                        </div>

                        <div class="form-group">
                            <label for="choice3${status.index}">선택지 3:</label>
                            <form:input path="questions[${status.index}].choice3" placeholder="선택지 3을 입력하세요" class="form-control" id="choice3${status.index}"/>
                            <form:errors path="questions[${status.index}].choice3" cssClass="text-danger"/>
                        </div>

                        <div class="form-group">
                            <label for="choice4${status.index}">선택지 4:</label>
                            <form:input path="questions[${status.index}].choice4" placeholder="선택지 4을 입력하세요" class="form-control" id="choice4${status.index}"/>
                            <form:errors path="questions[${status.index}].choice4" cssClass="text-danger"/>
                        </div>

                        <div class="form-group">
                            <label for="correctAnswer${status.index}">정답:</label>
                            <form:select path="questions[${status.index}].correctAnswer" class="form-control" id="correctAnswer${status.index}">
                                <form:option value="1">1</form:option>
                                <form:option value="2">2</form:option>
                                <form:option value="3">3</form:option>
                                <form:option value="4">4</form:option>
                            </form:select>
                            <form:errors path="questions[${status.index}].correctAnswer" cssClass="text-danger"/>
                        </div>
                    </div>
                </c:forEach>

                <div class="text-center">
                    <input type="submit" value="질문 수정" class="btn btn-primary"/>
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
