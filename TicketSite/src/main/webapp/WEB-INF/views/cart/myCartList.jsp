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
<!-- 요 바로 밑에거는 꺼도 작동할거같음  -->
 <!-- 
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js"></script> 
  
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>-->
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

	var totalGoodsPrice=0; //총합(정가*수량) dasdsadsdadsdadasdsdadadasdasd
	var totalSalesPrice=0; //총합(판매가*수량)  --결제금액 
	var totalDiscount=0; //총할인되는 금액

	var plusButton = document.getElementsByName("plus");
	var minusButton = document.getElementsByName("minus");
	
//장바구니안에 상품이 여러개일때고 하나일때랑 나눠야 한다ㅠㅠ 근데 어케해 
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
		//hidden값도 다시 설정해준다 -> 포맷팅하기전에 넣어야 다른곳에서 불러다가 계산가능
	h_totalGoodsPrice.value=totalGoodsPrice //총상품금액 (정가)
	h_totalSalesPrice.value=totalSalesPrice //이게 통할까 내 의도는 hidden값 바꾸는건데 
	
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
		priceXqty.value=goods_sales_price*cart_goods_qty.value;
		console.log("인데스값 :" + cart_goods_qty.value);

	}else{
		cart_goods_qty=document.frm_order_all_cart.cart_goods_qty;
		cart_goods_qty.value++;
		
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
	totalGoodsPrice.value=parseInt(totalGoodsPrice.value)+goods_price;
	totalSalesPrice.value=parseInt(totalSalesPrice.value)+goods_sales_price;
	var totalDiscount=totalGoodsPrice.value-totalSalesPrice.value;
	
	console.log("총 상품금액"+totalGoodsPrice.value);  //10040
	//document.getElementById("p_priceXqty").innerHTML=priceXqty;
	priceXqty.value=goods_sales_price*cart_goods_qty; //합계는 판매가*수량
	
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
				alert("수량을 변경했습니다!!");	
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
	
	console.log("총 상품금액"+totalGoodsPrice.value);  //10040
	//document.getElementById("p_priceXqty").innerHTML=priceXqty;
	priceXqty.value=goods_sales_price*cart_goods_qty; //합계는 판매가*수량
	
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
				alert("수량을 변경했습니다!!");	
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


//체크박스랑 변수 겹치는거 아예 위칸에 몰아두는게 효율적일까 매번 정의하지말고

//change 함수 하나로 두고 그안에서 if button 눌리면 으로 처리가능한가??????

//plus minus 부분 처리  name으로 할지 		





 
/* 안먹혀 
$(document).ready(function(){
	$("input[id=cart_goods_qty]").onchange(function() {
		console.log("값바뀜");	
	}
}
	*/

	

/*되는 코드 -> 개수 넘겨주는 거까지 
var checkedGoods;
$(document).ready(function(){
	//전체선택/전체해제
	$("#checkall").click(function(){
        //클릭되었으면
        if($("#checkall").prop("checked")){
            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
            $("input[type=checkbox]").prop("checked",true);
            //클릭이 안되있으면
        }else{
            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
        	 $("input[type=checkbox]").prop("checked",false);
        }
        checkedGoods = $("input[class=checked_goods]:checked").length;
        document.getElementById("checkedGoods").innerHTML=checkedGoods;
        //체크박스 개수 넘겨줌 
        
	});
	//부분선택/전체해제 
	$(".checked_goods").click(function() {
		if($("input[class=checked_goods]:checked").length==$("input[class=checked_goods]").length) {
			$("#checkall").prop("checked",true);
		} else {
			$("#checkall").prop("checked",false);
		}
		checkedGoods = $("input[class=checked_goods]:checked").length;
		document.getElementById("checkedGoods").innerHTML=checkedGoods;
	});
 
}); */



//////////////////////여기까지 체크박스 되는 거 확인 완료 


//이부분은 일단 죽이고 + - 버튼 테스트해보기  -----------------이건 원래 있던 코드 
//수량변경까지 됨 일단 위에서 + - 버튼으로 바꿔보고 
/* function modify_cart_qty(goods_id,bookPrice,index){
	//alert(index);
   var length=document.frm_order_all_cart.cart_goods_qty.length;

   var _cart_goods_qty=0;
	if(length>1){ //카트에 제품이 한개인 경우와 여러개인 경우 나누어서 처리한다. 
		//이게필요가있을까 어차피 한번에 하나만 변경하는건데...????
		_cart_goods_qty=document.frm_order_all_cart.cart_goods_qty[index].value;	
		console.log("1보다 크면")
	}else{
		_cart_goods_qty=document.frm_order_all_cart.cart_goods_qty.value;
		console.log("1이면 아니면 더작은거 "); //이거 실행됨 어차피 지워도될듯
	}
		
	var cart_goods_qty=parseInt(_cart_goods_qty);
	//alert("cart_goods_qty:"+cart_goods_qty);
	console.log(cart_goods_qty);
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
				alert("수량을 변경했습니다!!");	
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
 */
 
function delete_cart_goods(cart_id){
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

//function fn_order_each_goods(goods_id,goods_title,goods_sales_price,fileName) {
	
//}

//인수로 넘어온건 디비에 저장되어있던 goods 정보들이고 / dom객체로 받는건 페이지에서 생성되거나 넘어온것들 
function fn_order_each_goods(goods_id,goods_title,goods_sales_price,fileName) {
	console.log("개별주문 함수 ");

	var cart_goods_qty=document.getElementById("cart_goods_qty").value; //이거 id로 받으면 안될것같..ㅠ 모르겠다 
	console.log(cart_goods_qty+typeof cart_goods_qty);
	var goods_ticket_date=document.getElementById("goods_ticket_date").value;
	console.log(goods_id+goods_title+goods_sales_price+fileName);
	
	//jquery 문서 버전 자체를 바꾸는게 나을듯 
	$.ajax({
		type : "post",
		async : false, //false인 경우 동기식으로 처리한다.
		url : "${contextPath}/order/orderEachGoods.do",
		data : {
			goods_id:goods_id,
			goods_title:goods_title,
			goods_sales_price:goods_sales_price,
			order_goods_qty:cart_goods_qty,
			goods_ticket_date:goods_ticket_date,
			goods_fileName:fileName
			
		},
		
		//텍스트는 나중에 modify 참조해서 만들거나...뭐 
		success : function(data, textStatus) {
			//alert(data);
			if(data.trim()=='modify_success'){
				alert("수량을 변경했습니다!!");	
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
	}); //end ajax	*/
}
 
 
 //(${item.goods_id},${item.goods_title},${item.goods_sales_price},${item.goods_fileName}
/* function fn_order_each_goods(goods_id,goods_title,goods_sales_price,fileName) {
	//goodsDetail 에서 따온거 일단 다른거 하나 여기 다시 하자 
	c
	
 var objForm=document.frm_order_all_cart;
	var cart_goods_qty=objForm.cart_goods_qty;
	//안되면 hidden으로 넘겨서 해보기 
	
	var order_goods_id=goods_id;
	var order_goods_qty=goods_sales_price;
		
	//var total_price,final_total_price; //없어도 실행되얗dsadsadsadsads
	var order_goods_qty=document.getElementById("cart_goods_qty");
		
	var formObj=document.createElement("form");
	var i_goods_id = document.createElement("input"); 
    var i_goods_title = document.createElement("input");
    var i_goods_sales_price=document.createElement("input");
    var i_fileName=document.createElement("input");
    var i_order_goods_qty=document.createElement("input");
    
    i_goods_id.name="goods_id";
    i_goods_title.name="goods_title";
    i_goods_sales_price.name="goods_sales_price";
    i_fileName.name="goods_fileName";
    i_order_goods_qty.name="order_goods_qty";
    
    i_goods_id.value=goods_id;
    i_order_goods_qty.value=Number(order_goods_qty);
    i_goods_title.value=goods_title;
    i_goods_sales_price.value=goods_sales_price;
    i_fileName.value=fileName;
    
    formObj.appendChild(i_goods_id);
    formObj.appendChild(i_goods_title);
    formObj.appendChild(i_goods_sales_price);
    formObj.appendChild(i_fileName);
    formObj.appendChild(i_order_goods_qty);

    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/order/orderEachGoods.do";
    formObj.submit(); 
	}	 */

//'${item.goods_id }','${item.goods_title }','${discounted_price}','${item.goods_fileName}');">
/*
function fn_order_each_goods(goods_id,goods_title,goods_sales_price,fileName){
	
	
	var total_price,final_total_price,_goods_qty;
	var order_goods_qty=document.getElementById("cart_goods_qty");
	
	_order_goods_qty=cart_goods_qty.value; //장바구니에 담긴 개수 만큼 주문한다.
	var formObj=document.createElement("form");
	var i_goods_id = document.createElement("input"); 
    var i_goods_title = document.createElement("input");
    var i_goods_sales_price=document.createElement("input");
    var i_fileName=document.createElement("input");
    var i_order_goods_qty=document.createElement("input");
    
    i_goods_id.name="goods_id";
    i_goods_title.name="goods_title";
    i_goods_sales_price.name="goods_sales_price";
    i_fileName.name="goods_fileName";
    i_order_goods_qty.name="order_goods_qty";
    .
    i_goods_id.value=goods_id;
    i_order_goods_qty.value=order_goods_qty;
    i_goods_title.value=goods_title;
    i_goods_sales_price.value=goods_sales_price;
    i_fileName.value=fileName;
    
    formObj.appendChild(i_goods_id);
    formObj.appendChild(i_goods_title);
    formObj.appendChild(i_goods_sales_price);
    formObj.appendChild(i_fileName);
    formObj.appendChild(i_order_goods_qty);

    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/order/orderEachGoods.do";
    formObj.submit();
    
} */

function fn_order_all_cart_goods(){
//	alert("모두 주문하기");
	var order_goods_qty;
	var order_goods_id;
	var objForm=document.frm_order_all_cart;
	var cart_goods_qty=objForm.cart_goods_qty;
	var h_order_each_goods_qty=objForm.h_order_each_goods_qty;
	var checked_goods=objForm.checked_goods;
	var length=checked_goods.length;
	
	
	//alert(length);
	if(length>1){
		for(var i=0; i<length;i++){
			if(checked_goods[i].checked==true){
				order_goods_id=checked_goods[i].value;
				order_goods_qty=cart_goods_qty[i].value;
				cart_goods_qty[i].value="";
				cart_goods_qty[i].value=order_goods_id+":"+order_goods_qty;
				//alert(select_goods_qty[i].value);
				console.log(cart_goods_qty[i].value);
			}
		}	
	}else{
		order_goods_id=checked_goods.value;
		order_goods_qty=cart_goods_qty.value;
		cart_goods_qty.value=order_goods_id+":"+order_goods_qty;
		//alert(select_goods_qty.value);
	}
		
 	objForm.method="post";
 	objForm.action="${contextPath}/order/orderAllCartGoods.do";
	objForm.submit();
}

</script>
</head>
<body>
<form name="frm_order_all_cart">
<table class="list_view">
<tbody align=center >
	<tr style="background:#33ff00" >
		<td class="fixed" ><input type="checkbox" id="checkall" checked></td>
		<td colspan=2 class="fixed">상품명</td>
		<td>예약일</td>
		<td>정가</td>
		<td>판매가</td>
		<td>수량</td>
		<td>합계</td>
		<td>주문</td>
	</tr>
		<c:choose>
	    <c:when test="${ empty myCartList }">
	<tr>
		<td colspan=8 class="fixed">
			<strong>장바구니에 상품이 없습니다.</strong>
		</td>
    </tr>
	    </c:when>
		<c:otherwise>

     
<c:forEach var="item" items="${myGoodsList}" varStatus="idx">
	 <tr>
		<c:set var="cart_goods_qty" value="${myCartList[idx.index].cart_goods_qty}" />
		<c:set var="cart_id" value="${myCartList[idx.index].cart_id}" />
		<c:set var="goods_ticket_date" value="${myCartList[idx.index].goods_ticket_date }"/>
		<!-- 할인율 -->

		<!-- 할인가  --> 
			
	
		<!-- 할인 -->		
		<c:set var="discount_price" value="${item.goods_price*(item.goods_discount/100)}"/>
				
				<!-- 구분 checkbox의 value는 무슨의미가 있나 넘어갈때 name이용해 넘ㅇ           함수안에 들어가는 qty 값은 나중에 다시 받아와야할거같기도 수량변화부분 반영해야됨-->    
		<td>
			<input type="checkbox" class="checked_goods" name="checked_goods" checked  value="${item.goods_id}" >
		</td>
				<!--  onClick="calGoodsPrice()"-->
					<!-- 상품명 이미지 -->
		<td class="goods_image">
			<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
			<img width="75" alt="" src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"  />
			</a>
		</td>
					<!-- 상품명 -->
		<td>
			<h2>
				<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">${item.goods_title}
				 </a>
			</h2>
					${item.goods_id }
					
		</td>
		<!-- /////////////////////////예매날짜 input 필요한지 생각해보기  -->		
				<td>   
				<input type="hidden" id="goods_ticket_date" value="${goods_ticket_date }">
				 ${goods_ticket_date }	
				</td>
				
				
				
		<td class="price">
				<input type="hidden" id="h_goods_price" value="${item.goods_price}">
				<fmt:formatNumber value="${item.goods_price}" var="goodsprice" pattern="#,###"/>
<!-- 금액출력을 위한 부분 -->		
<!-- 변수명 어떤식으로 할지 생각  -->
		<!-- 정가-->	<span>${goodsprice}원</span>
		
		</td>	
	
					
		<!-- 판매가 -->		
		<td class="price">
				<input type="hidden" id="h_goods_sales_price" value="${item.goods_sales_price}">
				<fmt:formatNumber value="${item.goods_sales_price}" var="discountedprice" pattern="#,###"/>
				<strong>
				            ${discountedprice}원(${item.goods_discount}% 할인)
				         </strong>
					</td>
  <!-- 수량 -->		
 		<td>
 			<input type="button" value=" - " name="minus" onclick="javascript:minusone(${item.goods_id},${item.goods_price},${item.goods_sales_price},${idx.index});">
 			<input type="text" name="cart_goods_qty" id="cart_goods_qty" readonly size="1" value="${cart_goods_qty}" >
 			<input type="button" value=" + " name="plus" onclick="javascript:plusone(${item.goods_id},${item.goods_price},${item.goods_sales_price},${idx.index});">
 		<!--   
 		onchange="javascript:change(${item.goods_id},${item.goods_price},${item.goods_sales_price},${idx.index})"-->
 		
 		</td>
  
  
  <!--  
  <td>  
					   <input type="text" name="cart_goods_qty" size="3" value="${cart_goods_qty}"><br>
						<a href="javascript:modify_cart_qty(${item.goods_id},${item.goods_sales_price},${cart_goods_qty});" >
						    <img width=25 alt=""  src="${contextPath}/resources/image/btn_modify_qty.jpg">
						</a>
						<input type="hidden" id="h_cart_goods_qty" value="${cart_goods_qty}">
					</td>
					-->
				
		<td>
			<fmt:formatNumber  value="${item.goods_sales_price*cart_goods_qty}" var="priceXqty" pattern="#,###"/>
			<input type="text" name="priceXqty" size=5 value="${priceXqty}" readonly style="border:0px none"><br>
		</td>			
				
	
	
	<!-- 합계보이는 부분을 input으로 넣으면 될듯 -->
	<!--  	<td>이거 여러번 해도 안꼬이는지 확인해야함
					   <strong> 
					   			<input type="hidden" name="h_priceXqty" value="${item.goods_sales_price*cart_goods_qty}">
			    <fmt:formatNumber  value="${item.goods_sales_price*cart_goods_qty}" type="number" var="priceXqty" pattern="#,###"/>
				         <p id="p_priceXqty"> ${priceXqty}원</p>	</strong> 
		</td>-->
					<td><!-- javascript:fn_order_each_goods('${item.goods_id}','${item.goods_title}','${item.goods_sales_price}','${item.goods_fileName}'); -->
		<!-- 각각구매 -->	 <a href="javascript:fn_order_each_goods('${item.goods_id}','${item.goods_title}','${item.goods_sales_price}','${item.goods_fileName}');">
					       <!-- 왜 '' 붙여야 넘어갈까 이게 기본인가  -->
					       	<img width="75" alt=""  src="${contextPath}/resources/image/btn_order.jpg">
							</a><br>
					 	<a href="#"> 
					 	   <img width="75" alt=""
							src="${contextPath}/resources/image/btn_order_later.jpg">
						</a><br> 
						<a href="#"> 
						   <img width="75" alt=""
							src="${contextPath}/resources/image/btn_add_list.jpg">
						</A><br> 
						<a href="javascript:delete_cart_goods('${cart_id}');"> 
						   <img width="75" alt=""
							   src="${contextPath}/resources/image/btn_delete.jpg">
					   </a>
					</td>
			</tr>
			<!--  
			<c:if test="${item.goods_delivery_price>0}">
				<c:set var="totalDeliveryPrice" value="2500"/>
			</c:if>
			-->
				<c:set var="totalGoodsPrice" value="${totalGoodsPrice+item.goods_price*cart_goods_qty }" />
				<c:set var="totalGoodsNum" value="${totalGoodsNum+1}" />
				<c:set var="totalSalesPrice" value="${totalSalesPrice+item.goods_sales_price*cart_goods_qty}" />
				<c:set var="totalDiscount" value="${totalDiscount+discount_price*cart_goods_qty}" />
				
</c:forEach>
		    
		</tbody>
	</table>
   <!-- 여기까지 위쪽 표  -->  	
	<div class="clear"></div>
	 </c:otherwise>
	</c:choose> 
	<br>
	<br>
	
   <table  width=80%   class="list_view" style="background:#cacaff">
   <tbody>
        <tr  align=center  class="fixed" >
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
         <!--
         <td id="">
           <p id="p_totalGoodsNum">${totalGoodsNum}개 </p>
           <input id="h_totalGoodsNum"type="hidden" value="${totalGoodsNum}"  />
         </td>
           -->
     <!--총상품금액 -->     
          <td>
             
          <fmt:formatNumber  value="${totalGoodsPrice}" type="number" var="fmttotal_goods_price" pattern="#,###"/>
            <input id="h_totalGoodsPrice" type="hidden" value="${totalGoodsPrice}" />  
               <p id="p_totalGoodsPrice">${fmttotal_goods_price}원</p> <!-- 이거 숨기고 밑에거가 나오게 하는 방법도있다  -->
          <!--  <div id="p_totalGoodsPrice"></div>-->  <!-- 계산을 따로 해줘야함  -->
                      
           
          </td>
       <!--     총배송금액
          <td> 
             <img width="25" alt="" src="${contextPath}/resources/image/plus.jpg">  
          </td>
 
          <td>
            <p id="p_totalDeliveryPrice">
            <fmt:formatNumber  value="${totalDeliveryPrice}" var="tDeliveryPrice" pattern="#,###"/> 
            ${tDeliveryPrice}원  </p>
            <input id="h_totalDeliveryPrice"type="hidden" value="${totalDeliveryPrice}" />
          </td>  -->
         
          <td> 
            <img width="25" alt="" src="${contextPath}/resources/image/minus.jpg"> 
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
            <img width="25" alt="" src="${contextPath}/resources/image/equal.jpg">
          </td>
          <td>
<!-- 할인 후 최종금액-->
  		<!--총판매가+배송비 - 총할인금액 -->
             <p id="p_totalSalesPrice">
             <fmt:formatNumber  value="${totalGoodsPrice-totalDiscount}" type="number" var="total_price" pattern="#,###"/>
               ${total_price}원
         <!--  할인 후 금액 + 배송비
               <fmt:formatNumber  value="${totalDiscountedPrice+totalDeliveryPrice}" type="number" var="total_price2" />
               ${total_price2}원
              -->
             </p>
             <input id="h_totalSalesPrice" type="hidden" value="${totalGoodsPrice-totalDiscount}" />
          </td>
      </tr>
      </tbody>
   </table>
   <center>
    <br><br>   
       <a href="javascript:fn_order_all_cart_goods()">
          <img width="75" alt="" src="${contextPath}/resources/image/btn_order_final.jpg">
       </a>
       <a href="#"> <!-- 쇼핑계속하기 goodsDetail로 돌아가면 되겠는데 아니면......  -->
          <img width="75" alt="" src="${contextPath}/resources/image/btn_shoping_continue.jpg">
       </a>
   <center>
</form>   
