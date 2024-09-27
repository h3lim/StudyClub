<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Room</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.5.3/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h1 class="mb-4">방 만들기</h1>
    <form action="${pageContext.request.contextPath}/roomInsert" method="post" id="roomInsertForm">
        <div class="form-group">
            <label for="roomName">방 이름을 입력하세요</label>
            <input type="text" class="form-control" id="roomName" name="roomName" required>
        </div>
        <div class="form-group">
            <label for="roomDescription">내용을 입력하세요</label>
            <textarea class="form-control" id="roomDescription" name="roomDescription" rows="3" required></textarea>
        </div>
        <div class="form-group">
            <label for="maxUserCount">최대 유저 수 (1명 ~ 4명)</label>
            <input type="number" class="form-control" id="maxUserCount" name="maxUserCount" min="1" max="4" required>
        </div>
        <div class="form-group">
            <label for="roomPwd">방 비밀번호</label>
            <input type="password" class="form-control" id="roomPwd" name="roomPwd">
        </div>
        <td><input class="form-control input-sm" name="userNickname"
                   value="${sessionScope.SESS_NICKNAME}" readonly></td>
        <button type="submit" class="btn btn-primary">방 만들기</button>
        <a href="${pageContext.request.contextPath}/roomList" class="btn btn-secondary">뒤로가기</a>
    </form>
</div>
<script>
    document.getElementById('roomInsertForm').addEventListener('submit', function(event) {
        var maxUserCount = document.getElementById('maxUserCount').value;
        if (maxUserCount < 1 || maxUserCount > 4) {
            alert('최대 유저 수는 1명에서 4명 사이여야 합니다.');
            event.preventDefault(); // 폼 제출을 막음
        }
    });
</script>
</body>
</html>
