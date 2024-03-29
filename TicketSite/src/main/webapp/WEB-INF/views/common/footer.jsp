<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"    
    %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">    
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<div id="footstyle" style="font-family: 'NanumBarunGothic', sans-serif;">
<ul>
	<li><a href="/bts/main/about.do">회사소개</a></li>
	<li><a href="/bts/main/terms.do">이용약관</a></li>
	<li><a href="/bts/main/privacy.do">개인정보취급방침</a></li>
	<li class="no_line"><a href="/bts/main/address.do">찾아오시는길</a></li>
</ul>
</div>

<!-- sns아이콘 -->

<div class= "sns" style="font-size: 20;">
<a href="https://www.facebook.com/" class="fa fa-facebook" ></a>
<a href="https://twitter.com/" class="fa fa-twitter"></a>
<a href="https://instagram.com/" class="fa fa-instagram"></a>
</div>



<div class="clear"></div>

<a href="${contextPath}/main/main.do"><img  src="${contextPath}/resources/image/img/backmain.png" width="147px" height="62px" /></a>



<div style="padding-left:200px; font-family: 'NanumBarunGothic', sans-serif;">
	 ㈜BuyTicketS <br>
	 대표이사: 하신영   <br>
	 주소 : 우편번호16455 경기도 수원시 매산로1가 11-9 KR <br>  
	 사업자등록번호 : 102-81-11111 <br>
	 서울특별시 통신판매업신고번호 : 제 666호 ▶사업자정보확인   개인정보보호최고책임자 : 허유정 huyoujung@google.co.kr <br>
	 대표전화 : 1588-1588 (발신자 부담전화)   팩스 : 0588-776-1142 (지역번호공통) <br>
	 이 사이트에는 네이버에서 제공한 나눔글꼴이 적용되어 있습니다. <br>
	 COPYRIGHT(C) BuyTicketS TICKETS CENTRE ALL RIGHTS RESERVED.
</div>

