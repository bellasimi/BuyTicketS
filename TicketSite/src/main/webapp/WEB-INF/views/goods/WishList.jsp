<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
     //치환 변수 선언합니다.
      pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
      pageContext.setAttribute("br", "<br/>"); //br 태그
%> 
<head>
<script type="text/javascript">
$(document).ready(function(){
	var listmenu = $('#listmenu').val();
	console.log(listmenu);
	if(listmenu == 'list1'){
	 	 $('#list1').attr('class','active');}
	else if (listmenu == 'list2'){
		 $('#list2').attr('class','active');}
	else if (listmenu == 'list3'){
		 $('#list3').attr('class','active');}
	else if (listmenu == 'list4'){
		 $('#list4').attr('class','active');}
	
});
</script>
 <title>위시리스트</title>
</head>
<body>
	<hgroup>
		<h1>위시리스트</h1>
	</hgroup>
	<input type="hidden" value="${listmenu}" id="listmenu"/>
	<div id="sorting">
		<ul>

			<li><a id="list1" href="${contextPath}/goods/wishlastsale.do">판매 종료 임박</a></li>
			<li><a id="list2" href="${contextPath}/goods/wishcheap.do">가격 오름차순</a></li>
			<li><a id="list3" href="${contextPath}/goods/wishdiscount.do">할인율순</a></li>
			<li><a id="list4" style="border: currentColor; border-image: none;" href="${contextPath}/goods/wishrate.do">평점순</a></li>

		</ul>
	</div>
	<table id="list_view">
	
		<tbody>
		  <c:forEach var="item" items="${goodsList}"> 
			<tr>
					<td><input type="checkbox" value=""></td>
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
					<span>${item.goods_price}원</span><br>
						<strong>
						<fmt:formatNumber  value="${item.goods_sales_price}" type="number" var="goods_sales_price" />
				               ${goods_sales_price}원 
						</strong><br>(${item.goods_discount}% 할인)
					</td>
				<!-- 
	<td class="buy_btns2">  main.css 702,705 a끼리 줄바꿈 안되게 수정 display: block;삭제 -->
	
	<td class="buy_btns">
						<UL>
						<li><a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">구매</a></li>
						<li><a href="${contextPath}/goods/deletewish.do?goods_id=${item.goods_id}">삭제</a></li>
						
							
						</UL>
					</td>

			</tr>
			</c:forEach>
		</tbody>
		<td class="buy_btns" style="width:20px">
		<!-- <td class="buy_btns2" style="width:20px"> -->
						<UL>
						<li><a href="${contextPath}/goods/deletewishall.do">전체삭제</a>
						<a href="${contextPath}/goods/deletewicheck.do">선택삭제</a>
						</li>
						</UL>
					</td>
	</table>
	
						
	<div class="clear"></div>
	<div id="page_wrap">
		<ul id="page_control">
			<li><a class="no_border" href="#">Prev</a></li>
			<c:set var="page_num" value="0" />
			<c:forEach var="count" begin="1" end="10" step="1">
				<c:choose>
					<c:when test="${count==1 }">
						<li><a class="page_contrl_active" href="#">${count+page_num*10 }</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="#">${count+page_num*10 }</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<li><a class="no_border" href="#">Next</a></li>
		</ul>
	</div>