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
	<h3>가요</h3>
	<c:forEach var="item" items="${Map.classic}" >
	   <c:set  var="goods_count" value="${goods_count+1}" />
		<div class="book">
		  <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
	       <img class="link"  src="${contextPath}/resources/image/1px.gif"> 
	      </a>
		 <img width="121" height="154" 
				src="${contextPath}/resources/shopping/file_repo/${item.goods_id}/${item.goods_fileName}">
		<div class="title">${item.goods_title }</div>
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