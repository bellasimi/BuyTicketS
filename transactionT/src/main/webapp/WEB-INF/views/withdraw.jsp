<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인출</title>
</head>
<body>
<h1>인출</h1>
<form action="withdraw" method="get">
<!-- 얘는 계속 입력됨!
<input type ="hidden" name="input" value="10000"> -->
이름 <input type ="text" name="name"><p>
임금액 <input type ="text" name="input"><p>
인출금액 <input type ="text" name="withdraw"><p>

<input type="submit" value="인출">
<input type="reset" value="취소">


</form>

</body>
</html>