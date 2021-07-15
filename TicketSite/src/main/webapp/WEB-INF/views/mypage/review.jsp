<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<style>
table,tr,td {
	border : 1px solid black;
	border-collapse: collapse;
	bordercolor="black" ;
	cellpadding=10 ;
	cellspacing=10 ;
	bgcolor="white";
	text-align : center;
};

title{
	text-align : center;

};

</style>

<style type="text/css">
textarea{resize:none;}
</style>

<head>
<meta charset="UTF-8">
<title>리뷰</title>
<!-- 그러면 시퀀스 번호를 가져왔으니까... 흠.... 개별로 진행이 가능...? 그럼 보내기는 편해질 것 같다... -->
</head>

<body>
<h1 class=title>리뷰페이지입니다.</h1>
<hr>
<form action="/bts/mypage/updateMyReview.do" method="post"> <!-- 페이지이동하면서 자연스럽게 보낼 수 있는 방법...-->
<table>
<tr>
<td colspan="2" bgcolor="gray">주문번호 :  ${order_id}</td>
<td colspan="4" bgcolor="gray">상품명 :  ${goods_title}</td>
</tr>

<tr >
<td id=star rowspan="2" width="100">별점</td>
<td id=star width="100">5점</td>
<td id=star width="100">4점</td>
<td id=star width="100">3점</td>
<td id=star width="100">2점</td>
<td id=star width="100">1점</td>
</tr>

<tr>
<td><input type="radio" name="review_star" value="5"></td>
<td><input type="radio" name="review_star" value="4"></td>
<td><input type="radio" name="review_star" value="3"></td>
<td><input type="radio" name="review_star" value="2"></td>
<td><input type="radio" name="review_star" value="1"></td>
</tr>

<tr>
<td>리뷰 내용</td>
<td colspan="5"><textarea name="review_content" rows="12" cols="69"></textarea></td>
</tr>

</table>
<input type="hidden" name="order_seq_num" value="${order_seq_num}" />
<input type="hidden" name="member_id" value="${member_id}" />
<input type="submit" value="작성완료입니당">
<input type="reset" value="다지워버릴거야">
</form>
<a href="${contextPath}/mypage/myPageMain.do">마이페이지</a>
</body>
</html>