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
<td>주문번호 :  ${order_id}</td>
<td>상품명 : <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">${goods_title}</a></td>
</tr>

<tr>
<td>리뷰 내용</td>
<td width="800"><input type="text" name="review_context"></td>
</tr>
<input type="submit" value="작성완료입니당">
<input type="reset" value="다지워버릴거야">
</form>


</table>
</body>
</html>