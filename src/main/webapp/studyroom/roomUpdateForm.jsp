<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Room</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.5.3/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h1 class="mb-4">Edit Room</h1>
    <form action="${pageContext.request.contextPath}/roomUpdate" method="post">
        <input type="hidden" name="roomId" value="${KEY_ROOMVO.roomId}">
        <div class="form-group">
            <label for="roomName">Room Name</label>
            <input type="text" class="form-control" id="roomName" name="roomName" value="${KEY_ROOMVO.roomName}" required>
        </div>
        <div class="form-group">
            <label for="roomDescription">Description</label>
            <textarea class="form-control" id="roomDescription" name="roomDescription" rows="3" required>${KEY_ROOMVO.roomDescription}</textarea>
        </div>
        <div class="form-group">
            <label for="maxUserCount">Max User Count</label>
            <input type="number" class="form-control" id="maxUserCount" name="maxUserCount" value="${KEY_ROOMVO.maxUserCount}" required>
        </div>
        <div class="form-group">
            <label for="roomPwd">Room Password</label>
            <input type="password" class="form-control" id="roomPwd" name="roomPwd" value="${KEY_ROOMVO.roomPwd}">
        </div>
        <button type="submit" class="btn btn-primary">Update Room</button>
        <a href="${pageContext.request.contextPath}/roomDetail?roomId=${KEY_ROOMVO.roomId}" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>