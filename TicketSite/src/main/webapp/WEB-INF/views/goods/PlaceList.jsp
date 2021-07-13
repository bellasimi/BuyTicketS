<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"	isELIgnored="false"
	%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
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
});


</script>
</head>
<div class="main_book" >
<c:set  var="goods_count" value="0" />
<!-- place 조건으로 c:set -->
	
	<c:choose>
	
		<c:when test="${place eq 'seoul'}">
			<c:set var="place2" value="서울"/>
		</c:when>
		
		<c:when test="${place eq 'ggi'}">
			<c:set var="place2" value="경기도"/>
		</c:when>
		<c:when test="${place eq 'gang'}">
			<c:set var="place2" value="강원도"/>
		</c:when>
		<c:when test="${place eq 'chung'}">
			<c:set var="place2" value="충청도"/>
		</c:when>
		<c:when test="${place eq 'jeolla'}">
			<c:set var="place2" value="전라도"/>
		</c:when>
		<c:when test="${place eq 'sang'}">
			<c:set var="place2" value="경상도"/>
		</c:when>
		<c:otherwise>
			<c:set var="place2" value="제주"/>
		</c:otherwise>
		
	</c:choose>
	<h3>${place2}</h3><!-- 해당 place로 db없으면 오류남 현재는 강원도;gang;만들어간 상태 -->
	
	<div id="sorting">
	<input type="hidden" value="${listmenu}" id="listmenu"/>
	
		<ul>
			<li><a id="list1" href="${contextPath}/goods/plistcheap.do?goods_place=${place}">가격 오름차순</a></li>
			<li><a id="list2" href="${contextPath}/goods/plistdiscount.do?goods_place=${place}">할인율순</a></li>
			<li><a id="list3" style="border: currentColor; border-image: none;" href="${contextPath}/goods/plistrate.do?goods_place=${place}">평점순</a></li>

		</ul>
	</div>
	<div class="clear"></div>
	<c:forEach var="item" items="${PlaceList}" >

<%-- 이전 버전	   <c:set  var="goods_count" value="${goods_count+1}" />
		<div class="book">
		  <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
	       <img class="link"  src="${contextPath}/resources/image/1px.gif"> 
	      </a>
		 <img width="121" height="154" 
				src="${contextPath}/resources/shopping/file_repo/${item.goods_id}/${item.goods_fileName}">
		<div class="title">${item.goods_title}</div>
		<div class="price">
		    <fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
		       ${goods_price}원
		  </div>
	</div> --%>
		<div class="book">
			<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
			<img class="link"  src="${contextPath}/resources/image/1px.gif"> 
			</a> 
			<!-- 
				<img width="121" height="154" 
				     src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
				  -->    
				   <img width="148" height="108.5" 
				     src="${contextPath}/resources/shopping/file_repo/${item.goods_id}/${item.goods_fileName}">
			<div class="text-block"><!-- 상품의 할인 아이콘 -->    		  			  		
			<div class="discount"style="width: 70;">
		  	   <fmt:formatNumber  value="${item.goods_discount}" type="number" var="goods_discount" />
		          ${goods_discount}% OFF
			</div>
			</div>
			<div class="title" style="height: 50px;">${item.goods_title }</div>	
			
			<div class="priceform">
			<div class="price" >
		  	   <fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
		          ${goods_price}원
			</div>
			<div class="disprice">
		  	   <fmt:formatNumber  value="${item.goods_sales_price}" type="number" var="goods_sales_price" />
		          ${goods_sales_price}원
			</div>
			</div>
		</div>
	 <c:if test="${goods_count==15}">
     <div class="book">
       <font size=20> <a href="#">more</a></font>
     </div>
   </c:if>
	</c:forEach>
</div>	