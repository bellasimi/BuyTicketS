<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>result</title>
</head>
<body>
<h1>인출결과</h1>
<table>
<tr><td>이름</td><td>${d.name}</td></tr>
<tr><td>입금액</td><td>${d.input}</td></tr>
<tr><td>인출액</td><td>${d.withdraw}</td></tr>
<tr><td>잔액</td><td>${d.left}</td></tr>

</table>
<p>
<a href="${path}/hsy/bankout"><button>입출금내역</button></a>
</body>
</html>