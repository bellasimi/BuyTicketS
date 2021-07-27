<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<style>
table{
	padding:5%;
	bgcolor:white;
	margin-left: auto;
    margin-right: auto;
}

tr,td{
	padding : 10px;
	text-align : center;
}
.hide{
	text-align : left;
}
.order{
	background-color : #2196F3;
	color : #E6F2FF;
}

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
<form action="/bts/mypage/updateMyReview.do" method="post"> 
<table>
<tr>
<td class="order" colspan="2"><h1>주문번호 :  ${order_id}</h1></td>
<td class="order" colspan="4"><h1>상품명 :  ${goods_title}</h1></td>
</tr>

<tr>
<td class="order" id=star rowspan="2" width="100"><h1>별점</h1></td>
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
<td class="order"><h1>리뷰 내용</h1></td>
<td colspan="5"><textarea name="review_content" rows="12" cols="69"></textarea></td>
</tr>

<tr>
<td  class="hide"><input type="submit" value="작성완료입니당"></td>
<td  class="hide" colspan="5"><input type="reset" value="다지워버릴거야"></td>
</tr>

<tr><td class="hide" colspan="6"><a href="${contextPath}/mypage/myPageMain.do"><h1>되돌아가기</h1></a></td></tr>

</table>
<input type="hidden" name="order_seq_num" value="${order_seq_num}" />
<input type="hidden" name="member_id" value="${member_id}" />
</form>
</body>
</html>