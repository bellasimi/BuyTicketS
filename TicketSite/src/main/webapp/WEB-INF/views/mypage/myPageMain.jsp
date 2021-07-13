<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<c:if test="${message=='cancel_order'}">
	<script>
		window.onload = function() {
			init();
		}

		function init() {
			alert("주문을 취소했습니다.");
		}
	</script>
</c:if>
<script>
	function fn_cancel_order(order_id) {
		var answer = confirm("주문을 취소하시겠습니까?");
		if (answer == true) {
			var formObj = document.createElement("form");
			var i_order_id = document.createElement("input");

			i_order_id.name = "order_id";
			i_order_id.value = order_id;

			formObj.appendChild(i_order_id);
			document.body.appendChild(formObj);
			formObj.method = "post";
			formObj.action = "${contextPath}/mypage/cancelMyOrder.do";
			formObj.submit();
		}
	}
</script>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
* {
	box-sizing: border-box
}

/* Set height of body and the document to 100% */
body, html {
	height: 100%;
	margin: 0;
	font-family: Arial;
}

/* Style tab links */
.tablink {
	background-color: #555;
	color: white;
	float: left;
	border: none;
	outline: none;
	cursor: pointer;
	padding: 14px 16px;
	font-size: 17px;
	width: 25%;
}

.tablink:hover {
	background-color: #777;
}

/* Style the tab content (and add height:100% for full page content) */
.tabcontent {
	color: white;
	display: none;
	padding: 100px 20px;
	height: 100%;
}

#OrderList {
	background-color: #cccccc;
}

#Point {
	background-color: #cccccc;
}

#MyInform {
	background-color: #cccccc;
}

#WishList {
	background-color: #cccccc;
}
</style>
</head>
<body>

	<button class="tablink" onclick="openPage('OrderList', this, 'gray')"
		id="defaultOpen">주문내역</button>
	<button class="tablink" onclick="openPage('Point', this, 'gray')">포인트</button>
	<button class="tablink" onclick="openPage('MyInform', this, 'gray')">내정보</button>
	<button class="tablink" onclick="openPage('WishList', this, 'gray')">위시리스트</button>

	<div id="OrderList" class="tabcontent">
		<h1>
			최근주문내역 <A href="listMyOrderHistory.do"> <IMG
				src="${contextPath}/resources/image/btn_more_see.jpg">
			</A>
		</h1>
		<table class="list_view">
			<tbody align=center>
				<tr style="background: gray">
					<td>주문번호</td>
					<td>주문일자</td>
					<td>주문상품</td>
					<td>상품리뷰</td>
					<td>예매마감일</td>
				</tr>

				<c:choose>
					<c:when test="${ empty myOrderList  }">
						<tr>
							<td colspan=5 class="fixed"><strong>주문한 상품이 없습니다.</strong></td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="item" items="${myOrderList }" varStatus="i">
							<tr>
								<td>
								<a href="${contextPath}/mypage/myOrderDetail.do?order_id=${item.order_id }"><span>${item.order_id }</span></a>
								</td>
								<td><span>${item.pay_order_time }</span></td>
								<td><strong> 
												<a
													href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">${item.goods_title }/${item.order_goods_qty }개</a>
												<br>
								</strong></td>
								<c:choose>
								<c:when test = "${review_state != review_confirm}">
								<td>리뷰 작성 완료</td>
								</c:when>
								<c:otherwise>
								<td><a href="${contextPath}/mypage/review.do?order_id=${item.order_id }">리뷰 미작성</a></td>
								</c:otherwise>
								</c:choose>
								<td>비는 구간2</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>

	<div id="Point" class="tabcontent">
		포인트 : member_point
		<table border=0 width=100% cellpadding=10 cellspacing=10>
			<tr>
				<td><strong>사용일자</strong></td>
				<td><strong>사용내역</strong></td>
				<td><strong>증감액</strong></td>
				<td><strong>잔여액</strong></td>
			</tr>

			<tr>
				<td>pay_order_time</td>
				<td>goods_title</td>
				<td>point_used</td>
				<td>member_point</td>
			</tr>
		</table>
	</div>

	<div id="MyInform" class="tabcontent">
		<h1>
			나의 정보 <a href="myDetailInfo.do"> <img
				src="${contextPath}/resources/image/btn_more_see.jpg" />
			</a>
		</h1>
		<table border=0 width=100% cellpadding=10 cellspacing=10>
			<tr>
				<td>이메일:</td>
				<td><strong>${memberInfo.email1 }@${memberInfo.email2 }</strong>
				</td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><strong>${memberInfo.hp1 }-${memberInfo.hp2}-${memberInfo.hp3 }</strong>
				</td>
			</tr>
		</table>
	</div>

	<div id="WishList" class="tabcontent">
	위시리스트 입니당!
	</div>

	<script>
		function openPage(pageName, elmnt, color) {
			var i, tabcontent, tablinks;
			tabcontent = document.getElementsByClassName("tabcontent");
			for (i = 0; i < tabcontent.length; i++) {
				tabcontent[i].style.display = "none";
			}
			tablinks = document.getElementsByClassName("tablink");
			for (i = 0; i < tablinks.length; i++) {
				tablinks[i].style.backgroundColor = "";
			}
			document.getElementById(pageName).style.display = "block";
			elmnt.style.backgroundColor = color;
		}

		// Get the element with id="defaultOpen" and click on it
		document.getElementById("defaultOpen").click();
	</script>

</body>
</html>

