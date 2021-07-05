
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
	
<nav>
<ul>
<c:choose>
<c:when test="${side_menu=='admin_mode'}">
   <li>
		<H3>주요기능</H3>
		<ul>
			<li><a href="${contextPath}/admin/goods/adminGoodsMain.do">상품관리</a></li>
			<li><a href="${contextPath}/admin/order/adminOrderMain.do">주문관리</a></li>
			<li><a href="${contextPath}/admin/member/adminMemberMain.do">회원관리</a></li>
			<li><a href="#">배송관리</a></li>
			<li><a href="#">게시판관리</a></li>
		</ul>
	</li>
</c:when>
<c:when test="${side_menu=='my_page'}">
	<li>
		<h3>주문내역</h3>
		<ul>
			<li><a href="${contextPath}/mypage/listMyOrderHistory.do">주문내역/배송 조회</a></li>
			<li><a href="#">반품/교환 신청 및 조회</a></li>
			<li><a href="#">취소 주문 내역</a></li>
			<li><a href="#">세금 계산서</a></li>
		</ul>
	</li>
	<li>
		<h3>정보내역</h3>
		<ul>
			<li><a href="${contextPath}/mypage/myDetailInfo.do">회원정보관리</a></li>
			<li><a href="#">나의 주소록</a></li>
			<li><a href="#">개인정보 동의내역</a></li>
			<li><a href="#">회원탈퇴</a></li>
		</ul>
	</li>
</c:when>
<c:otherwise>
	<li>
		
		<ul>
			<li><a href="${contextPath}/goods/sort.do?goods_sort=nature"><!-- 자연 -->
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
		</ul>
	</li>
	
	<li>
		<ul>
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
		 -->	
			</li><li>
			<a href="${contextPath}/goods/place.do?goods_place=seoul">
			<img src ="${contextPath}/resources/icon/place/placeseoul3.PNG"></a>
			<a href="${contextPath}/goods/place.do?goods_place=ggi">
			<img src ="${contextPath}/resources/icon/place/placeggi3.PNG"></a>
			<a href="${contextPath}/goods/place.do?goods_place=gang">
			<img src ="${contextPath}/resources/icon/place/placegang3.PNG"></a>
			<a href="${contextPath}/goods/place.do?goods_place=chung">
			<img src ="${contextPath}/resources/icon/place/placechung3.PNG"></a>
			<a href="${contextPath}/goods/place.do?goods_place=jeolla">
			<img src ="${contextPath}/resources/icon/place/placejeolla3.PNG"></a>
			<a href="${contextPath}/goods/place.do?goods_place=sang">
			<img src ="${contextPath}/resources/icon/place/placesang3.PNG"></a>
			<a href="${contextPath}/goods/place.do?goods_place=jeju">
			<img src ="${contextPath}/resources/icon/place/placejeju3.PNG"></a>
			
			</li>
		</ul>
	</li>
 </c:otherwise>
</c:choose>	
</ul>
</nav>
<!-- 
<div class="clear"></div>
<div id="banner">
	<a href="#"><img width="190" height="163" src="${contextPath}/resources/image/n-pay.jpg"> </a>
	
</div>
<DIV id="notice">
	<H2>공지사항</H2>
	<UL>
	
	<c:forEach  var="i" begin="1" end="5" step="1">
		<li><a href="#">공지사항입니다.${ i}</a></li>
	</c:forEach>
	</ul>
</div>


<div id="banner">
	<a href="#"><img width="190" height="362" src="${contextPath}/resources/image/side_banner1.jpg"></a>
</div>
<div id="banner">
	<a href="#"><img width="190" height="104" src="${contextPath}/resources/image/call_center_logo.jpg"></a>
</div>
<div id="banner">
	<a href="#"><img width="190" height="69" src="${contextPath}/resources/image/QnA_logo.jpg"></a>
</div>
 -->