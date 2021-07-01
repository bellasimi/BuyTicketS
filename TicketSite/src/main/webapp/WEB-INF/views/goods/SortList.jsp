<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"	isELIgnored="false"
	%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%>  

<div class="main_book" >
<c:set  var="goods_count" value="0" />

<!-- sort 조건으로 c:set -->
	<c:if test="${sort eq 'nature'}">
		<c:set var="sort" value="자연동물/전망대"/>
	</c:if>
	<c:if test="${sort eq 'museum'}">
		<c:set var="sort" value="박물관"/>
	</c:if>
	<c:if test="${sort eq 'themepark'}">
		<c:set var="sort" value="테마파크"/>
	</c:if>
	<c:if test="${sort eq 'history'}">
		<c:set var="sort" value="역사문화명소"/>
	</c:if>
	<c:if test="${sort eq 'attraction'}">
		<c:set var="sort"  value="어트랙션"/>
	</c:if>
	<h3>${sort}</h3>
	<c:forEach var="item" items="${SortList}" >
	   <c:set  var="goods_count" value="${goods_count+1}" />
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
	</div>
	 <c:if test="${goods_count==15}">
     <div class="book">
       <font size=20> <a href="#">more</a></font>
     </div>
   </c:if>
	</c:forEach>
</div>	