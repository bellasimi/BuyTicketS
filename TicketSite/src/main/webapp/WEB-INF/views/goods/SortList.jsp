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

<!-- sort 조건으로 c:set -->
	<c:if test="${sort eq 'nature'}">
		<c:set var="sort2" value="자연동물/전망대"/>
	</c:if>
	<c:if test="${sort eq 'museum'}">
		<c:set var="sort2" value="박물관"/>
	</c:if>
	<c:if test="${sort eq 'themepark'}">
		<c:set var="sort2" value="테마파크"/>
	</c:if>
	<c:if test="${sort eq 'history'}">
		<c:set var="sort2" value="역사문화명소"/>
	</c:if>
	<c:if test="${sort eq 'attraction'}">
		<c:set var="sort2"  value="어트랙션"/>
	</c:if>
	<h3>${sort2}</h3>
		<input type="hidden" value="${listmenu}" id="listmenu"/>
	<div id="sorting">
		<ul>
			<li><a id="list1" href="${contextPath}/goods/slistcheap.do?goods_sort=${sort}">가격 오름차순</a></li>
			<li><a id="list2" href="${contextPath}/goods/slistdiscount.do?goods_sort=${sort}">할인율순</a></li>
			<li><a id="list3" style="border: currentColor; border-image: none;" href="${contextPath}/goods/slistrate.do?goods_sort=${sort}">평점순</a></li>

		</ul>
	</div>
	<div class="clear"></div>
	<c:forEach var="item" items="${SortList}" >
	   <c:set  var="goods_count" value="${goods_count+1}" />
		<%-- 이전 css <div class="book">
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