<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" 	isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="goods"  value="${goodsMap.goodsVO}"  />
<c:set var="imageList"  value="${goodsMap.imageList }"  />

 <%
     //치환 변수 선언합니다.
      //pageContext.setAttribute("crcn", "\r\n"); //개행문자
      pageContext.setAttribute("crcn" , "\n"); //Ajax로 변경 시 개행 문자 
      pageContext.setAttribute("br", "<br/>"); //br 태그
%>  
<html>
<head>
<style>
#layer {
	z-index: 2;
	position: absolute;
	top: 0px;
	left: 0px;
	width: 100%;
}

#popup {
	z-index: 3;
	position: fixed;
	text-align: center;
	left: 50%;
	top: 45%;
	width: 300px;
	height: 200px;
	background-color: #ccffff;
	border: 3px solid #87cb42;
}

#close {
	z-index: 4;
	float: right;
}
</style>
<script type="text/javascript">
	function add_cart(goods_id) {
		var goods_ticket_date=document.getElementById("goods_ticket_date").value;
		$.ajax({
			type : "post",
			async : false, //false인 경우 동기식으로 처리한다.
			url : "${contextPath}/cart/addGoodsInCart.do",
			data : {
				goods_ticket_date:goods_ticket_date, //이게 되나? 
				goods_id:goods_id
				
			},
			success : function(data, textStatus) {
				//alert(data);
			//	$('#message').append(data);
				if(data.trim()=='add_success'){
					imagePopup('open', '.layer01');	
				}else if(data.trim()=='already_existed'){
					alert("이미 카트에 등록된 상품입니다.");	
				}
				
			},
			error : function(data, textStatus) {
				alert("에러가 발생했습니다."+data);
			},
			complete : function(data, textStatus) {
				//alert("작업을완료 했습니다");
			}
		}); //end ajax	
	}

	
			
	function imagePopup(type) {
		if (type == 'open') {
			// 팝업창을 연다.
			jQuery('#layer').attr('style', 'visibility:visible');

			// 페이지를 가리기위한 레이어 영역의 높이를 페이지 전체의 높이와 같게 한다.
			jQuery('#layer').height(jQuery(document).height());
		}

		else if (type == 'close') {

			// 팝업창을 닫는다.
			jQuery('#layer').attr('style', 'visibility:hidden');
		}
	}
	
function fn_order_each_goods(goods_id,goods_title,goods_sales_price,fileName){ 
	// 263행 href="javascript:fn_order_each_goods('${goods.goods_id }','${goods.goods_title}','${goods.goods_sales_price}','${goods.goods_fileName}')로 받은 값 
	var _isLogOn=document.getElementById("isLogOn");
	var isLogOn=_isLogOn.value;
	
	 if(isLogOn=="false" || isLogOn=='' ){
		alert("로그인 후 주문이 가능합니다!!!");
	} 
	
	 	var total_price,final_total_price;
		var order_goods_qty=document.getElementById("order_goods_qty"); //251행 order_goods_qty의 값
		var goods_ticket_date=document.getElementById("goods_ticket_date");//253행 goods_ticket_date의 값
		var formObj=document.createElement("form");//폼 만들기 
		var i_goods_id = document.createElement("input"); //input tag 만들기
    var i_goods_title = document.createElement("input");
    var i_goods_sales_price=document.createElement("input");
    var i_fileName=document.createElement("input");
    var i_order_goods_qty=document.createElement("input");
    
    i_goods_id.name="goods_id"; 
    i_goods_title.name="goods_title"; 
    i_goods_sales_price.name="goods_sales_price";
    i_fileName.name="goods_fileName";
    i_order_goods_qty.name="order_goods_qty";
    
    i_goods_id.value=goods_id;//'${goods.goods_id }
    i_order_goods_qty.value=order_goods_qty.value;// 100행에서 id로 받은 값
    i_goods_title.value=goods_title;//${goods.goods_title}'
    i_goods_sales_price.value=goods_sales_price;//'${goods.goods_sales_price}'
    i_fileName.value=fileName;//${goods.goods_fileName}
    //폼에 입력
    formObj.appendChild(i_goods_id);
    formObj.appendChild(i_goods_title);
    formObj.appendChild(i_goods_sales_price);
    formObj.appendChild(i_fileName);
    formObj.appendChild(i_order_goods_qty);
	//폼을 바디에 입력
    document.body.appendChild(formObj);
	//포스트 형식으로 "${contextPath}/order/orderEachGoods.do" 경로로 전송
    formObj.method="post";
    formObj.action="${contextPath}/order/orderEachGoods.do";
    formObj.submit();
	}	
</script>
</head>
<body>
<!-- sort 조건으로 c:set -->
	<c:if test="${goodsMap.goodsVO.goods_sort eq 'nature'}">
		<c:set var="sort" value="자연동물/전망대"/>
	</c:if>
	<c:if test="${goodsMap.goodsVO.goods_sort eq 'museum'}">
		<c:set var="sort" value="박물관"/>
	</c:if>
	<c:if test="${goodsMap.goodsVO.goods_sort eq 'themepark'}">
		<c:set var="sort" value="테마파크"/>
	</c:if>
	<c:if test="${goodsMap.goodsVO.goods_sort eq 'history'}">
		<c:set var="sort" value="역사문화명소"/>
	</c:if>
	<c:if test="${goodsMap.goodsVO.goods_sort eq 'attraction'}">
		<c:set var="sort"  value="어트랙션"/>
	</c:if>

<!-- status 조건으로 c:set -->	
	<c:choose>
		<c:when test="${goodsMap.goodsVO.goods_status eq 'bestseller'}">
			<c:set var="status" value="베스트셀러"/>
		</c:when>
		
		<c:when test="${goodsMap.goodsVO.goods_status eq 'bigsale'}">
			<c:set var="status" value="초특가 세일"/>
		</c:when>
		<c:when test="${goodsMap.goodsVO.goods_status eq 'new'}">
			<c:set var="status" value="신규 액티비티"/>
		</c:when>
	</c:choose>

<!-- place 조건으로 c:set -->	
	<c:choose>
		<c:when test="${goodsMap.goodsVO.goods_place eq 'seoul'}">
			<c:set var="place" value="서울"/>
		</c:when>
		
		<c:when test="${goodsMap.goodsVO.goods_place eq 'ggi'}">
			<c:set var="place" value="경기도"/>
		</c:when>
		<c:when test="${goodsMap.goodsVO.goods_place eq 'gang'}">
			<c:set var="place" value="강원도"/>
		</c:when>
		<c:when test="${goodsMap.goodsVO.goods_place eq 'chung'}">
			<c:set var="place" value="충청도"/>
		</c:when>
		<c:when test="${goodsMap.goodsVO.goods_place eq 'jeolla'}">
			<c:set var="place" value="전라도"/>
		</c:when>
		<c:when test="${goodsMap.goodsVO.goods_place eq 'sang'}">
			<c:set var="place" value="경상도"/>
		</c:when>
		<c:otherwise>
			<c:set var="place" value="제주"/>
		</c:otherwise>
		
	</c:choose>
	<hgroup>
		<h1>${sort}</h1>
		<h2>티켓구매 &gt;${place}  &gt;${sort}</h2>
		<h3>${goods.goods_title}</h3>
		<h4>${goods.goods_publisher}</h4>
	</hgroup>
	<div id="goods_image">
		<figure>
			<img alt="HTML5 &amp; CSS3"
				src="${contextPath}/resources/shopping/file_repo/${goods.goods_id}/${goods.goods_fileName}">
		</figure>
	</div>
	<div id="detail_table">
		<table>
		<!-- 할인율 -->
				<c:set var="discount" value="10"/>
		<!-- 할인가  --> 
				<c:set var="left" value="${(100-discount)*0.01}"/>  
				<c:set var="discounted_price" value="${goods.goods_sales_price*left}"/>
		<!-- 할인 -->		
				<c:set var="discount_price" value="${goods.goods_sales_price-discounted_price}"/>
			<tbody>
				<tr>
					<td class="fixed">정가</td>
					<td class="active"><span >
					   <fmt:formatNumber  value="${goods.goods_price}" type="number" var="goods_price" />
				         ${goods_price}원
					</span></td>
				</tr>
				<tr class="dot_line">
					<td class="fixed">판매가</td>
					   <fmt:formatNumber  value="${goods.goods_sales_price}" type="number" pattern="#,###" var="salesprice"/>
					<td class="fixed"><span style="text-decoration: line-through; ">${salesprice}</span> 
					   <fmt:formatNumber  value="${discounted_price}" type="number" pattern="#,###" var="discountedprice"/>
					  
				        <span style="color:red;"> ${discountedprice}원(${discount}% 추가할인)</span></td>
				</tr>
				<tr>
					<td class="fixed">포인트적립</td>
					<td class="active">${goods.goods_point}P</td>
				</tr>
				<tr>
					<td class="fixed">판매 종료일</td>
					<td class="fixed">
					   <c:set var="pub_date" value="${goods.goods_lastsale_date}" />
					   <c:set var="arr" value="${fn:split(pub_date,' ')}" />
					   <c:out value="${arr[0]}" />
					</td>
				</tr>
				<tr>
					<td class="fixed">티켓 만기일</td>
					<td class="fixed">
					   <c:set var="pub_date" value="${goods.goods_expired_date}" />
					   <c:set var="arr" value="${fn:split(pub_date,' ')}" />
					   <c:out value="${arr[0]}" />
					</td>
				</tr>
				<tr>
					<td class="fixed">예매일</td>
					<td class="fixed">
				 	<input type="date" id="goods_ticket_date"/> <!-- 103행,52행에 getelementbyid()하는 값  -->
					 </td>
				</tr>
			
				<tr>
					<td class="fixed">수량</td>
					<td class="fixed">
			      <select style="width: 60px;" id="order_goods_qty">
				      <option>1</option>
							<option>2</option>
							<option>3</option>
							<option>4</option>
							<option>5</option>
			     </select>
					 </td>
				</tr>
					<tr>
					<td class="fixed">티켓 수신 방법</td>
					<td class="fixed">문자,QR코드</td>
				</tr>
			</tbody>
		</table>
		<ul>
			<li><a class="buy" href="javascript:fn_order_each_goods('${goods.goods_id }','${goods.goods_title}','${goods.goods_sales_price}','${goods.goods_fileName}');">구매하기 </a></li>
			<li><a class="cart" href="javascript:add_cart('${goods.goods_id }')">장바구니</a></li>
			
			<li><a class="wish" href="#">위시리스트</a></li>
		</ul>
	</div>
	<div class="clear"></div>
	<!-- 내용 들어 가는 곳 -->
	<div id="container">
		<ul class="tabs">
			<li><a href="#tab1">상세설명</a></li>
			<li><a href="#tab2">이용약관</a></li>
			<li><a href="#tab3">사용방법</a></li>
			<li><a href="#tab4">위치</a></li>
			<li><a href="#tab5">리부</a></li>
			<li><a href="#tab6">기타</a></li>
		</ul>
		<div class="tab_container">
			<div class="tab_content" id="tab1">
				<h4>상세설명</h4>
				<p>${fn:replace(goods.goods_description,crcn,br)}</p>
				<c:forEach var="image" items="${imageList }">
					<img 
						src="${contextPath}/resources/shopping/file_repo/${goods.goods_id}/${goods.goods_fileName}">
				</c:forEach>
			</div>
			<div class="tab_content" id="tab2">
				<h4>이용약관</h4>
				<p>
				<div class="writer">주최: ${goods.goods_publisher}</div>
				 <p>${fn:replace(goods.goods_terms,crcn,br) }</p> 
				
			</div>
			<div class="tab_content" id="tab3">
				<h4>사용방법</h4>
				<p>${fn:replace(goods.goods_usage,crcn,br)}</p> 
			</div>
			<div class="tab_content" id="tab4">
				<h4>위치</h4>
				 <p>${fn:replace(goods.goods_location,crcn,br)}</p> 
			</div>
			<div class="tab_content" id="tab5">
				<h4>추천</h4>
			</div>
			<div class="tab_content" id="tab6">
				<h4>리뷰</h4>
			</div>
		</div>
	</div>
	<div class="clear"></div>
	<div id="layer" style="visibility: hidden">
		<!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다. -->
		<div id="popup">
			<!-- 팝업창 닫기 버튼 -->
			<a href="javascript:" onClick="javascript:imagePopup('close', '.layer01');"> <img
				src="${contextPath}/resources/image/close.png" id="close" />
			</a> <br /> <font size="12" id="contents">장바구니에 담았습니다.</font><br>
<form   action='${contextPath}/cart/myCartList.do'  >				
		<input  type="submit" value="장바구니 보기">
</form>			
</body>
</html>
<input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}"/>