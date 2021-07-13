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
<!-- 총 배송비 
<c:set var="total_delivery_price" value="0" />-->

<head>
<style>
#layer {
	z-index: 2;
	position: absolute;
	top: 0px;
	left: 0px;
	width: 100%;
	/* background-color:rgba(0,0,0,0.8); */
}

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
</style>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>

<script>




 /*
 //창이 열리면 무조건 실행된다  아직 뭔지 잘 모르겠음 
  window.onload=function()
  {
    init();
  }

  function init(){
  	var form_order=document.form_order;
  	//var h_tel1=form_order.h_tel1;
  	var h_hp1=form_order.h_hp1;
  	//var tel1=h_tel1.value;
  	var hp1=h_hp1.value;
  	//var select_tel1=form_order.tel1;
  	var select_hp1=form_order.hp1;
  //	select_tel1.value=tel1;
  	select_hp1.value=hp1;
  }    
   */ 
   //<input id="point_used" type="number" size="10" min="0" max="${orderer.member_point}"/>원/${orderer.member_point}원
  // <button id="use_point_all">모두사용</button>	   
$(document).ready(function(){
	$("#use_point_all").click(function() {
		console.log("적립금 모두사용");
		var point_used=document.form_order.point_used;
		point_used.value=point_used.max;
		//$("#ch_point_used").prop("checked",true);
	});


//class="discountBox" 
//point_used discount_sangpum discount_okcashbag discount_coupon

$(document).ready(function(){
	$(".discountBox").change(function() {
		var point_used=0;
		var discount_sangpum=0;
		var discount_okcashbag=0;
		var discount_coupon=0;
		var totalDiscount=0;
		console.log("함수2");
		if($("#ch_point_used").prop("checked")){
			console.log("point");
			point_used=document.form_order.point_used.value;
			point_used=parseInt(point_used);
			console.log(point_used+typeof point_used);
		}
		if($("#ch_discount_sangpum").prop("checked")){
			discount_sangpum=document.form_order.discount_sangpum.value;
			discount_sangpum=parseInt(discount_sangpum);
			console.log("discount_sangpum"+discount_sangpum);
		}
		if($("#ch_discount_okcashbag").prop("checked")){
			discount_okcashbag=document.form_order.discount_okcashbag.value;
			discount_okcashbag=parseInt(discount_okcashbag);
			console.log("discount_okcashbag"+discount_okcashbag);
		}
		if($("#ch_discount_coupon").prop("checked")){
			discount_coupon=document.form_order.discount_coupon.value;
			discount_coupon=parseInt(discount_coupon);
			console.log("discount_coupon"+discount_coupon);
		}
		totalDiscount=point_used+discount_sangpum+discount_okcashbag+discount_coupon;
		document.getElementById("p_totalDiscount").innerHTML=totalDiscount;

	
	});	
});
		/*console.log("사용");
		console.log($("#point_used").is("checked",true));
		var point_used;
		var discount_sangpum;
		var discount_okcashbag;
		var discount_coupon;
		
		//var point_used=document.form_order.point_used;
		//point_used.value=point_used.max;
			//console.log(point_used.max);
			if($("#point_used").click()) {
				
			}
		var point_used=document.form_order.point_used.value;
		var discount_sangpum=document.form_order.discount_sangpum.value;
		var discount_okcashbag=document.form_order.discount_okcashbag.value;
		var discount_coupon=document.form_order.discount_coupon.value;
		
		var totalDiscount=point_used+discount_sangpum+discount_okcashbag+discount_coupon;
		document.getElementById("p_totalDiscount").innerHTML=totalDiscount;
		*/
	//});
//});
   

/*
	function reset_all() {
		var e_receiver_name = document.getElementById("receiver_name");
		var e_hp1 = document.getElementById("hp1");
		var e_hp2 = document.getElementById("hp2");
		var e_hp3 = document.getElementById("hp3");

		var e_tel1 = document.getElementById("tel1");
		var e_tel2 = document.getElementById("tel2");
		var e_tel3 = document.getElementById("tel3");

		var e_zipcode = document.getElementById("zipcode");
		var e_roadAddress = document.getElementById("roadAddress");
		var e_jibunAddress = document.getElementById("jibunAddress");
		var e_namujiAddress = document.getElementById("namujiAddress");

		e_receiver_name.value = "";
		e_hp1.value = 0;
		e_hp2.value = "";
		e_hp3.value = "";
		e_tel1.value = "";
		e_tel2.value = "";
		e_tel3.value = "";
		e_zipcode.value = "";
		e_roadAddress.value = "";
		e_jibunAddress.value = "";
		e_namujiAddress.value = "";
	}

	function restore_all() {
		var e_receiver_name = document.getElementById("receiver_name");
		var e_hp1 = document.getElementById("hp1");
		var e_hp2 = document.getElementById("hp2");
		var e_hp3 = document.getElementById("hp3");

		var e_tel1 = document.getElementById("tel1");
		var e_tel2 = document.getElementById("tel2");
		var e_tel3 = document.getElementById("tel3");

		var e_zipcode = document.getElementById("zipcode");
		var e_roadAddress = document.getElementById("roadAddress");
		var e_jibunAddress = document.getElementById("jibunAddress");
		var e_namujiAddress = document.getElementById("namujiAddress");

		var h_receiver_name = document.getElementById("h_receiver_name");
		var h_hp1 = document.getElementById("h_hp1");
		var h_hp2 = document.getElementById("h_hp2");
		var h_hp3 = document.getElementById("h_hp3");

		var h_tel1 = document.getElementById("h_tel1");
		var h_tel2 = document.getElementById("h_tel2");
		var h_tel3 = document.getElementById("h_tel3");

		var h_zipcode = document.getElementById("h_zipcode");
		var h_roadAddress = document.getElementById("h_roadAddress");
		var h_jibunAddress = document.getElementById("h_jibunAddress");
		var h_namujiAddress = document.getElementById("h_namujiAddress");
		//alert(e_receiver_name.value);
		e_receiver_name.value = h_receiver_name.value;
		e_hp1.value = h_hp1.value;
		e_hp2.value = h_hp2.value;
		e_hp3.value = h_hp3.value;

		e_tel1.value = h_tel1.value;
		e_tel2.value = h_tel2.value;
		e_tel3.value = h_tel3.value;
		e_zipcode.value = h_zipcode.value;
		e_roadAddress.value = h_roadAddress.value;
		e_jibunAddress.value = h_jibunAddress.value;
		e_namujiAddress.value = h_namujiAddress.value;

	}
	*/
function fn_pay_phone(){
	
	
	var e_card=document.getElementById("tr_pay_card");
	var e_phone=document.getElementById("tr_pay_phone");
	var e_random_account=document.getElementById("tr_random_account");
	e_card.style.visibility="hidden";
	e_phone.style.visibility="visible";
	e_random_account.visibility="hidden";
}
function fn_random_account() {
		var e_card=document.getElementById("tr_pay_card");
		var e_phone=document.getElementById("tr_pay_phone");
		var e_random_account=document.getElementById("tr_random_account");
		e_card.style.visibility="hidden";
		e_phone.style.visibility="hidden";
		e_random_account.visibility="visible";
}

function fn_pay_card(){
	var e_card=document.getElementById("tr_pay_card");
	var e_phone=document.getElementById("tr_pay_phone");
	var e_random_account=document.getElementById("tr_random_account");
	e_card.style.visibility="visible";
	e_phone.style.visibility="hidden";
	e_random_account.visibility="hidden";
}
	

	
//최종결제 팝업창
/*
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
*/

/*
var goods_id="";
var goods_title="";
var goods_fileName="";

var order_goods_qty
var each_goods_price;
var total_order_goods_price;
var total_order_goods_qty;
var orderer_name;
//var receiver_name
var hp1;
var hp2;
var hp3;

//var tel1;
//var tel2;
//var tel3;

//var receiver_hp_num;
//var receiver_tel_num;
//var delivery_address;
//var delivery_message;
//var delivery_method;
//var gift_wrapping;
var pay_method;
var card_com_name;
//var card_pay_month;
var pay_hp_num;
var final_total_oder_price; */
//최종 결제 팝업창 띄우는 곳 
/*
function fn_show_order_detail(){
	goods_id="";
	goods_title="";
	
	var frm=document.form_order;
	var h_goods_id=frm.h_goods_id;
	var h_goods_title=frm.h_goods_title;
	var h_goods_fileName=frm.h_goods_fileName;
	//var r_delivery_method  =  frm.delivery_method;
	var h_order_goods_qty=document.getElementById("h_order_goods_qty");
	var h_total_order_goods_qty=document.getElementById("h_total_order_goods_qty");
	var h_total_sales_price=document.getElementById("finalprice");
	
	var h_final_total_Price=document.getElementById("h_final_total_Price");
	var h_orderer_name=document.getElementById("h_orderer_name");
	//var i_receiver_name=document.getElementById("receiver_name");
	
	
	if(h_goods_id.length <2 ||h_goods_id.length==null){
		goods_id+=h_goods_id.value;
	}else{
		for(var i=0; i<h_goods_id.length;i++){
			goods_id+=h_goods_id[i].value+"<br>";
			
		}	
	}
	
	if(h_goods_title.length <2 ||h_goods_title.length==null){
		goods_title+=h_goods_title.value;
	}else{
		for(var i=0; i<h_goods_title.length;i++){
			goods_title+=h_goods_title[i].value+"<br>";
			
		}	
	}
	
	
	if(h_goods_fileName.length <2 ||h_goods_fileName.length==null){
		goods_fileName+=h_goods_fileName.value;
	}else{
		for(var i=0; i<h_goods_fileName.length;i++){
			goods_fileName+=h_goods_fileName[i].value+"<br>";
			
		}	
	}
	
	
	total_order_goods_price=h_final_total_Price.value;
	total_order_goods_qty=h_total_order_goods_qty.value;
	
	/* for(var i=0; i<r_delivery_method.length;i++){
	  if(r_delivery_method[i].checked==true){
		 delivery_method=r_delivery_method[i].value
		 break;
	  }
	} 
		
	var r_gift_wrapping  =  frm.gift_wrapping;
	
	
	for(var i=0; i<r_gift_wrapping.length;i++){
	  if(r_gift_wrapping[i].checked==true){
		  gift_wrapping=r_gift_wrapping[i].value
		 break;
	  }
	}  
	
	var r_pay_method  =  frm.pay_method;
	
	for(var i=0; i<r_pay_method.length;i++){
	  if(r_pay_method[i].checked==true){
		  pay_method=r_pay_method[i].value
		  if(pay_method=="신용카드"){
			var i_card_com_name=document.getElementById("card_com_name");
			var i_card_pay_month=document.getElementById("card_pay_month");
			card_com_name=i_card_com_name.value;
			card_pay_month=i_card_pay_month.value;
			pay_method+="<Br>"+
				 		"카드사:"+card_com_name+"<br>"+
				 		"할부개월수:"+card_pay_month;
			pay_hp_num="해당없음";
			//pay_hp_com 추가해야함 
		  }else if(pay_method=="휴대폰결제"){
			var i_pay_order_tel1=document.getElementById("pay_order_tel1");
			var i_pay_order_tel2=document.getElementById("pay_order_tel2");
			var i_pay_order_tel3=document.getElementById("pay_order_tel3");
			pay_hp_num=i_pay_order_tel1.value+"-"+
						   	    i_pay_order_tel2.value+"-"+
							    i_pay_order_tel3.value;
			pay_method+="<Br>"+"결제휴대폰번호:"+pay_hp_num;
			card_com_name="해당없음";
			card_pay_month="해당없음";
		  } //end if
		 break;
	  }// end for
	}
	
	var i_hp1=document.getElementById("hp1");
	var i_hp2=document.getElementById("hp2");
	var i_hp3=document.getElementById("hp3");
	
//	var i_tel1=document.getElementById("tel1");
//	var i_tel2=document.getElementById("tel2");
//	var i_tel3=document.getElementById("tel3");
	
//	var i_zipcode=document.getElementById("zipcode");
//	var i_roadAddress=document.getElementById("roadAddress");
//	var i_jibunAddress=document.getElementById("jibunAddress");
//	var i_namujiAddress=document.getElementById("namujiAddress");
//	var i_delivery_message=document.getElementById("delivery_message");
//	var i_pay_method=document.getElementById("pay_method");

//	alert("총주문 금액:"+total_order_goods_price);
	order_goods_qty=h_order_goods_qty.value;
	//order_total_price=h_order_total_price.value;
	
	orderer_name=h_orderer_name.value;
//	receiver_name=i_receiver_name.value;
//	hp1=i_hp1.value;
//	hp2=i_hp2.value;
//	hp3=i_hp3.value;
	
//	tel1=i_tel1.value;
//	tel2=i_tel2.value;
//	tel3=i_tel3.value;
	
//	receiver_hp_num=hp1+"-"+hp2+"-"+hp3;
//	receiver_tel_num=tel1+"-"+tel2+"-"+tel3;
	
//	delivery_address="우편번호:"+i_zipcode.value+"<br>"+
//						"도로명 주소:"+i_roadAddress.value+"<br>"+
//						"[지번 주소:"+i_jibunAddress.value+"]<br>"+
//								  i_namujiAddress.value;
	
//	delivery_message=i_delivery_message.value;
	
	var p_order_goods_id=document.getElementById("p_order_goods_id");
	var p_order_goods_title=document.getElementById("p_order_goods_title");
	var p_order_goods_qty=document.getElementById("p_order_goods_qty");
	var p_total_order_goods_qty=document.getElementById("p_total_order_goods_qty");
	var p_total_order_goods_price=document.getElementById("p_total_order_goods_price");
	var p_orderer_name=document.getElementById("p_orderer_name");
//	var p_receiver_name=document.getElementById("p_receiver_name");
//	var p_delivery_method=document.getElementById("p_delivery_method");
//	var p_receiver_hp_num=document.getElementById("p_receiver_hp_num");
//	var p_receiver_tel_num=document.getElementById("p_receiver_tel_num");
//	var p_delivery_address=document.getElementById("p_delivery_address");
//	var p_delivery_message=document.getElementById("p_delivery_message");
//	var p_gift_wrapping=document.getElementById("p_gift_wrapping");	
	var p_pay_method=document.getElementById("p_pay_method");
	
	p_order_goods_id.innerHTML=goods_id;
	p_order_goods_title.innerHTML=goods_title;
	p_total_order_goods_qty.innerHTML=total_order_goods_qty+"개";
	p_total_order_goods_price.innerHTML=total_order_goods_price+"원";
	p_orderer_name.innerHTML=orderer_name;
//	p_receiver_name.innerHTML=receiver_name;
//	p_delivery_method.innerHTML=delivery_method;
//	p_receiver_hp_num.innerHTML=receiver_hp_num;
//	p_receiver_tel_num.innerHTML=receiver_tel_num;
//	p_delivery_address.innerHTML=delivery_address;
//	p_delivery_message.innerHTML=delivery_message;
//	p_gift_wrapping.innerHTML=gift_wrapping;
	p_pay_method.innerHTML=pay_method;
	imagePopup('open');
}
*/

var goods_id="";
var goods_title="";
var goods_fileName="";

var order_goods_qty
var each_goods_price;
var total_order_goods_price;
var total_order_goods_qty;
var orderer_name;
//var receiver_name

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

var final_total_oder_price;
//가장 마지막 최종결제하기  결제정보를 넘기는 곳 
function fn_process_pay_order(){
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
console.log("최종결제하기");
var r_pay_method  =  document.form_order.pay_method;
var point_used = document.getElementById("point_used").value;
console.log("point_used"+point_used);
	for(var i=0; i<r_pay_method.length;i++){
	  if(r_pay_method[i].checked==true){
		  pay_method=r_pay_method[i].value
		  if(pay_method=="신용카드"){
			var i_card_com_name=document.getElementById("card_com_name");
			var i_card_num1=document.getElementById("card_num1");
			var i_card_num2=document.getElementById("card_num2");
			var i_card_num3=document.getElementById("card_num3");
			//var i_card_number=document.getElementById("card_number");
			var i_card_expired_m=document.getElementById("card_expired_m");
			var i_card_expired_y=document.getElementById("card_expired_y");
			
			card_com_name=i_card_com_name.value;
			card_num1=i_card_num1.value;
			card_num2=i_card_num2.value;
			card_num3=i_card_num3.value;
			
			card_number=card_num1+"-"+card_num2+"-"+card_num3;
			card_expired_m=i_card_expired_m.value;
			card_expired_y=i_card_expired_y.value;
		  }else if(pay_method=="휴대폰결제"){
			var i_pay_hp_com=document.getElementById("pay_hp_com");
			var i_pay_hp1=document.getElementById("pay_hp1");
			var i_pay_hp2=document.getElementById("pay_hp2");
			var i_pay_hp2=document.getElementById("pay_hp3");
			pay_hp1=i_pay_hp1.value;
			pay_hp2=i_pay_hp2.value;
			pay_hp3=i_pay_hp3.value;
			
			pay_hp_com=i_pay_hp_com.value;
			pay_hp_num=i_pay_hp1+"-"+i_pay_hp2+"-"+i_pay_hp3;
			
		  } else if(pay_method=="무통장입금") {
			  var i_random_account=document.getElementById("h_random_account");
			  random_account=i_random_account.value;
		  }//end if
		  break;
	  }// end for
	}
	
	alert("최종 결제하기"); //이 부분을 먼저 처리해줘야함 
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
    console.log("point_used"+point_used);
    //console.log(""+);
    //console.log(""+);
    //console.log(""+);
    //console.log(""+);
    ///console.log(""+);
    
    /*
  i_pay_method.value=pay_method;
     i_random_account.value=random_account;
     i_card_com_name.value=card_com_name;
     i_card_number.value=card_number;
     i_card_expired_m.value=card_expired_m;
     i_card_expired_y.value=card_expired_y;
      i_pay_hp_com.value=pay_hp_com;
     i_pay_hp_num.value=pay_hp_num;
     i_order_total_price.value=40000;
     i_point_used.value=point_used;
     */
    
    //더미데이터 넣은부분
   
    i_pay_method.value=pay_method;
    i_random_account.value="00000000";
    i_card_com_name.value="신한";
    i_card_number.value="000-0999";
    i_card_expired_m.value="09";
    i_card_expired_y.value="22";    
    i_pay_hp_com.value="SKT";
    i_pay_hp_num.value="010-000-0000";
    i_order_total_price.value=4000;
    i_point_used.value=1000;
    
  	//pay_hp_com
    //pay_hp_num
    
    
    /*
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
//	imagePopup('close');
}


/*
//적립
function getpoint(){
	var getjuklip = Number($('#_jucklip').val())- Number($('#discount_juklip').val());
	var formObj = document.createElement("form"); 
	form.setAttribute("charset", "UTF-8");
    form.setAttribute("method", "Post");  //Post 방식
    form.setAttribute("action", "${contextPath}/member/getpoint.do"); //요청 보낼 주소

	//$reciever_juklip.id=reciever_jucklip;
	//$reciever_juklip.value=getjuklip;
	//formObj.method="post";
	//formObj.action="${contextPath}/member/getpoint.do";
    //formObj.submit();
    
    var reciever_juklip= document.createElement("input");

    reciever_juklip.setAttribute("type", "hidden");
    reciever_juklip.setAttribute("name", "reciever_juklip");
    reciever_juklip.setAttribute("value", getjuklip);

    form.appendChild(reciever_juklip);
    document.body.appendChild(form);

    form.submit();
}
*/
function howmuch(){
	var juklip =  Number($('#discount_juklip').val());
	var yechi=  Number($('#discount_yechi').val());
	var sangpum= Number($('#discount_sangpum').val());
	var okcashbag=Number($('#discount_okcashbag').val());
	var coupon= Number($('#discount_coupon').val());
	var total_order_price= Number($('#total_order_price').val());
	var total_delivery_price= Number($('#total_delivery_price').val());
	var discount = juklip+yechi+sangpum+okcashbag+coupon;
	var final_price= total_order_price-discount+total_delivery_price;
	return final_price;
}
//할인
function usepoint(){
	var juklip =  Number($('#discount_juklip').val());
	var yechi=  Number($('#discount_yechi').val());
	var sangpum= Number($('#discount_sangpum').val());
	var okcashbag=Number($('#discount_okcashbag').val());
	var coupon= Number($('#discount_coupon').val());
	var total_order_price= Number($('#total_order_price').val());
	var total_delivery_price= Number($('#total_delivery_price').val());
	var discount = juklip+yechi+sangpum+okcashbag+coupon;
	var final_price= total_order_price-discount+total_delivery_price;
	howmuch(final_price);
	discount = Intl.NumberFormat().format(discount);
	final_price =Intl.NumberFormat().format(final_price);
	
	document.getElementById("p_result").innerHTML=discount+"원";
	document.getElementById("finalprice").innerHTML=final_price+"원";
	fianl_total_sales_price = final_price;
	
	var formObj = document.createElement("form"); 
	form.setAttribute("charset", "UTF-8");
    form.setAttribute("method", "Post");  //Post 방식
    form.setAttribute("action", "${contextPath}/member/getpoint.do"); //요청 보낼 주소

	//$reciever_juklip.id=reciever_jucklip;
	//$reciever_juklip.value=getjuklip;
	//formObj.method="post";
	//formObj.action="${contextPath}/member/getpoint.do";
    //formObj.submit();
    
    var reciever_juklip= document.createElement("input");

    reciever_juklip.setAttribute("type", "hidden");
    reciever_juklip.setAttribute("name", "reciever_juklip");
    reciever_juklip.setAttribute("value", getjuklip);

    form.appendChild(reciever_juklip);
    document.body.appendChild(form);

    form.submit();
}	

</script>
</head>
<body>
	<H1>1.주문확인</H1>
<form  name="form_order">	
	<table class="list_view">
		<tbody align=center>
			<tr style="background: #33ff00">
				<td colspan=2 class="fixed">주문상품명</td>
				<td>예약일</td>
				<td>수량</td>
				<td>주문금액</td>
				<td>예상적립금</td>
				<td>주문금액합계</td>
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
					     <a href="${pageContext.request.contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">${item.goods_title }</A>
					      <input   type="hidden" id="h_goods_title" name="h_goods_title" value="${item.goods_title }" />
					  </h2>
					</td>
					<td> <!-- 이거 넘겨줄곳 필요할듯 input hidden이나  -->
					${item.goods_ticket_date}
					</td>
					<td>
					  <h2>${item.order_goods_qty }개<h2> 
					    <input   type="hidden" id="h_order_goods_qty" name="h_order_goods_qty" value="${item.order_goods_qty}" />
					</td>
					<!-- 주문금액 -->
					
					<td>
				
					<fmt:formatNumber value="${item.goods_sales_price}" var="goodssales_price" pattern="#,###"/>
					<h2>${goodssales_price}원</h2>
					</td>
					
					<td>
						<fmt:formatNumber value="${item.goods_point}" var="point" pattern="#,###"/>
						<h2>${point}원</h2><!-- 포인트-->
					</td>
			<!-- 총주문금액 -->
					<td>
					<fmt:formatNumber value="${item.goods_sales_price*item.order_goods_qty}" var="sales_qty_price" pattern="#,###"/>
					  <h2>${sales_qty_price}원</h2>
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

	<div >
	  <br><br>
	   <h2>주문고객</h2>
		 <table>
		   <tbody>
			 <tr class="dot_line">
				<td ><h2>이름</h2></td>
				<td>
				 <input  type="text" value="${orderer.member_name}" id="h_orderer_name" size="15" />
				</td>
			  </tr>
			  <tr class="dot_line">
				<td ><h2>핸드폰</h2></td>
				<td>
				 <input  type="text" value="${orderer.hp1}-${orderer.hp2}-${orderer.hp3}" size="15" />
				</td>
			  </tr>
			  <tr class="dot_line">
				<td ><h2>이메일</h2></td>
				<td>
				 <input  type="text" value="${orderer.email1}@${orderer.email2}" size="15" />
				</td>
			  </tr>
			 
		   </tbody>
		</table>
	</div>
	<div class="clear"></div>
	<br>
	<br>
	<br>


	<H1>3.할인 정보</H1>
	<div class="detail_table">
		<table>
		
			<tbody>
				<tr class="dot_line">
					<td width=100>
						적립금
						<button type="button" id="use_point_all">모두사용</button>					
					</td> 
					<td><input id="point_used" type="number" size="10" min="0" max="${orderer.member_point}"/>원/${orderer.member_point}원
						&nbsp;&nbsp;&nbsp; <input type="checkbox" id="ch_point_used" class="discountBox" onclick=""/> 사용하기</td>
						<!-- 모두사용하기 누르면 자동으로 값이 전체돈으로 입력되도록해야한다  -->
						
				</tr>
				<!--  
				<tr class="dot_line">
					<td>예치금</td>
					<td><input id="discount_yechi" type="text" size="10" />원/1000원
						&nbsp;&nbsp;&nbsp; <input type="checkbox" /> 모두 사용하기</td>
				</tr>
				-->
				<tr class="dot_line">
					<td>상품권 전환금</td>
					<td cellpadding="5"><input id="discount_sangpum" type="text"
						size="10" />원/0원 &nbsp;&nbsp;&nbsp; 
						<input type="checkbox" id="ch_discount_sangpum" class="discountBox" onclick=""/> 
						사용하기</td>
				</tr>
				<tr class="dot_line">
					<td>OK 캐쉬백 포인트</td>
					<td cellpadding="5"><input id="discount_okcashbag" type="text"
						size="10" />원/0원 &nbsp;&nbsp;&nbsp; 
						<input type="checkbox" id="ch_discount_okcashbag" class="discountBox" onclick=""/> 
						사용하기</td>
				</tr>
				<tr class="dot_line">
					<td>쿠폰할인</td>
					<td cellpadding="5"><input id="discount_coupon" type="text"
						size="10" />원/0원 &nbsp;&nbsp;&nbsp; 
						<input type="checkbox"  id="ch_discount_coupon" class="discountBox" onclick=""/> 
						사용하기</td>
				</tr>
			</tbody>
			<!-- 
			<input type="button" onclick="usepoint()" value="할인받기"/> -->
		</table>
	</div>
	<div class="clear"></div>

	<br>
	<table width=80% class="list_view" style="background: #ccffff">
		<tbody>
			<tr align=center class="fixed">
				<td class="fixed">총 상품수</td>
				<td>총 상품금액</td>
				<td></td>
				<td>총 할인 금액</td>
				<td></td>
				<td>최종 결제금액</td>
			</tr>
			<tr cellpadding=40 align=center>
				<td id="">
					<p id="p_totalNum">${total_order_goods_qty}개</p> 
					<input id="h_total_order_goods_qty" type="hidden" value="${total_order_goods_qty}" />
				</td>
				
		<!-- 총상품금액 -->		
				<td>
					<fmt:formatNumber value="${total_order_price}" var="totalorder_price" pattern="#,###"/>
					<p id="p_totalPrice">${totalorder_price}원</p> <input
					id="h_totalPrice" type="hidden" value="${total_order_price}" />
				</td>
				<!--  플러스버튼 
				<td><IMG width="25" alt=""
					src="${pageContext.request.contextPath}/resources/image/plus.jpg"></td>
			-->
				<td>
			
				<img width="25" alt="" 	src="${pageContext.request.contextPath}/resources/image/minus.jpg"></td>
		<!-- 총할인액 -->
				<td>
					<p id="p_totalDiscount">0
					<!--<fmt:formatNumber value="${total_discount_price}" var="tdiscountprice" pattern="#,000"/>
					${tdiscountprice}원--> 
					<div id="p_result"></div>
					
					</p>
					<input id="h_total_sales_price" type="hidden" value="${total_discount_price}" />
				</td>
				
				<td><img width="25" alt="" src="${pageContext.request.contextPath}/resources/image/equal.jpg"></td>
		<!--최종 결제액 -->	
				<td>
					<p id="p_final_totalPrice">
					<!--<fmt:formatNumber value="${final_total_order_price}" var="final_total_order_price" pattern="#,###"/>
						--><font size="15">${totalorder_price}원 </font>
						
						<div id="finalprice"></div>
					</p> <input id="h_final_total_Price" type="hidden" value="${final_total_order_price}" />
				</td>
			</tr>
		</tbody>
	</table>
   <div class="clear"></div>
	<br>
	<br>
	<br>
	<h1>4.결제정보</h1>
	<div class="detail_table">
		<table>
			<tbody>
				<tr >
					<td>
					   <input type="radio" id="pay_method" name="pay_method" value="신용카드"   onClick="fn_pay_card()" checked>신용카드 &nbsp;&nbsp;&nbsp; 
					<input type="radio" id="pay_method" name="pay_method" value="휴대폰결제" onClick="fn_pay_phone()">휴대폰 결제 &nbsp;&nbsp;&nbsp;
					   <input type="radio" id="pay_method" name="pay_method" value="무통장입금" onClick="fn_random_account()">무통장 입금 &nbsp;&nbsp;&nbsp;
					</td>
				</tr>
				<tr >
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
					
					<!-- 
					var pay_method;
var random_account;
var card_com_name;
var card_number;
var card_expired_m;
var card_expired_y;
var pay_hp_num;
var pay_hp_com;
					 -->
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
	<center>
		<br>
		<br> <!--  <a href="javascript:fn_show_order_detail();">--> 
		<img width="125" alt="" src="${contextPath}/resources/image/btn_gulje.jpg">
		<br> <input name="btn_process_pay_order" type="button" onClick="fn_process_pay_order()" value="최종결제하기">
		</a> <a href="${contextPath}/main/main.do"> 
		   <img width="75" alt="" src="${contextPath}/resources/image/btn_shoping_continue.jpg">
		</a>
	
<div class="clear"></div>		
<!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다.-->
<!--  	<div id="layer" style="visibility:hidden">
		 
		<div id="popup_order_detail">
			 팝업창 닫기 버튼 
			<a href="javascript:" onClick="javascript:imagePopup('close', '.layer01');">
			 <img  src="${contextPath}/resources/image/close.png" id="close" />
			</a> 
			<br/> 
			  <div class="detail_table">
			  <h1>최종 주문 사항</h1>
			<table>
				<tbody align=left>
				 	<tr>
					  <td width=200px>
					      주문상품번호:
					 </td>
					 <td>
						 <p id="p_order_goods_id"> 주문번호 </p>    
					 </td>
				   </tr>
				   <tr>
					  <td width=200px>
					      주문상품명:
					 </td>
					 <td>
						  <p id="p_order_goods_title"> 주문 상품명 </p>    
					 </td>
				   </tr>
				   <tr>
					  <td width=200px>
					      주문상품개수:
					 </td>
					 <td>
						  <p id="p_total_order_goods_qty"> 주문 상품개수 </p>    
					 </td>
				   </tr>
				   <tr>
					  <td width=200px>
					     주문금액합계:
					 </td>
					 <td >
					      <p id="p_total_order_goods_price">주문금액합계</p>
					 </td>
				   </tr>
					<tr>
					  <td width=200px>
					     주문자:
					 </td>
					 <td>
					      <p id="p_orderer_name"> 주문자 이름</p>
					 </td>
				   </tr>
				   <tr>
					  <td width=200px>
					     받는사람:
					 </td>
					 <td>
					      <p id="p_receiver_name">받는사람이름</p>
					 </td>
				   </tr>
				   <tr>
					 
				   </tr>
				  
				   <tr>
					  <td width=200px>
					     결제방법:
					 </td>
					 <td align=left>
					      <p id="p_pay_method">결제방법</p>
					 </td>
				   </tr>
				   <tr>
				    <td colspan=2 align=center>
				    <input  name="btn_process_pay_order" type="button" onClick="fn_process_pay_order()" value="최종결제하기">
				    </td>
				   </tr>
				</tbody>
				</table>
			</div>
			<div class="clear"></div>	
			<br> 
			-->
			
			
			
			