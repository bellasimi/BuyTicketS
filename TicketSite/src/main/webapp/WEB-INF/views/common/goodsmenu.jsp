	
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
	
<section>
		
			<li>
				<a href="${contextPath}/goods/sort.do?goods_sort=nature"><!-- 자연 -->
				<img src ="${contextPath}/resources/icon/sort/nature.png"></a>
			
				<a href="${contextPath}/goods/sort.do?goods_sort=museum"><!-- 박물관 -->
				<img src ="${contextPath}/resources/icon/sort/museum.png"></a>			
				<a href="${contextPath}/goods/sort.do?goods_sort=themepark">
				<img src ="${contextPath}/resources/icon/sort/themepark.png"></a><!-- 테마파크 -->
				<a href="${contextPath}/goods/sort.do?goods_sort=history">
				<img src ="${contextPath}/resources/icon/sort/history.png"></a><!-- 역사문화 -->
				<a href="${contextPath}/goods/sort.do?goods_sort=attraction">
				<img src ="${contextPath}/resources/icon/sort/attraction.png"></a><!-- 어트랙션 -->
			</li>

		<!--  테두리 둥글게 
			<li>
			<a href="${contextPath}/goods/place.do?goods_place=seoul">
			<img src ="${contextPath}/resources/icon/place/placeseoul2.png"></a>
			<a href="${contextPath}/goods/place.do?goods_place=ggi">
			<img src ="${contextPath}/resources/icon/place/placeggi2.png"></a>
			<a href="${contextPath}/goods/place.do?goods_place=gang">
			<img src ="${contextPath}/resources/icon/place/placegang2.png"></a>
			<a href="${contextPath}/goods/place.do?goods_place=chung">
			<img src ="${contextPath}/resources/icon/place/placechung2.png"></a>
			<a href="${contextPath}/goods/place.do?goods_place=jeolla">
			<img src ="${contextPath}/resources/icon/place/placejeolla2.png"></a>
			<a href="${contextPath}/goods/place.do?goods_place=sang">
			<img src ="${contextPath}/resources/icon/place/placesang2.png"></a>
			<a href="${contextPath}/goods/place.do?goods_place=jeju">
			<img src ="${contextPath}/resources/icon/place/placejeju2.png"></a>
			</li>
		 -->	
		
			<li>
			<a href="${contextPath}/goods/place.do?goods_place=seoul">
			<img src ="${contextPath}/resources/icon/place/placeseoul3.PNG"></a>
			<a href="${contextPath}/goods/place.do?goods_place=ggi">
			<img src ="${contextPath}/resources/icon/place/placeggi3.PNG"></a>
			<a href="${contextPath}/goods/place.do?goods_place=gang">
			<img src ="${contextPath}/resources/icon/place/placegang3.PNG"></a>
			<a href="${contextPath}/goods/place.do?goods_place=chung">
			<img src ="${contextPath}/resources/icon/place/placechung3.PNG"></a>
			<a href="${contextPath}/goods/place.do?goods_place=jeolla">
			<img src ="${contextPath}/resources/icon/place/placejeolla4.png"></a>
			<a href="${contextPath}/goods/place.do?goods_place=sang">
			<img src ="${contextPath}/resources/icon/place/placesang3.PNG"></a>
			<a href="${contextPath}/goods/place.do?goods_place=jeju">
			<img src ="${contextPath}/resources/icon/place/placejeju3.PNG"></a>
			
			</li>
			
</section>