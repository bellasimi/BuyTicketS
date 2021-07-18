<%@page import="java.util.Date"%>
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
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
body, html {
  height: 100%;
  margin: 0;
  font-family: Arial;
  background-repeat: no-repeat;
  overflow-x: hidden
}
a {
    text-decoration: none !important;
    color: inherit
}

a:hover {
    color: #455A64
}

.card {
    border-radius: 5px;
    background-color: #fff;
    padding-left: 60px;
    padding-right: 60px;
    margin-top: 30px;
    padding-top: 30px;
    padding-bottom: 30px;
    border-bottom: #E6F2FF;
}

.rating-box {
    width: 130px;
    height: 130px;
    margin-right:80px;
    background-color: #FBC02D;
    color: #fff;
    display: inline-block;
}

.rating-label {
    font-weight: bold
}

.rating-bar {
    width: 300px;
    padding: 8px;
    border-radius: 5px
}

.bar-container {
    width: 100%;
    background-color: #f1f1f1;
    text-align: center;
    color: white;
    border-radius: 20px;
    cursor: pointer;
    margin-bottom: 5px
}

.bar-5 {
    width: 70%;
    height: 13px;
    background-color: #FBC02D;
    border-radius: 20px
}

.bar-4 {
    width: 30%;
    height: 13px;
    background-color: #FBC02D;
    border-radius: 20px
}

.bar-3 {
    width: 20%;
    height: 13px;
    background-color: #FBC02D;
    border-radius: 20px
}

.bar-2 {
    width: 10%;
    height: 13px;
    background-color: #FBC02D;
    border-radius: 20px
}

.bar-1 {
    width: 0%;
    height: 13px;
    background-color: #FBC02D;
    border-radius: 20px
}

td {
    padding-bottom: 10px
}

.star-active {
    color: #FBC02D;
    margin-top: 10px;
    margin-bottom: 10px
}

.star-active:hover {
    color: #F9A825;
    cursor: pointer
}

.star-inactive {
    color: #CFD8DC;
    margin-top: 10px;
    margin-bottom: 10px
}

.blue-text {
    color: #0091EA
}

.content {
    font-size: 18px
}

.profile-pic {
    width: 90px;
    height: 90px;
    border-radius: 100%;
    margin-right: 30px
}

.pic {
    width: 80px;
    height: 80px;
    margin-right: 10px
}

.vote {
    cursor: pointer
}
</style>
<script type="text/javascript">

	function add_cart(goods_id) {
		var goods_ticket_date=document.getElementById("goods_ticket_date").value;
		var order_goods_qty =document.getElementById("order_goods_qty").value;//구매 수량
		var isLogOn = document.getElementById("isLogOn").value;
		console.log("로그인?"+isLogOn);
		var layer = $('#layer').attr('name');
		if(isLogOn == 'false'||isLogOn == ''){
			alert("로그인 후 이용가능합니다.")
			location.href="${contextPath}/member/loginForm.do"
		}else{
		if(goods_ticket_date == ''){
			 alert("예매일을 입력해주세요.")
		}else{
		$.ajax({
			type : "post",
			async : false, //false인 경우 동기식으로 처리한다.
			url : "${contextPath}/cart/addGoodsInCart.do",
			data : {
				goods_ticket_date:goods_ticket_date, 
				goods_id:goods_id,
				cart_goods_qty:order_goods_qty //구매수량 cart_goods_qty라는 변수명으로 전달
				
			},
			success : function(data, textStatus) {
				//alert(data);
			//	$('#message').append(data);
				if(data.trim()=='add_success'){
					imagePopup('open', layer);	
				}else if(data.trim()=='already_existed'){
					alert("이미 카트에 등록된 상품입니다.");	
				}
				
			},
			error : function(data, textStatus) {
				alert("작업 실패");
			},
			complete : function(data, textStatus) {
				//alert("작업을완료 했습니다");
			}
		}); //end ajax	
		}// else문 예매일 선택시에만 넘어가게
		}// else login시에 예매 가능하게
	}

	
			
	function imagePopup(type,layer) {
		console.log(type,layer)
		if (type == 'open') {
			if(layer == 'layer'){
				// 팝업창을 연다.
				$('#layer').attr('style', 'visibility:visible');
				// 페이지를 가리기위한 레이어 영역의 높이를 페이지 전체의 높이와 같게 한다.
				$('#layer').height(jQuery(document).height());
			}
			else if(layer == 'layer2'){
				jQuery('#layer2').attr('style', 'visibility:visible');
				// 페이지를 가리기위한 레이어 영역의 높이를 페이지 전체의 높이와 같게 한다.
				jQuery('#layer2').height(jQuery(document).height());
			}
		}//type if

		else if (type == 'close') {
			if(layer == 'layer'){
			// 팝업창을 닫는다.
				jQuery('#layer').attr('style', 'visibility:hidden');
			}
			else if(layer== 'layer2'){
				jQuery('#layer2').attr('style', 'visibility:hidden');
			}
		}//type elseif
	}//function
	
	/* function imagePopup(type) {
		console.log(type)
	
		
	}//function */
	function add_wish(goods_id){
		console.log(goods_id)
		var isLogOn = document.getElementById("isLogOn").value;//id가 isLogOn인 input 태그의 value값을 가져와라!
		//var layer = document.getElementById("layer").getAttribute("name");//id가 layer인 태그의 name값을 가져와라!
		var layer = $('#layer2').attr('name');//id가 layer인 태그의 name값을 가져와라! 제이쿼리!!
		if(isLogOn == 'false' || isLogOn ==''){
			alert("로그인 후 이용가능합니다.")
			location.href="${contextPath}/member/loginForm.do"
		}else{
		$.ajax({
			type : "post",
			async : false, //false인 경우 동기식으로 처리한다. 순서대로 처리
			url : "${contextPath}/goods/addwish.do",
			data : {
				
				goods_id:goods_id
	
			},
			success : function(data, textStatus) {
			
				if(data.trim()=='null'){
					imagePopup('open', layer);	//.layer02은 null이다. 
				}else if(data.trim()=='isAlreadyExisted'){
					alert("이미 위시리스트에 등록된 상품입니다.");	
				}
				
			},
			error : function(data, textStatus) {
				alert("작업 실패");
			},
			complete : function(data, textStatus) {
				
			}
		}); //end ajax	 
		}//else
		
	} 
function fn_order_each_goods(goods_id,goods_title,goods_sales_price,fileName){ 
	//var goods_ticket_date=document.getElementById("goods_ticket_date").value;
	var goods_ticket_date= $('#goods_ticket_date').val();//253행 goods_ticket_date의 값
	// 263행 href="javascript:fn_order_each_goods('${goods.goods_id }','${goods.goods_title}','${goods.goods_sales_price}','${goods.goods_fileName}')로 받은 값 
	var _isLogOn=document.getElementById("isLogOn");
	var isLogOn=_isLogOn.value;
	 
	 if(isLogOn=="false" || isLogOn=='' ){
		alert("로그인 후 주문이 가능합니다!!!");
	} 
	 else{//로그인 돼있으면
		 if(goods_ticket_date == ''){
			 alert("예매일을 입력해 주세요!!")
		 }
		 else{
	 	var total_price,final_total_price;
		var order_goods_qty=document.getElementById("order_goods_qty"); //251행 order_goods_qty의 값
		
	var formObj=document.createElement("form");//폼 만들기 
	
	var i_goods_id = document.createElement("input"); //input tag 만들기
    var i_goods_title = document.createElement("input");
    var i_goods_sales_price=document.createElement("input");
    var i_fileName=document.createElement("input");
    var i_order_goods_qty=document.createElement("input");
    var i_goods_ticket_date=document.createElement("input");
 
    i_goods_id.name="goods_id"; 
    i_goods_title.name="goods_title"; 
    i_goods_sales_price.name="goods_sales_price";
    i_fileName.name="goods_fileName";
    i_order_goods_qty.name="order_goods_qty";
    i_goods_ticket_date.name ="goods_ticket_date";
    
    i_goods_id.value=goods_id;//'${goods.goods_id }
    i_order_goods_qty.value=order_goods_qty.value;// 100행에서 id로 받은 값
    i_goods_title.value=goods_title;//${goods.goods_title}'
    i_goods_sales_price.value=goods_sales_price;//'${goods.goods_sales_price}'
    i_fileName.value=fileName;//${goods.goods_fileName}
    i_goods_ticket_date.value=goods_ticket_date;
    //폼에 입력
    
    formObj.appendChild(i_goods_id);
    formObj.appendChild(i_goods_title);
    formObj.appendChild(i_goods_sales_price);
    formObj.appendChild(i_fileName);
    formObj.appendChild(i_order_goods_qty);
    formObj.appendChild(i_goods_ticket_date);
	//폼을 바디에 입력
    document.body.appendChild(formObj);
	//포스트 형식으로 "${contextPath}/order/orderEachGoods.do" 경로로 전송
    formObj.method="post";
    formObj.action="${contextPath}/order/orderEachGoods.do";
    formObj.submit();
	}//else	예매일
	}//else 로그인

}
	
	//오늘 이전엔 예매 안되도록 하는 함수!!
function ticket_date(){
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1;
	var yyyy = today.getFullYear();
	
	if(dd<10){
		dd='0'+dd;
	}
	if(mm<10){
		mm='0'+mm;
	}
	today = yyyy+'-'+mm+'-'+dd;
	document.getElementById("goods_ticket_date").setAttribute("min",today);
	}
	
	//탭 메뉴 함수 
	
function openPage(pageName, elmnt, color) {
  // Hide all elements with class="tabcontent" by default */
  var i, tabcontent, tablinks;
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }

  // Remove the background color of all tablinks/buttons
  tablinks = document.getElementsByClassName("tablink");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].style.backgroundColor = "";
  }

  // Show the specific tab content
  document.getElementById(pageName).style.display = "block";

  // Add the specific color to the button used to open the tab content
  elmnt.style.backgroundColor = color;
}

// Get the element with id="defaultOpen" and click on it
$(document).ready(function(){

	document.getElementById("defaultOpen").click();
	
});

</script>

</head>
<body>
<input id="imageList" type="hidden" value="${imageList}">
				
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
		<h2>티켓구매&gt; <a href="${contextPath}/goods/place.do?goods_place=${goodsMap.goodsVO.goods_place}">${place}</a>&gt;		
		<a href="${contextPath}/goods/sort.do?goods_sort=${goodsMap.goodsVO.goods_sort}">${sort}</a></h2>
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
					<td class="fixed"  >정가</td>
					<td style="background-color: #e6f2ff"><span >
					   <fmt:formatNumber  value="${goods.goods_price}" type="number" pattern="#,###" var="goods_price" />
				         <span style="text-decoration: line-through;color:black; ">${goods_price}원</span> 
					</span></td>
				</tr>
				<tr class="dot_line">
					<td class="fixed">판매가</td>
					   <fmt:formatNumber  value="${goods.goods_sales_price}" type="number" pattern="#,###" var="goods_sales_price"/>
					<td class="fixed">
					  
					  
				        <span style="color:red;"> ${goods_sales_price}원(${goods.goods_discount}% 할인)</span></td>
				</tr>
				<tr>
					<td class="fixed" >포인트적립</td>
					<td style="color:black; background-color: #e6f2ff;">${goods.goods_point}P</td>
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
			<!-- 오늘~ 티켓 유효기간까지만 예매 가능하게 해둠 -->
				 	<input type="date" id="goods_ticket_date" max="${goods.goods_expired_date}" onclick="ticket_date()"/> <!-- 103행,52행에 getelementbyid()하는 값  -->
				 	
				 	<div id="goods11"></div>	
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
			<li><a href="javascript:add_cart('${goods.goods_id }')">장바구니</a></li>
			<li><a href="javascript:add_wish('${goods.goods_id}')">위시리스트</a></li>
			<%--1.ajax 
			2.매핑주소 get방식으로 값 넘기기
			<li><a href="javascript:add_wish('${goods.goods_id}')">위시리스트</a></li>
			<li><a href="${contextPath}/goods/addwish.do?goods_id=${goods.goods_id}">위시리스트</a></li> --%>
		</ul>
	</div>
	<div class="clear"></div>
	<button class="tablink" onclick="openPage('이름1', this, '#2196F3')" id="defaultOpen">상세설명</button>
	<button class="tablink" onclick="openPage('이름2', this, '#2196F3')">이용약관</button>
	<button class="tablink" onclick="openPage('이름3', this, '#2196F3')">사용방법</button>
	<button class="tablink" onclick="openPage('이름4', this, '#2196F3')">위치</button>
	<button class="tablink" onclick="openPage('이름5', this, '#2196F3')">리뷰</button>
	
	<div id="이름1" class="tabcontent" >
	
	<div class="clear"></div>
				 <p><div class="cont">${fn:replace(goods.goods_description,crcn,br)}</div>
				<c:forEach var="image" items="${imageList}">				
					<img style="width:720px; height:500px;margin-left: auto; margin-right: auto;" 
					src="${contextPath}/resources/shopping/file_repo/${goods.goods_id}/${image.fileName}">
				</c:forEach>
		
	</div>

	<div id="이름2" class="tabcontent">
	
	<div class="clear"></div>	
				<p><div class="title">주최: ${goods.goods_publisher}</div>
				 <p><div class="cont">${fn:replace(goods.goods_terms,crcn,br)}</div>
			
	</div>

	<div id="이름3" class="tabcontent">
			
	<div class="clear"></div>
				 <p><div class="cont">${fn:replace(goods.goods_usage,crcn,br)}</div>
				</div>
	

	<div id="이름4" class="tabcontent">

	<div class="clear"></div>
				 <p><div class="cont">${fn:replace(goods.goods_location,crcn,br)}</div>
				
	</div>
	
	<div id="이름5" class="tabcontent">
	
	<div class="clear"></div>
				 <p><div class="cont">
<!-- 리뷰 내용 -->			 
 <div class="container-fluid px-1 py-5 mx-auto">
    <div class="row justify-content-center">
        <div class="col-xl-7 col-lg-8 col-md-10 col-12 text-center mb-5">
            <div class="card">
                <div class="row justify-content-left d-flex">
           		   <!--<div class="col-md-4 d-flex flex-column"> -->
                        <div class="rating-box">
                            <h1 class="pt-4">4.0</h1>
                            <p class="">out of 5</p>
                        </div>
                   
                    <!-- </div> -->
                    <div class="col-md-8" style="display: inline-block; margin-top: 40px;" >
                        <div class="rating-bar0 justify-content-center">
                            <table class="text-left mx-auto">
                           
                                <tr>
                                    <td class="rating-label">Excellent</td>
                                    <td class="rating-bar">
                                        <div class="bar-container">
                                            <div class="bar-5"></div>
                                        </div>
                                    </td>
                                    <td class="text-right">123</td>
                                </tr>
                                <tr>
                                    <td class="rating-label">Good</td>
                                    <td class="rating-bar">
                                        <div class="bar-container">
                                            <div class="bar-4"></div>
                                        </div>
                                    </td>
                                    <td class="text-right">23</td>
                                </tr>
                                <tr>
                                    <td class="rating-label">Average</td>
                                    <td class="rating-bar">
                                        <div class="bar-container">
                                            <div class="bar-3"></div>
                                        </div>
                                    </td>
                                    <td class="text-right">10</td>
                                </tr>
                                <tr>
                                    <td class="rating-label">Poor</td>
                                    <td class="rating-bar">
                                        <div class="bar-container">
                                            <div class="bar-2"></div>
                                        </div>
                                    </td>
                                    <td class="text-right">3</td>
                                </tr>
                                <tr>
                                    <td class="rating-label">Terrible</td>
                                    <td class="rating-bar">
                                        <div class="bar-container">
                                            <div class="bar-1"></div>
                                        </div>
                                    </td>
                                    <td class="text-right">0</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <!-- 별점 이미지-->
                         <div style="width: 130px; "> <span class="fa fa-star star-active mx-1"></span>
                        		<span class="fa fa-star star-active mx-1"></span>
                        		<span class="fa fa-star star-active mx-1"></span> 
                        		<span class="fa fa-star star-active mx-1"></span> 
                        		<span class="fa fa-star star-inactive mx-1"></span> 
                        </div>
                </div>
            </div>
            <div class="card">
                <div class="row d-flex">
                    <div class=""> <img class="profile-pic" src="https://i.imgur.com/V3ICjlm.jpg"> </div>
                    <div class="d-flex flex-column">
                        <h3 class="mt-2 mb-0">Vikram jit Singh</h3>
                        <div>
                            <p class="text-left"><span class="text-muted">4.0</span> 
                            <span class="fa fa-star star-active ml-3"></span> 
                            <span class="fa fa-star star-active"></span> 
                            <span class="fa fa-star star-active"></span> 
                            <span class="fa fa-star star-active"></span> 
                            <span class="fa fa-star star-inactive"></span></p>
                        </div>
                    </div>
                    <div class="ml-auto">
                        <p class="text-muted pt-5 pt-sm-3">10 Sept</p>
                    </div>
                </div>
                <div class="row text-left">
                    <h4 class="blue-text mt-3">"An awesome activity to experience"</h4>
                    <p class="content">If you really enjoy spending your vacation 'on water' or would like to try something new and exciting for the first time.</p>
                </div>
                <div class="row text-left mt-4">
                    <div class="like mr-3 vote"> <img src="https://i.imgur.com/mHSQOaX.png"><span class="blue-text pl-2">20</span> </div>
                    <div class="unlike vote"> <img src="https://i.imgur.com/bFBO3J7.png"><span class="text-muted pl-2">4</span> </div>
                </div>
            </div>
        </div>
    </div>
</div>
				 
</div><!-- 리뷰내용 -->			
	</div>
	
	
	<div class="clear"></div>
	
	<div class="clear"></div>
	
	<div id="layer" style="visibility: hidden" name="layer" class="layer">
		<!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다. -->
		<div id="popup">
			<!-- 팝업창 닫기 버튼 -->
			<a href="javascript:" onClick="javascript:imagePopup('close', 'layer');"> <img
				src="${contextPath}/resources/image/close.png" id="close" />
			</a> <br /> <font size="12" id="contents" style="font-size: 30pt;text-align: center;">장바구니에<br> 담았습니다.</font><br><br>
			<form   action='${contextPath}/cart/myCartList.do'  >				
				<input  type="submit" value="장바구니 보기">
			</form>			
		</div>
	</div>
	<div id="layer2" style="visibility: hidden" name="layer2">
		<div id="popup">
			<a href="javascript:" onClick="javascript:imagePopup('close','layer2');">
			<img
				src="${contextPath}/resources/image/close.png" id="close" />
			</a> <br /> <font size="12" id="contents" style="font-size:30pt; text-align: center;">위시리스트에<br> 담았습니다.</font><br><br>
			<form   action='${contextPath}/goods/WishList.do'  >				
				<input  type="submit" value="위시리스트 보기">
			</form>			
			
		</div>
	</div>
	
</body>
</html>
<input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}"/>
<%-- 	<!-- 내용 들어 가는 곳 -->
	<div id="container">
		<ul class="tabs">
			<li><a href="#tab1">상세설명</a></li>
			<li><a href="#tab2">이용약관</a></li>
			<li><a href="#tab3">사용방법</a></li>
			<li><a href="#tab4">위치</a></li>
			<li><a href="#tab5">리뷰</a></li>
			<li><a href="#tab6">기타</a></li>
		</ul>
		<div class="tab_container">
			<div class="tab_content" id="tab1" >
				<h4>상세설명</h4>
				<p>${fn:replace(goods.goods_description,crcn,br)}</p>
				<c:forEach var="image" items="${imageList}">
					<img src="${contextPath}/resources/shopping/file_repo/${goods.goods_id}/${image.fileName}">
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
	</div> --%>