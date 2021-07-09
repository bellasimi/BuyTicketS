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
 <title>검색 도서 목록 페이지</title>
</head>
<body>
	<hgroup>
		<h1>검색된 티켓 상품</h1>
	</hgroup>
	
	<%-- <section id="new_book">
		<h3>새로나온 책</h3>
		<div id="left_scroll">
			<a href='javascript:slide("left");'><img src="${contextPath}/resources/image/left.gif"></a>
		</div>
		<div id="carousel_inner">
			<ul id="carousel_ul">
			<c:choose>
			   <c:when test="${ empty goodsList  }" >
			        <li>
					<div id="book">
						<a><h1>제품이없습니다.</h1></a>
					  </div>
				</li> 
			   </c:when>
			   <c:otherwise>
			    <c:forEach var="item" items="${goodsList }" >
			     <li>
					<div id="book">
						<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
						<img width="75" alt="" src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
						</a>
						<div class="sort">티켓 상품</div>
						<div class="title">
							<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
							  ${item.goods_title}
							</a>
						</div><div class="writer">${item.goods_publisher}</div>
						<div class="writer">판매종료일: ${item.goods_lastsale_date} | 유효기간: ${item.goods_expired_date}까지</div>
						<div class="price">
							<span>
							  <fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
		                         ${goods_price}원
							</span> <br>
							
							  <fmt:formatNumber  value="${item.goods_sales_price}" type="number" var="goods_sales_price" />
				               ${goods_sales_price}원 (${item.goods_discount}% 할인)
						</div>
					</div>
				</li>
				</c:forEach> 
				<li>
				</li> 
			   </c:otherwise>
			 </c:choose>
			 
			</ul>
		</div>
		<div id="right_scroll">
			<a href='javascript:slide("right");'><img  src="${contextPath}/resources/image/right.gif"></a>
		</div>
		<input id="hidden_auto_slide_seconds" type="hidden" value="0">

		<div class="clear"></div>
	</section>
	<div class="clear"></div> --%>
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
							<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">${item.goods_title }</a>
						</h2>
						
						<div class="writer_press" >
						판매종료일: ${item.goods_lastsale_date} | 유효기간: ${item.goods_expired_date}까지|
						<c:out value="${arr[0]}" />
						</div>
					</td>
					<td class="price"><span>${item.goods_price}원</span><br>
						<strong>
						<fmt:formatNumber  value="${item.goods_sales_price}" type="number" var="goods_sales_price" />
				               ${goods_sales_price}원 
						</strong><br>(${item.goods_discount}% 할인)
					</td>
					<td><input type="checkbox" value=""></td>
					
<%-- <script type="text/javascript">
	function add_wish(goods_id){
		$.ajax({
			type:"post",
			url:"${contextPath}/goods/addwish.do",
			data:{
				goods_id:goods_id
			},
			success:function(data, textStatus){
				if(data.trim()=='add_success'){
					imagePopup('open','.layer02');
				}else if(data.trim()=='already_existed'){
					alert("이미 위시리스트에 등록된 상품입니다.");
				}
				
			},
			error: function(data,textStatus){
				alert("오류가 발생했습니다!")
			},
			complete: function(data,textStatus){
				
			}
		});
		
		
	}

</script>
						
							<li><a href="javascript:add_wish('${item.goods_id}')">위시리스트</a></li> --%>
							
					<td class="buy_btns">
						<UL>
						<li><a href="${contextPath}/goods/WishList.do?goods_id=${item.goods_id}">위시리스트</a></li>
						
							
						</UL>
					</td>
			</tr>
			</c:forEach>
		</tbody>
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