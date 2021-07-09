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
 <title>위시리스트</title>
</head>
<body>
	<hgroup>
		<h1>위시리스트</h1>
	</hgroup>
	
	<div id="sorting">
		<ul>
	
			<li><a class="active" href="#">판매 종료 임박</a></li>
			<li><a href="#">가격 오름차순</a></li>
			<li><a style="border: currentColor; border-image: none;" href="#">최근 등록</a></li>

		</ul>
	</div>
	<table id="list_view">
					
	
		<tbody>
		  <c:forEach var="item" items="${goodsList}"> 
			<tr>
					<td class="goods_image">
						<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
							   <img width="75" alt="" src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
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
					<td><input type="checkbox" value=""></td>
	<td class="buy_btns">
						<UL>
						<li><a href="${contextPath}/goods/deletewish.do?goods_id=${item.goods_id}">삭제</a></li>
						
							
						</UL>
					</td>

			</tr>
			</c:forEach>
		</tbody>
		<td class="buy_btns" style="width:20px">
						<UL>
						<li><a href="${contextPath}/goods/deletewishall.do">전체삭제</a></li>
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