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
<script type="text/javascript">
$(document).ready(function(){
	var listmenu = $('input[id=listmenu]').val();
	console.log(listmenu);
	if(listmenu == "list1"){//판매종료
		$('#list1').attr('class','active');}
	else if(listmenu == "list2"){//가격
		$('#list2').attr('class','active');}
	else if(listmenu == "list3"){//할인율
		$('#list3').attr('class','active');}
	else if(listmenu == "list4"){//평점
		$('#list4').attr('class','active');}
		
}); 
function add_wish(goods_id){
	var isLogOn = $('#isLogOn').val();
	console.log(isLogOn);
	if(isLogOn =='false'|| isLogOn ==''){
		alert("로그인 후 이용해주세요!");
	}
	else{
	$.ajax({
		type : "post",
		async : false, //false인 경우 동기식으로 처리한다.
		url : "${contextPath}/goods/addwish.do",
		data : {
			goods_id:goods_id
		},
		
		success : function(data, textStatus) {
			
			if(data.trim()=='null'){
				imgpopup("#layer","open")
			}else if(data.trim()=='isAreadyExisted'){
				alert("이미 위시리스트에 담긴 상품입니다.");	
			}
			
		},
		error : function(data, textStatus) {
			alert("에러가 발생했습니다."+data);
		},
		complete : function(data, textStatus) {
			//alert("작업을완료 했습니다");
			
		}
	}); //end ajax
	}//else
}

function imgpopup(layer,style){
	if(style=="open"){
		$(layer).attr("style","visibility:visible");}
	else if(style =="close"){
		$(layer).attr("style","visibility:hidden");}
	
}

</script>
<style>
#layer{
	z-index: 2;
	position: absolute;
	top: 0px;
	left: 0px;
	width: 100%;
	font-size:12pt;
}

#popup {
	z-index: 3;
	position: fixed;
	text-align: center;
	left: 50%;
	top: 45%;
	width: 300px;
	height: 200px;
	background-color: white;
	border: 3px solid #87cb42;
}
#close {
	z-index: 4;
	float: right;
}
</style>
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
	<input type="hidden" id="listmenu" value="${listmenu}"/>
	<div id="sorting">
		<ul>
			<li><a id="list1"  href="${contextPath}/goods/searchlastsale.do?searchWord=${searchWord}">판매 종료 임박</a></li>
			<li><a id="list2" href="${contextPath}/goods/searchcheap.do?searchWord=${searchWord}">가격 오름차순</a></li>
			<li><a id="list3" href="${contextPath}/goods/searchdiscount.do?searchWord=${searchWord}">할인률순</a></li>
			<li><a id="list4" style="border: currentColor; border-image: none;" href="${contextPath}/goods/searchrate.do?searchWord=${searchWord}">평점순</a></li>
		</ul>
	</div>
	<table id="list_view">
		<tr><td><input type="checkbox" id="checkall"></td><td></td><td>상품명</td><td>정가</td><td>할인율</td><td>판매가</td></tr>
		<tbody>
		  <c:forEach var="item" items="${goodsList}"> 
			<tr>
					<td><input type="checkbox" id="checkbox"></td>
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
					<td class="price"><span><fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
					${goods_price}원</span></td>
					<td class="price">
						<strong>
						<fmt:formatNumber  value="${item.goods_sales_price}" type="number" var="goods_sales_price" />
				               ${goods_sales_price}원 
						</strong>
					</td>
					<td class="price">
						<strong>
							${item.goods_discount}% 할인						
						</strong>
					</td>
					
					
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
						<li><a href="javascript:add_wish(${item.goods_id})">위시리스트</a></li>
						
							
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
	
	<div id="layer" style="visibility: hidden" name="layer">
		<div id="popup">
			<a href="javascript:" onClick="javascript:imgpopup('#layer','close');">
			<img
				src="${contextPath}/resources/image/close.png" id="close" />
			</a> <br /> <font size="12" id="contents" style="font-size:30pt; text-align: center;">위시리스트에<br> 담았습니다.</font><br><br>
			<form   action='${contextPath}/goods/WishList.do'  >				
				<input  type="submit" value="위시리스트 보기">
			</form>			
			
		</div>
	</div>
	<input type="hidden" value="${isLogOn}" id="isLogOn">