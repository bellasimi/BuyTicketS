<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입출금내역</title>
</head>
<body>
<table border="1">
<tr><th>이름</th><th>입금</th><th>출금</th><th>잔액</th></tr>
<c:forEach items="${list}" var="l">
	<tr><td>${l.name}</td><td>${l.input}</td><td>${l.withdraw}</td><td>${l.left}</td></tr>
</c:forEach>
</table>
<a href="${path}/hsy/form"><button>입출금</button></a>
</body>
</html>