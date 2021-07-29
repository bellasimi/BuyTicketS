<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	 isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!-- 주문자 휴대폰 번호 -->
<c:set  var="orderer_hp" value=""/>
<!-- 최종 결제 금액 -->
<c:set var="final_total_order_price" value="0" />

<!-- 총주문 금액 -->
<c:set var="total_order_price" value="0" />
<!-- 총 상품수 -->
<c:set var="total_order_goods_qty" value="0" />
<!-- 총할인금액 -->
<c:set var="total_discount_price" value="0" />


<head>
<style>

/*main.css에서 확인해야함*/
#layer {
	z-index: 2;
	position: absolute;
	top: 0px;
	left: 0px;
	width: 100%;
	/*background-color:rgba(0,0,0,0.8); */
}

/*적용안해둠*/
#popup_order_detail {
	z-index: 3;
	position: fixed;
	text-align: center;
	left: 10%;
	top: 0%;
	width: 60%;
	height: 100%;
	background-color:#ccff99;
	border: 2px solid  #0000ff;
}

#close {
	z-index: 4;
	float: right;
}


input.in_order {
 /* width: 100%;*/
 /* margin-bottom: 20px;*/
 margin:15px;
  padding: 10px 12px;
  border: 1px solid #ccc;
  border-radius: 3px;
}


table.list_view tr:nth-child(odd) {
  background-color: #f2f2f2;
}

/*요기 작업하다보면 css에러남 태그자체를 내가 만든건데...*/

table.total_view {
	background-color: #E6F2FF;

	 /*border: 2px solid #c7c7c7;*/
	 padding: 70px 230px 70px 90px;
	 font-size: 20px;
	 border-radius: 10px;
}

table.total_view.td{
	padding: 100px;
}

button.cart_btn {
	border-radius: 3px;
	border: 1px solid rgb(153, 153, 153);
	width: 80px;
	height: 30px;
    text-align: center;
	padding: 3px;
	color: rgb(153, 153, 153);
	font-family: 'NanumBarunGothic', 'sans-serif';
	font-size: 1.2em; 
	font-weight: bold;
	
}
button.buy_btn{
	border-radius: 3px;
	border: 1px solid rgb(255, 0, 0);
	width: 80px;
	height: 30px;
    text-align: center;
	padding: 3px;
	font-color: rgb(255, 0, 0);
	font-family: 'NanumBarunGothic', 'sans-serif';
	font-size: 1.2em; 
	font-weight: bold;
}
button[name=total]{
	width : 150px;
	height : 40px;
}

/*
.detail_table{
width:80%;
bgcolor : white;
}*/

</style>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>

<script>

//적립금 사용부분
  $(document).ready(function(){
	$("#use_point_all").click(function() {
		console.log("적립금 모두사용");
		var point_used=document.form_order.point_used;
		point_used.value=point_used.max;
	});
  });

//할인 정보입력
$(document).ready(function(){
	$(".discountBox").change(function() {
		var point_used=0;
		var discount_sangpum=0;
		var discount_okcashbag=0;
		var discount_coupon=0;
		var totalDiscount=0;
		if($("#ch_point_used").prop("checked")){
			console.log("point");
			point_used=document.form_order.point_used.value;
			point_used=parseInt(point_used);
		}
		if($("#ch_discount_sangpum").prop("checked")){
			discount_sangpum=document.form_order.discount_sangpum.value;
			discount_sangpum=parseInt(discount_sangpum);
		}
		if($("#ch_discount_okcashbag").prop("checked")){
			discount_okcashbag=document.form_order.discount_okcashbag.value;
			discount_okcashbag=parseInt(discount_okcashbag);
		}
		if($("#ch_discount_coupon").prop("checked")){
			discount_coupon=document.form_order.discount_coupon.value;
			discount_coupon=parseInt(discount_coupon);
		}
		totalDiscount=point_used+discount_sangpum+discount_okcashbag+discount_coupon;
		var totalPrice=document.form_order.h_totalPrice.value;
		totalPrice=parseInt(totalPrice);
		document.getElementById("p_totalDiscount").innerHTML=totalDiscount;
		document.getElementById("p_final_totalPrice").innerHTML=totalPrice-totalDiscount;

		var h_final_total_Price=document.form_order.h_final_total_Price;
		h_final_total_Price.value=totalPrice-totalDiscount;
	});	
});
	
   
//결제창 띄우기
function fn_pay_phone(){
	var e_card=document.getElementById("tr_pay_card");
	var e_phone=document.getElementById("tr_pay_phone");
	var e_account=document.getElementById("tr_random_account");
	e_card.style.visibility="hidden";
	e_phone.style.visibility="visible";
	e_account.style.visibility="hidden";
}
function fn_random_account() {
	var e_card=document.getElementById("tr_pay_card");
	var e_phone=document.getElementById("tr_pay_phone");
	var e_account=document.getElementById("tr_random_account");
	e_card.style.visibility="hidden";
	e_phone.style.visibility="hidden";
	e_account.style.visibility="visible";
	
}

function fn_pay_card(){
	var e_card=document.getElementById("tr_pay_card");
	var e_phone=document.getElementById("tr_pay_phone");
	var e_account=document.getElementById("tr_random_account");
	e_card.style.visibility="visible";
	e_phone.style.visibility="hidden";
	e_account.style.visibility="hidden";
}
	



/* 주문 db에 넘겨줘야 하는 값들ㅇㅇ  orderlist랑 memberinfo 빼고 전부 
order_id,
	member_id,// session-member에 있는값
   goods_id, //myOrderList
   orderer_name,// session-member
   orderer_hp,//session-member
   goods_title, //myOrderList
   order_goods_qty, //myOrderList
   goods_sales_price, //myOrderList
   goods_fileName, //myOrderList
   pay_method,
   random_account,
   card_com_name,
   card_number,
   card_expired_m,
   card_expired_y,
   pay_hp_com,
   pay_hp_num,
   goods_ticket_date, //myOrderList
   goods_point, //myOrderList
   order_total_price,
   point_used
   */

var goods_id="";
var goods_title="";
var goods_fileName="";

var order_goods_qty;
var each_goods_price;
var total_order_goods_price;
var total_order_goods_qty;
var orderer_name;

var pay_method="";
var random_account="";
var card_com_name="";
var card_number="";
var card_expired_m="";
var card_expired_y="";
var pay_hp_num="";
var pay_hp_com="";
var goods_ticket_date; //myOrderList
var goods_point; //myOrderList
var order_total_price=0;
var point_used=0;

//가장 마지막 최종결제하기  결제정보를 넘기는 곳 
function fn_process_pay_order(){
console.log("최종결제하기");

var isLogOn = document.getElementById("isLogOn").value;
if(isLogOn == 'false'||isLogOn == ''){
	alert("로그인 후 이용가능합니다.")
	location.href="${contextPath}/member/loginForm.do"
}else{


var r_pay_method  =  document.form_order.pay_method;

//최종액 넘겨주기 위한곳
var order_total_price=document.getElementById("h_final_total_Price").value;
console.log("전체금액 객체제대로 넘어오는지"+order_total_price)
order_total_price=parseInt(order_total_price);
	for(var i=0; i<r_pay_method.length;i++){
	  if(r_pay_method[i].checked==true){
		  pay_method=r_pay_method[i].value;
		  if(pay_method=="신용카드"){
			var i_card_com_name=document.getElementById("card_com_name");
			var i_card_num1=document.getElementById("card_num1");
			var i_card_num2=document.getElementById("card_num2");
			var i_card_num3=document.getElementById("card_num3");
			var i_card_expired_m=document.getElementById("card_expired_m");
			var i_card_expired_y=document.getElementById("card_expired_y");
			
			card_com_name=i_card_com_name.value;
			card_num1=i_card_num1.value;
			card_num2=i_card_num2.value;
			card_num3=i_card_num3.value;
			
			card_number=card_num1+"-"+card_num2+"-"+card_num3;
			card_expired_m=i_card_expired_m.value;
			card_expired_y=i_card_expired_y.value;
			
			if(card_num1=="" || card_num2=="" || card_num3=="") {
				alert("결제정보를 입력해주세요!");
				console.log("카드입력안됨");
				return false;
			}
			
		  }else if(pay_method=="휴대폰결제"){
			var i_pay_hp_com=document.getElementById("pay_hp_com");
			var i_pay_hp1=document.getElementById("pay_hp1");
			var i_pay_hp2=document.getElementById("pay_hp2");
			var i_pay_hp3=document.getElementById("pay_hp3");
			pay_hp1=i_pay_hp1.value;
			pay_hp2=i_pay_hp2.value;
			pay_hp3=i_pay_hp3.value;
			
			pay_hp_com=i_pay_hp_com.value;
			pay_hp_num=pay_hp1+"-"+pay_hp2+"-"+pay_hp3;
			console.log("pay_hp_num");
			
			if(pay_hp1=="" || pay_hp2=="" || pay_hp3=="") {
				alert("결제정보를 입력해주세요!");
				console.log("핸드폰결제안됨");
				return false;
			}
			
		  } else if(pay_method=="무통장입금") {
			  var i_random_account=document.getElementById("random_account");
			  random_account=i_random_account.value;
			  
		  }//end if
		  break;
	  }// end for
	}
	
	var point_used = document.getElementById("point_used").value;
	point_used=parseInt(point_used);
	console.log("point_used"+point_used+typeof point_used);
	//포인트 사용된값 받으려면 checked도 되어있어야 함 --------- 
	
	
	
	//alert("최종 결제하기");
	var formObj=document.createElement("form");

    var i_pay_method=document.createElement("input");
    var i_random_account=document.createElement("input");
    var i_card_com_name=document.createElement("input");
    var i_card_number=document.createElement("input");
    var i_card_expired_m=document.createElement("input");
    var i_card_expired_y=document.createElement("input");
    var i_pay_hp_num=document.createElement("input");
    var i_pay_hp_com=document.createElement("input");
    var i_order_total_price=document.createElement("input");
    var i_point_used=document.createElement("input");

    i_pay_method.name="pay_method";
  	i_random_account.name="random_account";
    i_card_com_name.name="card_com_name";
    i_card_number.name="card_number";
    i_card_expired_m.name="card_expired_m";
    i_card_expired_y.name="card_expired_y";
    i_pay_hp_com.name="pay_hp_com";
    i_pay_hp_num.name="pay_hp_num";
    i_order_total_price.name="order_total_price";
    i_point_used.name="point_used";
  	
    console.log("pay_method"+pay_method);
    console.log("random_account"+random_account);
    console.log("card_com_name"+card_com_name);
    console.log("card_number"+card_number);
    console.log("card_expired_m"+card_expired_m+card_expired_y);
    console.log("pay_hp_com"+pay_hp_com);
    console.log("pay_hp_num"+pay_hp_num);
    console.log("point_used"+point_used+typeof point_used );
    console.log("order_total_price"+order_total_price+typeof order_total_price);
    
    
  i_pay_method.value=pay_method;
     i_random_account.value=random_account;
     i_card_com_name.value=card_com_name;
     i_card_number.value=card_number;
     i_card_expired_m.value=card_expired_m;
     i_card_expired_y.value=card_expired_y;
      i_pay_hp_com.value=pay_hp_com;
     i_pay_hp_num.value=pay_hp_num;
     i_order_total_price.value=order_total_price;
     i_point_used.value=point_used;

    
    //더미데이터 넣은부분
   
    /*i_pay_method.value=pay_method;
    i_random_account.value="00000000";
    i_card_com_name.value="신한";
    i_card_number.value="000-0999";
    i_card_expired_m.value="09";
    i_card_expired_y.value="22";    
    i_pay_hp_com.value="SKT";
    i_pay_hp_num.value="010-000-0000";
    i_order_total_price.value=4000;
    i_point_used.value=1000;
    */

    formObj.appendChild(i_pay_method);
    formObj.appendChild(i_random_account);
    formObj.appendChild(i_card_com_name);
    formObj.appendChild(i_card_number);
    formObj.appendChild(i_card_expired_m);
    formObj.appendChild(i_card_expired_y);
    formObj.appendChild(i_pay_hp_com);
    formObj.appendChild(i_pay_hp_num);
    formObj.appendChild(i_order_total_price);
    formObj.appendChild(i_point_used);
    

    document.body.appendChild(formObj);  //orderController에서 receiverMap으로 받아간다
    formObj.method="post";
    formObj.action="${contextPath}/order/payToOrderGoods.do";
    formObj.submit();

	}
}


//결제하기 확인 팝업창
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


</script>
</head>
<body>
<br>
	<H1>주문확인</H1>
<form  name="form_order">	
<div>
	  <br><br>
	   
<table class="member_view">
 <tbody>
 	<tr><td colspan="2"><h1>주문한 사람</h1></td></tr>
	<tr class="dot_line">
		<td><h2>이름</h2></td>
		<td>
			 <input class="in_order" type="text" value="${orderer.member_name}" id="h_orderer_name" size="15" />
		</td>
	</tr>
	<tr class="dot_line">
		<td ><h2>핸드폰</h2></td>
		<td>
			 <input class="in_order" type="text" value="${orderer.hp1}-${orderer.hp2}-${orderer.hp3}" size="15" />
		</td>
	</tr>
	<tr class="dot_line">
		<td ><h2>이메일</h2></td>
		<td>
			 <input class="in_order" type="text" value="${orderer.email1}@${orderer.email2}" size="15" />
		</td>
	</tr>
  </tbody>
</table>
</div>

<div class="clear"></div>

	<br>
	<br>


<H1>주문 상품</H1>
<table class="list_view">
 <tbody align=center>
	<tr style="background: #2196F3; color:white; font-weight:bold; font-size:15px;">
		<td colspan=2 class="fixed">주문상품명</td>
		<td>예약일</td>
		<td>수량</td>
		<td>주문금액</td>
		<td>예상적립금</td>
	</tr>
		<c:forEach var="item" items="${myOrderList}">
	<tr> <!-- 상품 하나씩 나오는 부분  -->
		<td class="goods_image">
			<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
	        	<img width="75" alt=""  src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
				<input   type="hidden" id="h_goods_id" name="h_goods_id" value="${item.goods_id }" />
		    	<input   type="hidden" id="h_goods_fileName" name="h_goods_fileName" value="${item.goods_fileName }" />
			</a>
		</td>
		<td>
			<h2>
			     <a href="${pageContext.request.contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">${item.goods_title }</a>
			     <input   type="hidden" id="h_goods_title" name="h_goods_title" value="${item.goods_title }" />
			</h2>
		</td>
		<td> 
			${item.goods_ticket_date}
		</td>
		<td>
			<h2>${item.order_goods_qty }개<h2> 
			<input   type="hidden" id="h_order_goods_qty" name="h_order_goods_qty" value="${item.order_goods_qty}" />
		</td>
		<td><!-- 주문금액 -->
			<fmt:formatNumber value="${item.goods_sales_price}" var="goodssales_price" pattern="#,###"/>
			<h2>${goodssales_price}원</h2>
		</td>
		<td><!--  포인트 -->
			<fmt:formatNumber value="${item.goods_point}" var="point" pattern="#,###"/>
			<h2>${point}p</h2>
		</td>
			
	</tr>
	<tr align="right">
		<td colspan="6">
			<fmt:formatNumber value="${item.goods_sales_price*item.order_goods_qty}" var="sales_qty_price" pattern="#,###"/>
	   	    <h2>총 주문금액 : ${sales_qty_price}원</h2>
			<input  type="hidden" id="h_each_goods_price"  name="h_each_goods_price" value="${item.goods_sales_price*item.order_goods_qty}" />
		</td>
	</tr>
		<c:set var="final_total_order_price"
			value="${final_total_order_price+ item.goods_sales_price*item.order_goods_qty}"/>
		<c:set var="total_order_price"
			value="${total_order_price+ item.goods_sales_price*item.order_goods_qty}"/>
		<!-- 총 주문한 티켓장수 -->
			<c:set var="total_order_goods_qty"
				value="${total_order_goods_qty+item.order_goods_qty }" />
</c:forEach>
 </tbody>
</table>

	
	<div class="clear"></div>
	<br>
	<br>
	<br>


<H1>할인 정보</H1>
<div class="detail_table">
	<table>
		
		<tbody>
			<tr class="dot_line">
				<td width=100>
					포인트
					<button type="button" id="use_point_all">모두사용</button>					
				</td> 
				<td><input id="point_used" class="in_order" type="text" size="10" min="0" max="${orderer.member_point}" value="0"/>원/${orderer.member_point}원
						&nbsp;&nbsp;&nbsp; <input type="checkbox" id="ch_point_used" class="discountBox" onclick=""/> 사용하기</td>
						
					
			</tr>
				
			<tr class="dot_line">
				<td>상품권 전환금</td>
				<td cellpadding="5"><input id="discount_sangpum" class="in_order" type="text" size="10" value="0"/>원 &nbsp;&nbsp;&nbsp; 
					<input type="checkbox" id="ch_discount_sangpum" class="discountBox"> 사용하기
				</td>
			</tr>
			<tr class="dot_line">
				<td>OK 캐쉬백 포인트</td>
				<td cellpadding="5"><input id="discount_okcashbag" class="in_order" type="text" size="10" value="0"/>원 &nbsp;&nbsp;&nbsp; 
					<input type="checkbox" id="ch_discount_okcashbag" class="discountBox"> 사용하기
				</td>
			</tr>
			<tr class="dot_line">
				<td>쿠폰할인</td>
				<td cellpadding="5"><input id="discount_coupon" class="in_order" type="text"	size="10" value="0"/>원 &nbsp;&nbsp;&nbsp; 
					<input type="checkbox"  id="ch_discount_coupon" class="discountBox"> 사용하기
				</td>
			</tr>
		</tbody>
	</table>
</div>
	<div class="clear"></div>
	<br>
	
<table class="total_view">
 <tbody>
	<tr><td colspan="2">총계</td></tr>
	<tr><td colspan="2"><hr></td></tr>
	<tr>
		<td>총 상품수 </td>
		<td align="right">
        	<p id="p_totalNum">${total_order_goods_qty}개</p> 
			<input id="h_total_order_goods_qty" type="hidden" value="${total_order_goods_qty}" />
        </td>
     </tr>
     <tr>
         <td>총 상품금액</td>
         <td align="right">
             <fmt:formatNumber value="${total_order_price}" var="totalorder_price" pattern="#,###"/>
		     <p id="p_totalPrice">${totalorder_price}원</p> 
			 <input id="h_totalPrice" type="hidden" value="${total_order_price}" />
         </td>
     <tr>
       	 <td>총 할인 금액 </td>
         <td align="right">  
         	<p id="p_totalDiscount">0</p>
			<input id="h_total_sales_price" type="hidden" value="${total_discount_price}" />
         </td>
     </tr>
     <tr><td colspan="2"><br></td></tr>
     <tr>
     	 <td>최종 결제금액</td>
         <td align="right">
            <p id="p_final_totalPrice">
            <font size="15">
				${totalorder_price}원 
			</font></p> <input id="h_final_total_Price" type="hidden" value="${total_order_price}"/>
          </td>
      </tr>
  </tbody>
</table> 

   <div class="clear"></div>
	<br>
	<br>
	<br>
<h1>결제정보</h1>
<div class="detail_table">
	<table>
	  <tbody>
		<tr>
			<td>
				<input type="radio" id="pay_method" name="pay_method" value="신용카드"   onclick="fn_pay_card()" checked>신용카드 &nbsp;&nbsp;&nbsp; 
			    <input type="radio" id="pay_method" name="pay_method" value="휴대폰결제" onclick="fn_pay_phone()">휴대폰 결제 &nbsp;&nbsp;&nbsp;
				<input type="radio" id="pay_method" name="pay_method" value="무통장입금" onclick="fn_random_account()">무통장 입금 &nbsp;&nbsp;&nbsp;
			</td>
		</tr>
		<tr>
			<td>
			   <input type="radio" id="pay_method" name="pay_method" value="실시간 계좌이체">실시간 계좌이체 &nbsp;&nbsp;&nbsp;
			   <input type="radio" id="pay_method" name="pay_method" value="카카오페이(간편결제)">카카오페이(간편결제) &nbsp;&nbsp;&nbsp; 
			   <input type="radio" id="pay_method" name="pay_method" value="페이나우(간편결제)">페이나우(간편결제) &nbsp;&nbsp;&nbsp; 
			   <input type="radio" id="pay_method" name="pay_method" value="페이코(간편결제)">페이코(간편결제) &nbsp;&nbsp;&nbsp;
			</td>
		</tr>
		<tr id="tr_pay_card">
			<td>
			  <strong>카드 선택<strong>:&nbsp;&nbsp;&nbsp;
			  <select id="card_com_name" name="card_com_name">
					<option value="삼성" selected>삼성</option>
					<option value="하나SK">하나SK</option>
					<option value="현대">현대</option>
					<option value="KB">KB</option>
					<option value="신한">신한</option>
					<option value="롯데">롯데</option>
					<option value="BC">BC</option>
					<option value="시티">시티</option>
					<option value="NH농협">NH농협</option>
			  </select>
			  <input type="text" id="card_num1" size="4">&nbsp;<input type="text" id="card_num2" size="4">&nbsp;<input type="text" id="card_num3" size="4">
				<br><Br>
			  <strong>유효기간</strong>
			  <select id="card_expired_m">
					<option>01</option>
					<option>02</option>
					<option>03</option>
					<option>04</option>
					<option>05</option>
					<option>06</option>
					<option>07</option>
					<option>08</option>
					<option>09</option>
					<option>10</option>
					<option>11</option>
					<option>12</option>
				</select>
				<select id="card_expired_y">
					<option>21</option>
					<option>22</option>
					<option>23</option>
					<option>23</option>
					<option>25</option>
					<option>26</option>
					<option>27</option>
					<option>28</option>
					<option>29</option>
					<option>30</option>
				</select>
			</td>
		</tr>
		<tr id="tr_pay_phone" style="visibility:hidden">
		    <td>
			   <strong>휴대폰 번호 입력: <strong>
			   <select id="pay_hp_com"	name="pay_hp_com">
					<option>SKT</option>
					<option>KT</option>
					<option>LG U+</option>
					<option>알뜰폰</option>
				</select>
				<select id="pay_hp1" name="pay_hp1">
					<option>없음</option>
					<option value="010" selected>010</option>
					<option value="011">011</option>
					<option value="016">016</option>
					<option value="017">017</option>
					<option value="018">018</option>
					<option value="019">019</option>
				</select> 
					 - <input size="10px" type="text" id="pay_hp2" name="pay_hp2"> 
					 - <input size="10px" type="text" id="pay_hp3" name="pay_hp3"><br><br> 
					  <input type="hidden" id="h_pay_hp1" name="h_pay_hp1" /> 
					  <input type="hidden" id="h_pay_hp2" name="h_pay_hp2"/> 
					  <input type="hidden" id="h_pay_hp3" name="h_pay_hp3"/>
					  <c:set  var="orderer_hp" value="${orderer.hp1}-${orderer.hp2}-${orderer.hp3 }"/>
				  	      
			</td>
		</tr>
		<tr id="tr_random_account" style="visibility:hidden">
			 <td>
				무통장입금계좌 : 
			  	<input type="text" id="random_account" value="1002-000-00000">
			  </td>
		</tr>
	</tbody>
  </table>
</div>
</form>

    <div class="clear"></div>
	<br>
	<br>
	<br>
	<div align="center">
		<br>
		<br> 
	<button type="button" class="buy_btn" name="total" onclick="javascript:imagePopup('open')">결제하기</button>
    <button type="button" class="cart_btn" name="total" onclick="location.href='${contextPath}/main/main.do'">쇼핑계속하기</button>

	</div>
	
<!-- 결제확인창 -->	
	<div id="layer" style="visibility: hidden" name="layer" class="layer">
		<!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다. -->
		<div id="popup">
				 
			<br /> 
			
			<font size="12" id="contents" style="font-size: 20pt;text-align: center;">
			 티켓 ${total_order_goods_qty}장 <br>결제 하시겠습니까?
			</font><br><br>
				<button type="button" class="buy_btn" name="total" onclick="javascript:fn_process_pay_order()">최종결제하기</button>
   				 <button type="button" class="cart_btn" name="total" onclick="javascript:imagePopup('close');">취소</button>
						
		</div>
	</div>	
	
<input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}"/>	



			
			
			