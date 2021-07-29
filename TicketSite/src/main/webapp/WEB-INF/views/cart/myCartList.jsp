<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="myCartList"  value="${cartMap.myCartList}"  />
<c:set var="myGoodsList"  value="${cartMap.myGoodsList}"  />
<c:set  var="totalGoodsNum" value="0" />  <!--주문 개수 -->

<c:set var="totalGoodsPrice" value="0"/> <!-- 정가*수량 총 합 -->
<c:set var="totalSalesPrice" value="0"/> <!-- 할인가*수량 총합 -->
<c:set var="totalDiscount" value="0"/> <!-- 할인된 금액 총합  -->

<head>
<style> 




table.list_view tr:nth-child(odd) {
  background-color: #f2f2f2;
}
.plusminus {
  background-color: #a1d5ff; 
  border: none;
  color: white;
  padding: 5px 10px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
}

input {
	font-size:25px;
}

table.total_view {
	background-color: #f2f2f2;
	float:right;
	 border: 5px solid #444444;
	 padding: 30px;
	 font-size: 35px;
}

table.total_view td{
 	padding:10px;
}

/*이부분은 나중에 main.css에 붙여달라고 하기 버튼부분 다 */
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
	color: rgb(255, 0, 0);
	font-family: 'NanumBarunGothic', 'sans-serif';
	font-size: 1.2em; 
	font-weight: bold;
}
button[name=total]{
	width : 150px;
	height : 40px;
}

</style>

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js"></script>  
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">


//체크박스 관련 처리부분-하단 금액테이블 계산 + 전체선택/해제 +부분선택/해제 + 여기도 하나만일때랑 나눠져야 한다 
//1개일때랑 나눠서 처리 





$(document).ready(function(){
$("input[type=checkbox]").change(function() {
	var checked_goods=document.frm_order_all_cart.checked_goods; //체크박스 받아옴
	var goods_price= document.frm_order_all_cart.h_goods_price; //정가 
	var goods_sales_price=document.frm_order_all_cart.h_goods_sales_price; //판매가 
	var cart_goods_qty=document.frm_order_all_cart.cart_goods_qty; //수량
	

	var h_totalGoodsPrice=document.frm_order_all_cart.h_totalGoodsPrice; //총상품금액 (정가)
	var h_totalSalesPrice=document.frm_order_all_cart.h_totalSalesPrice; //총 구매금액(판매가)
		
	//html에서 받아온 객체는 변수이름 그대로 써준다 
		//./////////////////////////////////////////////
		///////이부분 다른데랑 변수 통일시켜야 된다ㅠㅠㅠㅠ checked_goods 도 바꿀까봐 check_goods나 goods_box 이런거로 
	var goodsPrice; //자바스크립트내에서 통용되는 변수
	var salesPrice;
	var goodsQty;

	var totalGoodsPrice=0; //총합(정가*수량) dadsdsdsdsadsdadsdadasdsdadadasdasd
	var totalSalesPrice=0; //총합(판매가*수량)  --결제금액 
	var totalDiscount=0; //총할인되는 금액

	var plusButton = document.getElementsByName("plus");
	var minusButton = document.getElementsByName("minus");
if(checked_goods.length>1){	
	for(var i=0; i<checked_goods.length;i++){ //한개만 체크됐을때랑 나눠서 해줘야함 		
		if(checked_goods[i].checked==true){
			goodsPrice=goods_price[i].value;
			salesPrice=goods_sales_price[i].value; //위에서 정의된거랑은 쓰임이 좀 달라야 되니까ㅇㅇ 변수명 같은거 반복하니까 꼬임 
			goodsQty=cart_goods_qty[i].value; 
			console.log("goods_price"+salesPrice+"typeof"+typeof salesPrice);
			console.log("cart_goods_qty"+goodsQty+"typeof"+typeof goodsQty);
			totalGoodsPrice=totalGoodsPrice+parseInt(goodsPrice)*parseInt(goodsQty);
			totalSalesPrice=totalSalesPrice+parseInt(salesPrice)*parseInt(goodsQty);
			totalDiscount=totalGoodsPrice-totalSalesPrice; //총 할인금액 구하는 건데 직접 계산해서 구해줘야하는지 생각해보기 
			console.log(totalGoodsPrice);
			console.log("체크됨"+checked_goods[i].checked+i);
			plusButton[i].disabled=false;
			minusButton[i].disabled=false;
		} else {
			console.log("체크안됨"+checked_goods[i].checked+i);
			plusButton[i].disabled=true;  //체크박스 해제되면 그제품 수량버튼도 비활성화
			minusButton[i].disabled=true;
		}
	}
}
else{
	if(checked_goods.checked==true){
		console.log("상품이 하나일때");
		goodsPrice=goods_price.value;
		salesPrice=goods_sales_price.value; //위에서 정의된거랑은 쓰임이 좀 달라야 되니까ㅇㅇ 변수명 같은거 반복하니까 꼬임 
		goodsQty=cart_goods_qty.value;
		totalGoodsPrice=totalGoodsPrice+parseInt(goodsPrice)*parseInt(goodsQty);
		totalSalesPrice=totalSalesPrice+parseInt(salesPrice)*parseInt(goodsQty);
		totalDiscount=totalGoodsPrice-totalSalesPrice;
		plusButton.disabled=false;
		minusButton.disabled=false;
	} else {
		plusButton.disabled=true;  //체크박스 해제되면 그제품 수량버튼도 비활성화
		minusButton.disabled=true;
	}
}

	h_totalGoodsPrice.value=totalGoodsPrice //총상품금액 (정가)
	h_totalSalesPrice.value=totalSalesPrice 
	
	//숫자 #,### 포맷팅
	totalGoodsPrice=Intl.NumberFormat().format(totalGoodsPrice);
	totalSalesPrice=Intl.NumberFormat().format(totalSalesPrice);
	totalDiscount=Intl.NumberFormat().format(totalDiscount);
		
	document.getElementById("p_totalGoodsPrice").innerHTML=totalGoodsPrice+"원";
	document.getElementById("p_totalSalesPrice").innerHTML=totalSalesPrice+"원";
	document.getElementById("p_totalDiscount").innerHTML=totalDiscount+"원";

});
	
	$("#checkall").click(function(){		
        //클릭되었으면
        if($("#checkall").prop("checked")){
            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
            $("input[type=checkbox]").prop("checked",true);

            
            //클릭이 안되있으면
        }else{
            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
        	 $("input[type=checkbox]").prop("checked",false);
            //0으로 다 만들어주기 
        	 document.getElementById("p_totalGoodsPrice").innerHTML=0;
        	 document.getElementById("p_totalDiscount").innerHTML=0;
        	 document.getElementById("p_totalSalesPrice").innerHTML=0;
            
        }
        checkedGoods = $("input[class=checked_goods]:checked").length;
        document.getElementById("checkedGoods").innerHTML=checkedGoods;
        //체크박스 개수 넘겨줌 
	});
	//부분선택/전체해제 
	$(".checked_goods").change(function() {  //prop으로 썼었다 change로 해도 일단 선택은 똑같이 됨 
		if($("input[class=checked_goods]:checked").length==$("input[class=checked_goods]").length) {
			$("#checkall").prop("checked",true);
			
		} else {			
			$("#checkall").prop("checked",false);
		}
		
		//체크박스중에 checked된 것들 개수
		checkedGoods = $("input[class=checked_goods]:checked").length;
		document.getElementById("checkedGoods").innerHTML=checkedGoods;
		
		
	});
	

 
}); //체크박스 관련 처리 끝 

	

function plusone(goods_id,goods_price,goods_sales_price,index) { 
	
	console.log(index + typeof index);
	
	var length=document.frm_order_all_cart.cart_goods_qty.length;
	var cart_goods_qty;
	var priceXqty;

	if(length>1 ){ 
		console.log("여러개");
		cart_goods_qty=document.frm_order_all_cart.cart_goods_qty[index];
		cart_goods_qty.value++;
		
		priceXqty=document.frm_order_all_cart.priceXqty[index];
		//priceXqty.value=goods_sales_price*cart_goods_qty.value;
		console.log("인데스값 :" + cart_goods_qty.value);

	}else{
		cart_goods_qty=document.frm_order_all_cart.cart_goods_qty;
		cart_goods_qty.value++;
		
		priceXqty=document.frm_order_all_cart.priceXqty;
		//priceXqty.value=goods_sales_price*cart_goods_qty.value;
		console.log("1이면 아니면 더작은거 +"); 
	}
	//합계, 총상품금액, 총할인금액, 최종결제금액 

	var totalGoodsPrice=document.frm_order_all_cart.h_totalGoodsPrice; //총상품금액 (정가)
	var totalSalesPrice=document.frm_order_all_cart.h_totalSalesPrice; //총 구매금액(판매가)
		
	cart_goods_qty=parseInt(cart_goods_qty.value); //수량 숫자로 변환
	console.log("totalGoodsPrice.value"+totalGoodsPrice.value+typeof totalGoodsPrice.value);
	console.log(goods_price+typeof goods_price);
	totalGoodsPrice.value=parseInt(totalGoodsPrice.value)+goods_price;
	totalSalesPrice.value=parseInt(totalSalesPrice.value)+goods_sales_price;
	var totalDiscount=totalGoodsPrice.value-totalSalesPrice.value;
	
	console.log("총 상품금액"+totalGoodsPrice.value);  
	priceXqty.value=Intl.NumberFormat().format(goods_sales_price*cart_goods_qty); //합계는 판매가*수량
	
	totalGoodsPrice=Intl.NumberFormat().format(totalGoodsPrice.value);
	totalSalesPrice=Intl.NumberFormat().format(totalSalesPrice.value);
	totalDiscount=Intl.NumberFormat().format(totalDiscount);
		
	
	document.getElementById("p_totalGoodsPrice").innerHTML=totalGoodsPrice+"원"
	document.getElementById("p_totalSalesPrice").innerHTML=totalSalesPrice+"원"
	document.getElementById("p_totalDiscount").innerHTML=totalDiscount+"원"

	console.log("수량"+cart_goods_qty);
	console.log("더하기");
	
	$.ajax({
		type : "post",
		async : false, //false인 경우 동기식으로 처리한다.
		url : "${contextPath}/cart/modifyCartQty.do",
		data : {
			goods_id:goods_id,
			cart_goods_qty:cart_goods_qty
		},
		
		success : function(data, textStatus) {
			//alert(data);
			if(data.trim()=='modify_success'){
				//alert("수량을 변경했습니다!!");	
			}else{
				alert("다시 시도해 주세요!!");	
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

function minusone(goods_id,goods_price,goods_sales_price,index) { 
		
	var length=document.frm_order_all_cart.cart_goods_qty.length;
	var cart_goods_qty;
	var priceXqty;
	var base = 0;
	
	if(length>1){ 
		cart_goods_qty=document.frm_order_all_cart.cart_goods_qty[index];
		if(cart_goods_qty.value>1) {
			cart_goods_qty.value--;	
			base = 1;
			}
		
		priceXqty=document.frm_order_all_cart.priceXqty[index];
		priceXqty.value=goods_sales_price*cart_goods_qty.value;
		console.log("인덱스값 :" + cart_goods_qty.value);

	}else{ //상품이 하나일때 
		cart_goods_qty=document.frm_order_all_cart.cart_goods_qty;
		if(cart_goods_qty.value>1) {
			cart_goods_qty.value--;	
			base = 1;
			}
		priceXqty=document.frm_order_all_cart.priceXqty;
		priceXqty.value=goods_sales_price*cart_goods_qty.value;
		console.log("1이면 아니면 더작은거 +"); 
	}
	//합계, 총상품금액, 총할인금액, 최종결제금액 

	var totalGoodsPrice=document.frm_order_all_cart.h_totalGoodsPrice; //총상품금액 (정가)
	var totalSalesPrice=document.frm_order_all_cart.h_totalSalesPrice; //총 구매금액(판매가)
		
	cart_goods_qty=parseInt(cart_goods_qty.value); //수량 숫자로 변환
	console.log("totalGoodsPrice.value"+totalGoodsPrice.value+typeof totalGoodsPrice.value);
	console.log(goods_price+typeof goods_price);
	totalGoodsPrice.value=parseInt(totalGoodsPrice.value)-goods_price*base;
	totalSalesPrice.value=parseInt(totalSalesPrice.value)-goods_sales_price*base;
	var totalDiscount=totalGoodsPrice.value-totalSalesPrice.value;
	
	console.log("총 상품금액"+totalGoodsPrice.value); 
	priceXqty.value=Intl.NumberFormat().format(goods_sales_price*cart_goods_qty); //합계는 판매가*수량
	
	totalGoodsPrice=Intl.NumberFormat().format(totalGoodsPrice.value);
	totalSalesPrice=Intl.NumberFormat().format(totalSalesPrice.value);
	totalDiscount=Intl.NumberFormat().format(totalDiscount);
	
	
	
	document.getElementById("p_totalGoodsPrice").innerHTML=totalGoodsPrice+"원"
	document.getElementById("p_totalSalesPrice").innerHTML=totalSalesPrice+"원"
	document.getElementById("p_totalDiscount").innerHTML=totalDiscount+"원"

	
	console.log("수량"+cart_goods_qty);
	console.log("빼기");
	
	$.ajax({
		type : "post",
		async : false, //false인 경우 동기식으로 처리한다.
		url : "${contextPath}/cart/modifyCartQty.do",
		data : {
			goods_id:goods_id,
			cart_goods_qty:cart_goods_qty
		},
		
		success : function(data, textStatus) {
			//alert(data);
			if(data.trim()=='modify_success'){
				//alert("수량을 변경했습니다!!");	
			}else{
				alert("다시 시도해 주세요!!");	
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


	

//위시리스트
function add_wish(goods_id){
	console.log(goods_id);
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
				imagePopup('open', layer);	
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

function imagePopup(type,layer) {
	console.log(type,layer)
	if (type == 'open') {
		if(layer == 'layer'){
			$('#layer').attr('style', 'visibility:visible');
			$('#layer').height(jQuery(document).height());
		}
		else if(layer == 'layer2'){
			jQuery('#layer2').attr('style', 'visibility:visible');
			jQuery('#layer2').height(jQuery(document).height());
		}
	}//type if

	else if (type == 'close') {
		if(layer == 'layer'){
			jQuery('#layer').attr('style', 'visibility:hidden');
		}
		else if(layer== 'layer2'){
			jQuery('#layer2').attr('style', 'visibility:hidden');
		}
	}//type elseif
}//function

 
function delete_cart_goods(cart_id) {
	var cart_id=Number(cart_id);
	var formObj=document.createElement("form");
	var i_cart = document.createElement("input");
	i_cart.name="cart_id";
	i_cart.value=cart_id;
	
	formObj.appendChild(i_cart);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/cart/removeCartGoods.do";
    formObj.submit();
}


function fn_order_each_goods(goods_id,goods_title,goods_sales_price,fileName,goods_point,goods_ticket_date,index) {
	console.log("개별주문 함수 ");
	//로그인확인
	var isLogOn = document.getElementById("isLogOn").value;
	if(isLogOn == 'false'||isLogOn == ''){
		alert("로그인 후 이용가능합니다.")
		location.href="${contextPath}/member/loginForm.do"
	}else{
	
	
	var length=document.frm_order_all_cart.cart_goods_qty.length;
	var cart_goods_qty;


	if(length>1 ){ 
		console.log("여러개");
		cart_goods_qty=document.frm_order_all_cart.cart_goods_qty[index];

		console.log("인데스값 :" + cart_goods_qty.value);
		console.log(typeof cart_goods_qty.value);

	}else{
		cart_goods_qty=document.frm_order_all_cart.cart_goods_qty;

		console.log("하나"+cart_goods_qty.value);
		console.log(typeof cart_goods_qty.value);
	}
	cart_goods_qty=cart_goods_qty.value;
	console.log("바깥인데스값 :" + cart_goods_qty);
	console.log(typeof cart_goods_qty);
	
	
	 var formObj=document.createElement("form");
	var i_goods_id = document.createElement("input"); 
    var i_goods_title = document.createElement("input");
    var i_goods_sales_price=document.createElement("input");
    var i_fileName=document.createElement("input");
    var i_order_goods_qty=document.createElement("input");
	var i_goods_ticket_date=document.createElement("input");
    var i_goods_point=document.createElement("input");
    
    i_goods_id.name="goods_id";
    i_goods_title.name="goods_title";
    i_goods_sales_price.name="goods_sales_price";
    i_fileName.name="goods_fileName";
    i_order_goods_qty.name="order_goods_qty";
    i_goods_ticket_date.name="goods_ticket_date";
    i_goods_point.name="goods_point";
    
    i_goods_id.value=goods_id;
    i_order_goods_qty.value=cart_goods_qty;
    i_goods_title.value=goods_title;
    i_goods_sales_price.value=goods_sales_price;
    i_fileName.value=fileName;
    i_goods_ticket_date.value=goods_ticket_date;
    i_goods_point.value=goods_point;
    
    formObj.appendChild(i_goods_id);
    formObj.appendChild(i_goods_title);
    formObj.appendChild(i_goods_sales_price);
    formObj.appendChild(i_fileName);
    formObj.appendChild(i_order_goods_qty);
    formObj.appendChild(i_goods_ticket_date);
    formObj.appendChild(i_goods_point);
    
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/order/orderEachGoods.do";
    formObj.submit();    
	}
}	 



function fn_order_all_cart_goods() {
	console.log("모두주문하기");
	
	//로그인확인
	var isLogOn = document.getElementById("isLogOn").value;
	if(isLogOn == 'false'||isLogOn == ''){
		alert("로그인 후 이용가능합니다.")
		location.href="${contextPath}/member/loginForm.do"
	}else{
		
	var order_goods_qty;
	var order_goods_id;
	var objForm=document.frm_order_all_cart;
	var cart_goods_qty=objForm.cart_goods_qty; //cart_goods_qty는 객체 -배열

	var checked_goods=objForm.checked_goods;
	var length=checked_goods.length;
	
	var _goods_ticket_date=objForm.goods_ticket_date; //이거자체가 배열 그냥 두면 알아서 넘어가려나?????
	var goods_point=objForm.goods_point;
	

	if(length>1){
		for(var i=0; i<length;i++){ //상품개수만큼 반복 
			if(checked_goods[i].checked==true){
				order_goods_id=checked_goods[i].value;   //checked_goods의 값이 goods_id
				order_goods_qty=cart_goods_qty[i].value;
				goods_ticket_date=_goods_ticket_date[i].value;
				cart_goods_qty[i].value=""; //이거는 왜 이렇게 지정해줘야할까 ??
				cart_goods_qty[i].value=order_goods_id+":"+order_goods_qty+":"+goods_ticket_date;
				//상품ID 랑 수량이랑 예약일을 합쳐서 배열로 만들어서 넘겨준다 

				
				console.log("수량"+cart_goods_qty[i].value);
				console.log(goods_ticket_date[i].value);
				//console.log(goods_ticket_date[i]);
				
			}
		}	
	}else{
		order_goods_id=checked_goods.value;
		order_goods_qty=cart_goods_qty.value;
		goods_ticket_date=_goods_ticket_date.value;
		cart_goods_qty.value=order_goods_id+":"+order_goods_qty+":"+goods_ticket_date;
		//alert(select_goods_qty.value);
	}
		
	objForm.method="post";
 	objForm.action="${contextPath}/order/orderAllCartGoods.do";
	objForm.submit();
	}
}




</script>
</head>
<body>
<br>
<h1>장바구니</h1>
<form name="frm_order_all_cart">
<table class="list_view">
<tbody align=center >
	<tr style="background:#2196F3; color:white;" >
		<td class="fixed" ><input type="checkbox" id="checkall" checked></td>
		<td colspan=2 class="fixed">상품명</td>
		<td>예약일</td>
		<td>정가</td>
		<td>판매가</td>
		<td>수량</td>
	</tr>
		<c:choose>
	    <c:when test="${ empty myCartList }">
	<tr>
		<td colspan=8 class="fixed">
			<font size="5"><strong>장바구니에 상품이 없습니다.</strong></font>
		</td>
    </tr>
	    </c:when>
		<c:otherwise>

<c:forEach var="item" items="${myGoodsList}" varStatus="idx">
	 <tr>
		<c:set var="cart_goods_qty" value="${myCartList[idx.index].cart_goods_qty}" />
		<c:set var="cart_id" value="${myCartList[idx.index].cart_id}" />
		<c:set var="goods_ticket_date" value="${myCartList[idx.index].goods_ticket_date }"/>
		<c:set var="discount_price" value="${item.goods_price*(item.goods_discount/100)}"/>
				
		<td>
			<input type="checkbox" class="checked_goods" name="checked_goods" checked  value="${item.goods_id}" >
		</td>
		<!-- 상품명 이미지 -->			
		<td class="goods_image">
			<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
				<img width="140" alt="" src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"  />
			</a>
		</td>
			<!-- 상품명 -->		
		<td>
			<h2>
				<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
				${item.goods_title}	 </a>
			</h2>
				
		</td>
		
		<td>   <!-- 예약일  -->
			<input type="hidden" id="goods_ticket_date" value="${goods_ticket_date }">
				 ${goods_ticket_date}	
		</td>
		<td class="price"><!-- 정가 -->  <!-- article table#list_view td.price css에 있음 -->
				<input type="hidden" id="h_goods_price" value="${item.goods_price}">
				<fmt:formatNumber value="${item.goods_price}" var="goodsprice" pattern="#,###"/>
				<span>${goodsprice}원</span><br>(${item.goods_discount}% 할인)
		</td>	
		<!-- 판매가 -->		
		<td class="price">
				<input type="hidden" id="h_goods_sales_price" value="${item.goods_sales_price}">
				<fmt:formatNumber value="${item.goods_sales_price}" var="discountedprice" pattern="#,###"/>
				<strong>
				      ${discountedprice}원
				</strong>
		</td>
 		<td>
 			<input type="button" value=" - " class="plusminus" name="minus" onclick="javascript:minusone(${item.goods_id},${item.goods_price},${item.goods_sales_price},${idx.index});">
 			<input type="text" name="cart_goods_qty" id="cart_goods_qty" readonly size="1" value="${cart_goods_qty}" >
 			<input type="button" value=" + " class="plusminus" name="plus" onclick="javascript:plusone(${item.goods_id},${item.goods_price},${item.goods_sales_price},${idx.index});">
 		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="2" align="left">
		   	 <button type="button" class="buy_btn" onclick="javascript:fn_order_each_goods('${item.goods_id}','${item.goods_title}','${item.goods_sales_price}','${item.goods_fileName}','${item.goods_point}','${goods_ticket_date }','${idx.index}');">주문하기</button>
			 <button type="button" class="cart_btn" onclick="javascript:add_wish('${item.goods_id}')">위시리스트</button>
			 <button type="button" class="cart_btn" onclick="javascript:delete_cart_goods('${cart_id}');">삭제</button>
		</td>
		<td colspan="4" align="right">
			<fmt:formatNumber var="priceXqty" value="${item.goods_sales_price*cart_goods_qty}"/>
			합계 : <input type="text" name="priceXqty" size=5 value="${priceXqty}" readonly style="border:0px none;background-color:transparent;"><br>
		</td>
	</tr>
	<c:set var="totalGoodsPrice" value="${totalGoodsPrice+item.goods_price*cart_goods_qty }" />
	<c:set var="totalGoodsNum" value="${totalGoodsNum+1}" />
	<c:set var="totalSalesPrice" value="${totalSalesPrice+item.goods_sales_price*cart_goods_qty}" />
	<c:set var="totalDiscount" value="${totalDiscount+discount_price*cart_goods_qty}" />
</c:forEach>
 </c:otherwise>
	</c:choose> 
	</tbody>
</table>
   <!-- 여기까지 위쪽 표  -->
   
     	
	<div class="clear"></div>
	<br>
	<br>
	<br>

<div class="clear"></div>
	<br>
<table  width=80%   class="list_view" style="background:#E6F2FF">
   <tbody>
   <tr align=center  class="fixed">
   		<td class="fixed">총 상품수 </td>
        <td>총 상품금액</td>
        <td>  </td>
        <td>총 할인 금액 </td>
        <td>  </td>
        <td>최종 결제금액</td>
    </tr>
    <tr cellpadding=40  align=center >
         <td>
         <p id="checkedGoods">${totalGoodsNum}</p>
         </td>
         <td>
           	<fmt:formatNumber  value="${totalGoodsPrice}" type="number" var="fmttotal_goods_price" pattern="#,###"/>
            <input id="h_totalGoodsPrice" type="hidden" value="${totalGoodsPrice}" />  
            <p id="p_totalGoodsPrice">${fmttotal_goods_price}원</p> <!-- 이거 숨기고 밑에거가 나오게 하는 방법도있다  -->
          </td>
          <td> 
    	       <font size="10px"><strong>-</strong></font>
          </td>
<!--총 할인금액 -->  
          <td>  
            <p id="p_totalDiscount"> 
            <fmt:formatNumber value="${totalDiscount}" var="tDiscountPrice" pattern="#,###"/>
                     ${tDiscountPrice}원
            </p>
            <input id="h_totalDiscount"type="hidden" value="${totalDiscount}" />
          </td>
          <td>  
   	      	 <font size="10px"><strong>=</strong></font>
          </td>
          <td><!--총판매가- 총할인금액 -->
	          <font size="7px"><p id="p_totalSalesPrice">
              <fmt:formatNumber  value="${totalGoodsPrice-totalDiscount}" type="number" var="total_price" pattern="#,###"/>
               ${total_price}원
              </p></font>
              <input id="h_totalSalesPrice" type="hidden" value="${totalGoodsPrice-totalDiscount}" />
          </td>
      </tr>
      </tbody>
</table>

   <div class="clear"></div>
	<br><br><br>
	<br><br><br>
   <div align="center">
    <button type="button" class="buy_btn" name="total" onclick="javascript:fn_order_all_cart_goods()">주문하기</button>
    <button type="button" class="cart_btn" name="total" onclick="javascript:history.back();">쇼핑계속하기</button>
   </div>   
   
  
</form>   

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

<input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}"/>
