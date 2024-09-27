<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>퀴즈 풀기</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script>
        function validateForm() {
            var valid = true;
            var questions = document.querySelectorAll('.question-group');
            questions.forEach(function(question, index) {
                var radios = question.querySelectorAll('input[type="radio"]');
                var answered = false;
                radios.forEach(function(radio) {
                    if (radio.checked) {
                        answered = true;
                    }
                });
                if (!answered) {
                    valid = false;
                    var error = question.querySelector('.error');
                    error.style.display = 'block';
                } else {
                    var error = question.querySelector('.error');
                    error.style.display = 'none';
                }
            });
            return valid;
        }

        function hideError(index) {
            document.getElementById('error' + index).style.display = 'none';
        }
    </script>
</head>
<body>

<div class="container mt-5">
    <div class="card">
        <div class="card-header text-center">
            <h2>${quizTitle}</h2>
        </div>
        <div class="card-body">
            <form:form method="post" action="${pageContext.request.contextPath}/quiz/submitQuiz" modelAttribute="quizForm" onsubmit="return validateForm()">
                <form:hidden path="quizSeq"/>
                <form:hidden path="userNickname" value="${userNickname}"/>
                <c:forEach items="${quizForm.questions}" var="question" varStatus="status">
                    <div class="mb-4 question-group">
                        <label class="font-weight-bold">질문 ${status.index + 1}: ${question.questionText}</label>
                        <form:hidden path="questions[${status.index}].questionSeq"/>
                        <form:hidden path="questions[${status.index}].questionText" value="${question.questionText}"/>
                        <form:hidden path="questions[${status.index}].correctAnswer" value="${question.correctAnswer}"/>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="questions[${status.index}].userAnswer" value="1" id="q${status.index}a1" onclick="hideError(${status.index})"/>
                            <label class="form-check-label" for="q${status.index}a1">
                                ${question.choice1}
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="questions[${status.index}].userAnswer" value="2" id="q${status.index}a2" onclick="hideError(${status.index})"/>
                            <label class="form-check-label" for="q${status.index}a2">
                                ${question.choice2}
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="questions[${status.index}].userAnswer" value="3" id="q${status.index}a3" onclick="hideError(${status.index})"/>
                            <label class="form-check-label" for="q${status.index}a3">
                                ${question.choice3}
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="questions[${status.index}].userAnswer" value="4" id="q${status.index}a4" onclick="hideError(${status.index})"/>
                            <label class="form-check-label" for="q${status.index}a4">
                                ${question.choice4}
                            </label>
                        </div>
                        <div id="error${status.index}" class="text-danger error" style="display:none;">답변을 선택하세요</div>
                    </div>
                </c:forEach>
                <div class="text-center">
                    <input type="submit" value="퀴즈 제출" class="btn btn-primary"/>
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
