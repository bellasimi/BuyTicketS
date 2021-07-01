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
<!-- place 조건으로 c:set -->
	
	<c:choose>
	
		<c:when test="${place eq 'seoul'}">
			<c:set var="place" value="서울"/>
		</c:when>
		
		<c:when test="${place eq 'ggi'}">
			<c:set var="place" value="경기도"/>
		</c:when>
		<c:when test="${place eq 'gang'}">
			<c:set var="place" value="강원도"/>
		</c:when>
		<c:when test="${place eq 'chung'}">
			<c:set var="place" value="충청도"/>
		</c:when>
		<c:when test="${place eq 'jeolla'}">
			<c:set var="place" value="전라도"/>
		</c:when>
		<c:when test="${place eq 'sang'}">
			<c:set var="place" value="경상도"/>
		</c:when>
		<c:otherwise>
			<c:set var="place" value="제주"/>
		</c:otherwise>
		
	</c:choose>
	<c:forEach var="item" items="${PlaceList}" >
	

	<h3>${place}</h3><!-- 해당 place로 db없으면 오류남 현재는 강원도;gang;만들어간 상태 -->
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