<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
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
	background-color: #2196F3;
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
	color: black;
	background-color: white;
}

/* Style the tab content (and add height:100% for full page content) */
.tabcontent {
	color: black;
	background-color:white;
	display: none;
	padding: 100px 20px;
	height: 100%;
}
  
.another{
	color : white;
	background-color: #2196F3;
}

.tex{
	text-align : center;
}

#OrderList {
	background-color: #E6F2FF;
}

#Point {
	background-color: #E6F2FF;
}

#MyInform {
	background-color: #E6F2FF;
}

#WishList {
	background-color: #E6F2FF;
}
</style>
</head>
<body>

	<button class="tablink" onclick="openPage('OrderList', this, '#2196F3')"
		id="defaultOpen">주문내역</button>
	<button class="tablink" onclick="openPage('Point', this, '#2196F3')">포인트</button>
	<button class="tablink" onclick="openPage('MyInform', this, '#2196F3')">내정보</button>
	<button class="tablink" onclick="openPage('WishList', this, '#2196F3')">위시리스트</button>

	<div id="OrderList" class="tabcontent">
		<h1>
			최근주문내역 <A href="listMyOrderHistory.do"> 
			<IMG src="${contextPath}/resources/image/btn_more_see.jpg">
			</A>
		</h1>
		<table class="list_view">
			<tbody align=center>
				<tr class="another">
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
								${item.order_id }
								</td>
								<td><span>${item.pay_order_time }</span></td>
								<td><strong>
								<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">${item.goods_title }/${item.order_goods_qty }개</a><br>
								</strong></td>
								<c:choose>
									<c:when test = "${item.review_state != 'review_confirm'}">
										<td><a href="${contextPath}/mypage/review.do?order_id=${item.order_id}&goods_title=${item.goods_title}&order_seq_num=${item.order_seq_num}">리뷰 미작성</a></td>
									</c:when>
									
									<c:otherwise>
									<td>
									리뷰 작성 완료
									</td>
									</c:otherwise>
								</c:choose>
								<td>${item.goods_ticket_date }</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>

	<div id="Point" class="tabcontent">
		포인트 : <c:choose>
		<c:when test="${not empty myOrderList}">
		${member_point}
		</c:when>
		<c:otherwise>
		0
		</c:otherwise>
		</c:choose>
		<table border=0 width=100% cellpadding=10 cellspacing=10>
			<tr>
				<td><strong>주문번호</strong></td>
				<td><strong>변경날짜</strong></td>
				<td><strong>증가포인트</strong></td>
				<td><strong>사용포인트</strong></td>
			</tr>
		<c:choose>
			<c:when test="${ empty myOrderList  }">
					<tr>
						<td colspan=4 class="fixed"><strong>포인트 내역이 없습니다.</strong></td>
					</tr>
			</c:when>
			
			<c:otherwise>
				<c:forEach var="item" items="${myOrderList }" varStatus="i">
					<tr>
						<td><a href="${contextPath}/mypage/myOrderDetail.do?order_id=${item.order_id }"><span>${item.order_id }</span></a></td>
						<td><span>${item.pay_order_time }</span></td>
						<td>${item.goods_point }</td>
						<td>${item.point_used}</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
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
	<table id="list_view">
	<tr style="background-color: #2196F3; color: white;"><td>&emsp;<input type="checkbox" id="checkall" ></td><td></td><td>&emsp;상품명</td><td>&emsp;원가</td><td>&emsp;&emsp;할인율</td><td>&emsp;할인가</td><td></td></td>
		<tbody>
		 <c:choose>
		 <c:when test="${empty goodsList}">
		 <tr><td class="tex" colspan=8>위시리스트에 등록된 상품이 없습니다.</td></tr>
		 </c:when>
		 <c:otherwise>
		  <c:forEach var="item" items="${goodsList}"> 
			<tr>
					<td>&emsp;<input type="checkbox" id="checked_goods" name="checked_goods"  value="${item.goods_id}" ></td>
					<td class="goods_image">
						<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
							   <img width="75" alt="" src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"/>
						</a>
					</td>
					<td class="goods_description">
						<h2>
							<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">${item.goods_title }</a>
						</h2>
						
						<div class="writer_press" >
						판매종료일: ${item.goods_lastsale_date} | 유효기간: ${item.goods_expired_date}까지|
						<c:out value="${arr[0]}" />
						</div>
					</td>
					<td class="price">
						<fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />		        
						<span>${goods_price}원</span>						
					</td>
					<td class="price">
						<strong>${item.goods_discount}% 할인</strong>					
					</td>
					<td class="price">
						<strong>
						<fmt:formatNumber  value="${item.goods_sales_price}" type="number" var="goods_sales_price" />
				               ${goods_sales_price}원 
						</strong>			
					</td>
					
				<!-- 
	<td class="buy_btns2">  main.css 702,705 a끼리 줄바꿈 안되게 수정 display: block;삭제 -->
	
	<td class="buy_btns">
						<UL>
						<li><a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">예매</a></li>
						<li><a href="${contextPath}/goods/deletewish.do?goods_id=${item.goods_id}">삭제</a></li>
						
							
						</UL>
					</td>

			</tr>
			</c:forEach>
			</c:otherwise>
			</c:choose>
	</tbody>
		
	</table>
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

