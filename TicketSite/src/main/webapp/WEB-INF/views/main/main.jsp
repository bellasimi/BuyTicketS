<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"	isELIgnored="false"
	%>
	<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%>  
<%-- <div id="ad_main_banner">
	<ul class="bjqs">	 	
	  <li><img width="775" height="145" src="${contextPath}/resources/image/main_banner01.jpg"></li>
		<li><img width="775" height="145" src="${contextPath}/resources/image/main_banner02.jpg"></li>
		<li><img width="775" height="145" src="${contextPath}/resources/image/main_banner03.jpg"></li> 
	</ul>
</div> --%>
<div class="main_book">
   <c:set  var="goods_count" value="0" />
	<h3 style="font-size: 25;" >베스트셀러</h3><!-- bestseller,bigsale,new,kids,freecancel -->
	<c:forEach var="item" items="${goodsMap.bestseller }">
	   <c:set  var="goods_count" value="${goods_count+1 }" />
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
	  <!--  <c:if test="${goods_count==15   }">
         <div class="book">
           <font size=20> <a href="#">more</a></font>
         </div> 
     </c:if>
     -->
  </c:forEach>
</div>
<div class="clear"></div>
<%-- <div id="ad_sub_banner">
	<img width="770" height="117" src="${contextPath}/resources/image/sub_banner01.jpg">
</div> --%>
<div class="main_book" >
<c:set  var="goods_count" value="0" />
	<h3 style="font-size: 25;">초특가 세일</h3><!--bigsale-->
	<c:forEach var="item" items="${goodsMap.bigsale }" >
	   <c:set  var="goods_count" value="${goods_count+1 }" />
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
	 
	</c:forEach>
</div>

<div class="clear"></div>
<%-- <div id="ad_sub_banner">
	<img width="770" height="117" src="${contextPath}/resources/image/sub_banner02.jpg">
</div> --%>
<div class="main_book" >
<c:set  var="goods_count" value="0" />
	<h3 style="font-size: 25;">신규 액티비티</h3><!-- new -->
	<c:forEach var="item" items="${goodsMap.newsale }" >
	   <c:set  var="goods_count" value="${goods_count+1 }" />
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
	
	</c:forEach>
</div>

   
   