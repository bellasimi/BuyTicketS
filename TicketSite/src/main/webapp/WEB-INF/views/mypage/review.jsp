<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰</title>
</head>
<body>
<form action="" method="get">
<table border=0 width=100% cellpadding=10 cellspacing=10 bgcolor="white">
<tr>
<td colspan="2">주문번호 :  ${order_id}</td>
<td colspan="4">상품명 :  ${goods_title}</td>
</tr>

<tr>
<td rowspan="2">별점</td>
<td>5점</td>
<td>4점</td>
<td>3점</td>
<td>2점</td>
<td>1점</td>
</tr>

<tr>
<td><input type="radio" name="score" value="5"></td>
<td><input type="radio" name="score" value="4"></td>
<td><input type="radio" name="score" value="3"></td>
<td><input type="radio" name="score" value="2"></td>
<td><input type="radio" name="score" value="1"></td>
</tr>

<tr>
<td>리뷰 내용</td>
<td width="800" colspan="5"><textarea name="review_context"></textarea></td>
</tr>

</table>
<input type="submit" value="작성완료입니당">
<input type="reset" value="다지워버릴거야">
</form>
</body>
</html>