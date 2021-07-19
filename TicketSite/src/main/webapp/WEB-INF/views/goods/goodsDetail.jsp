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
<c:set var="review_avg" value="0"/>
<c:set var="rate1" value="0"/>
<c:set var="rate2" value="0"/>
<c:set var="rate3" value="0"/>
<c:set var="rate4" value="0"/>
<c:set var="rate5" value="0"/>
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
    padding-top: 30px;
    padding-bottom: 30px;
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
$(document).ready(function(){

	document.getElementById("defaultOpen").click();
//별 5칸 class 배열 각각 평균별점과 개별별점	
	var goods_id = $('#goods_id').val();
	var astarclass =[]; 

// 전체 평균 평점 별 
	var avgstar = $('#avgstar').val(); 
	console.log("평균: " +avgstar+" id: "+goods_id);
	document.getElementById("avgrate").innerHTML ="<br><br>&emsp;"+avgstar+" / 5점";
	if(avgstar==1){
		astarclass =["fa fa-star star-active mx-1","fa fa-star star-inactive mx-1","fa fa-star star-inactive mx-1", "fa fa-star star-inactive mx-1","fa fa-star star-inactive mx-1"];
	}
	else if(avgstar== 2){
		astarclass =["fa fa-star star-active mx-1","fa fa-star star-active mx-1","fa fa-star star-inactive mx-1", "fa fa-star star-inactive mx-1","fa fa-star star-inactive mx-1"];			
	}
	else if(avgstar== 3){
		astarclass =["fa fa-star star-active mx-1","fa fa-star star-active mx-1","fa fa-star star-active mx-1", "fa fa-star star-inactive mx-1","fa fa-star star-inactive mx-1"];			
	}
	else if(avgstar== 4){
		astarclass =["fa fa-star star-active mx-1","fa fa-star star-active mx-1",
			"fa fa-star star-active mx-1", "fa fa-star star-active mx-1","fa fa-star star-inactive mx-1"];			
	}
	else if(avgstar== 5){astarclass =["fa fa-star star-active mx-1","fa fa-star star-active mx-1",
		"fa fa-star star-active mx-1", "fa fa-star star-active mx-1","fa fa-star star-active mx-1"];	}
	else{
		astarclass =["fa fa-star star-inactive mx-1","fa fa-star star-inactive mx-1","fa fa-star star-inactive mx-1", "fa fa-star star-inactive mx-1","fa fa-star star-inactive mx-1"];
	}
	console.log(astarclass);
	$('#astar1').attr("class",astarclass[0]);
	$('#astar2').attr("class",astarclass[1]);
	$('#astar3').attr("class",astarclass[2]);
	$('#astar4').attr("class",astarclass[3]);
	$('#astar5').attr("class",astarclass[4]);
//평균 평점 insert
	$.ajax({
			type : "post",
			async : false, //false인 경우 동기식으로 처리한다. 순서대로 처리
			url : "${contextPath}/goods/avgrate.do",
			data : {
				goods_rate_avg:avgstar,
				goods_id:goods_id
			},
			success : function(data, textStatus) {
			
			},
			error : function(data, textStatus) {
				alert("작업 실패");
			},
			complete : function(data, textStatus) {
				
			}
		}); //end ajax	
// 막대기 class
	var barclass= []; //막대기 모양 class 배열
	var ratearr= []; //json형식 name: 평점 value: 사람수
	var ratearr2 =[]; // 그냥 평점 당 사람수 배열
	var order =[]; // 순서비교 배열
	var rate1 = $('#rate1').val();
	var rate2 = $('#rate2').val();
	var rate3 = $('#rate3').val();
	var rate4 = $('#rate4').val();
	var rate5 = $('#rate5').val();
	ratearr= [{name:0,value:rate1},{name:1,value:rate2},{name:2,value:rate3},{name:3,value:rate4},{name:4,value:rate5}];
	//ratearr= [{name:1,value:rate1},{name:2,value:rate2},{name:3,value:rate3},{name:4,value:rate4},{name:5,value:rate5}];
	ratearr2=[rate1,rate2,rate3,rate4,rate5];
	console.log("rate1 : "+rate1);
	console.log("rate2 : "+rate2);	
	//console.log(rate1+" , "+rate2+" , "+rate3+" , "+rate4+" , "+rate5+" bar: "+barclass);
	var set = new Set(ratearr); // 중복되는거 찾는 함수
	console.log("set: "+set.size);//중복되는 것들을 삭제하고 남은 개수
	//전부 중복일 때	
	if(set.size ==1){ 
			
			if(rate1>2){
				barclass =["bar-2","bar-2","bar-2","bar-2","bar-2"];
			}
			else if(rate1>5){
				barclass =["bar-3","bar-3","bar-3","bar-3","bar-3"];
			}
			else if(rate1>10){
				barclass =["bar-4","bar-4","bar-4","bar-4","bar-4"];
			}
			else{
				barclass =["bar-5","bar-5","bar-5","bar-5","bar-5"];
			}
		}
	//전부 중복은 아닌 경우
		else{
			
			order = ratearr.sort(function(a,b){
				return b.value - a.value;
			}); //VALUE 내림차순
			console.log("순서 : "+order);
			var order1=order[0].name;// 제일 큰값을 가진 rate이름 1,2,3,4
			var order2=order[1].name;
			var order3=order[2].name;
			var order4=order[3].name;
			var order5=order[4].name;
			var zero= []; //0값있는 행번호
			var same= []; //중복값 행번호
			var min = Math.min(rate1,rate2,rate3,rate4,rate5);
			var max = Math.max(rate1,rate2,rate3,rate4,rate5);
			console.log("최소 : "+min);
			console.log("최대 : "+max);

		
			for(var i=0;i< order.length;i++){
				if(order[i].value == 0){
					zero.push(order[i].name);
				}
			}
		
			console.log("0명 평점: "+zero);
		//0이 없는 경우 
			if(zero==null){ 
			barclass[order1]="bar-5";// 제일큰값이 들어가는 인덱스, 0행 부터 시작
			barclass[order2]="bar-4";
			barclass[order3]="bar-3";
			barclass[order4]="bar-2";
			barclass[order5]="bar-2";
				//중복인 경우 값을 같게
				var k;// 중복행을 담을 변수
				for(var i=0;i< order.length;i++){
					for(var j=0;j< order.length;j++){
						if(i!=j && order[i].value == order[j].value){
							 k=order[i].name;
						} 
					}//j
					same.push(k);//중복이 있다면 same에 행번호 넣어라
				}//i
				same = same.filter(Boolean); //empty,null,undefined 전부 삭제
				//중복행은 같은 막대로
				for(var j=0;j<same.length;j++){
					if(ratearr[same[j]]==max){
						barclass[same[j]]="bar-5";
					}else if(ratearr[same[j]]==min){
						barclass[same[j]]="bar-2";
					}else{
						barclass[same[j]]="bar-3";
					}
				}
				
			}//0이 없는 경우
			
		//0이 있는 경우
			else{
				barclass[order1]="bar-5";
				barclass[order2]="bar-4";
				barclass[order3]="bar-3";
				barclass[order4]="bar-2";
				barclass[order5]="bar-2";
				
				//중복인 경우 값을 같게
				var k;// 중복행을 담을 변수
				for(var i=0;i< order.length;i++){
					for(var j=0;j< order.length;j++){
						if(i!=j && order[i].value == order[j].value){
							 k=order[i].name;
						} 
					}//j
					same.push(k);//중복이 있다면 same에 행번호 넣어라
				}//i
				//same = same.filter(Boolean); //empty,null,undefined,0값까지 전부 삭제
				same = same.filter(function(e){
					return e != null;
				} ); //null값 삭제
				//중복행은 같은 막대로
				for(var j=0;j<same.length;j++){
					if(ratearr[same[j]]==max){
						barclass[same[j]]="bar-5";
					}else if(ratearr[same[j]]==min){
						barclass[same[j]]="bar-2";
					}else{
						barclass[same[j]]="bar-3";
					}
				}
				//0인행은 0으로
				for(var j=0;j<zero.length;j++){
					barclass[zero[j]]="bar-1";
				}
			}//0이 있는 경우
			console.log("중복행 : "+same);
			console.log("순서 : "+order);
			console.log("순서인덱스 : "+order1);
			console.log("순서인덱스 : "+order2);
			console.log("순서인덱스 : "+order3);
			console.log("순서인덱스 : "+order4);
			console.log("순서인덱스 : "+order5);
			console.log("barclass : "+barclass);

		}//전부 중복은 아닐 때

	$('#barsize1').attr("class",barclass[0]);//1점 평점
	$('#barsize2').attr("class",barclass[1]);
	$('#barsize3').attr("class",barclass[2]);
	$('#barsize4').attr("class",barclass[3]);
	$('#barsize5').attr("class",barclass[4]);
	
}); // 자동실행 함수들


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
		<h1 style="color:#2196F3">${goods.goods_title}</h1>
		<h2>티켓구매&gt; <a href="${contextPath}/goods/place.do?goods_place=${goodsMap.goodsVO.goods_place}">${place}</a>&gt;		
		<a href="${contextPath}/goods/sort.do?goods_sort=${goodsMap.goodsVO.goods_sort}">${sort}</a></h2>
		<h3 style="color:rgb(153, 153, 153)">주최: ${goods.goods_publisher}</h3>
		<h4></h4>
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
			<input type="hidden" id="goods_id" value="${goods.goods_id}">
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
				 
			<c:if test="${existreview eq false}">
				 	<div style="color:rgb(153, 153, 153); text-align: center; margin: 100px auto auto auto; height:500px;">
				 	리뷰가 존재하지 않습니다!</div>
			</c:if>
			 <c:if test="${existreview eq true}"><!-- 리뷰가 존재한다면 -->
				 						 
				<!-- 리뷰 내용 전체 평균 통계-->		 
 					<div class="container-fluid px-1 py-5 mx-auto"> 
 					
   				 		<div class="row justify-content-center">
       				 		<div class="col-xl-7 col-lg-8 col-md-10 col-12 text-center mb-5" style="margin-top: 10px;">
       				 		
           				 		<div class="card">
				<strong>평균 평점	</strong>	    <!-- 평균 별점 이미지-->
                         <div style="width: 130px;"> 
                         		<span id="astar1" class=""></span>
                        		<span id="astar2" class=""></span>
                        		<span id="astar3" class=""></span> 
                        		<span id="astar4" class=""></span> 
                        		<span id="astar5" class=""></span> 
                        </div>
          
                        					<div class="rating-box">
                            					<h1 class="pt-4" id="avgrate"></h1>
                            					
                        			</div>
                   
                    <div class="col-md-8" style="display: inline-block; margin-top: 40px;" >
                        <div class="rating-bar0 justify-content-center">
                            <table class="text-left mx-auto">
                           
                                <tr>
                                    <td class="rating-label">5점</td>
                                    <td class="rating-bar">
                                        <div class="bar-container">
                                            <div id="barsize5" class=""></div>
                                        </div>
                                    </td>
                                    <td class="text-right" id="bar5">${star5}</td>
                                </tr>
                                <tr>
                                    <td class="rating-label">4점</td>
                                    <td class="rating-bar">
                                        <div class="bar-container">
                                            <div id="barsize4" class=""></div>
                                        </div>
                                    </td>
                                    <td class="text-right"  id="bar4">${star4}</td>
                                </tr>
                                <tr>
                                    <td class="rating-label">3점</td>
                                    <td class="rating-bar">
                                        <div class="bar-container">
                                            <div id="barsize3" class=""></div>
                                        </div>
                                    </td>
                                    <td class="text-right"  id="bar3">${star3}</td>
                                </tr>
                                <tr>
                                    <td class="rating-label">2점</td>
                                    <td class="rating-bar">
                                        <div class="bar-container">
                                            <div  id="barsize2"class=""></div>
                                        </div>
                                    </td>
                                    <td class="text-right"  id="bar2">${star2}</td>
                                </tr>
                                <tr>
                                    <td class="rating-label">1점</td>
                                    <td class="rating-bar">
                                        <div class="bar-container">
                                            <div id="barsize1" class=""></div>
                                        </div>
                                    </td>
                                    <td class="text-right"  id="bar1">${star1}</td>
                                </tr>
                            </table>
                        </div>
                    </div>
   
            </div>
            
  <!-- 개인의견 -->    
        
		<c:forEach items="${reviewlist}" var="r">
            <div class="card" >
                <div class="row d-flex">
                    <div> <img class="profile-pic" src="${contextPath}/resources/icon/userdefault.png"></div>
                    <div class="d-flex flex-column">
                   
       <!-- 작성자이름 --><h3 class="mt-2 mb-0">${r.orderer_name}</h3>
                        <div>
       <!-- 별점 -->    		<p class="text-left">      						
       						<fmt:parseNumber value="${r.review_star}" var="review_star" ></fmt:parseNumber>
       						<c:if test="${review_star eq 1 }">
       							<span id="star1" class="fa fa-star star-active ml-3"></span> 
                            	<span id="star2" class="fa fa-star star-inactive"></span> 
                            	<span id="star3" class="fa fa-star star-inactive"></span> 
                            	<span id="star4" class="fa fa-star star-inactive"></span> 
                            	<span id="star5" class="fa fa-star star-inactive"></span>
                            	
       						</c:if>
       						<c:if test="${review_star eq 2 }">
       							<span id="star1" class="fa fa-star star-active ml-3"></span> 
                            	<span id="star2" class="fa fa-star star-active"></span> 
                            	<span id="star3" class="fa fa-star star-inactive"></span> 
                            	<span id="star4" class="fa fa-star star-inactive"></span> 
                            	<span id="star5" class="fa fa-star star-inactive"></span>
                            	
       						</c:if>
       						<c:if test="${review_star eq 3 }">
       							<span id="star1" class="fa fa-star star-active ml-3"></span> 
                            	<span id="star2" class="fa fa-star star-active"></span> 
                            	<span id="star3" class="fa fa-star star-active"></span> 
                            	<span id="star4" class="fa fa-star star-inactive"></span> 
                            	<span id="star5" class="fa fa-star star-inactive"></span>
                            	
       						</c:if>
       						<c:if test="${review_star eq 4 }">
       							<span id="star1" class="fa fa-star star-active ml-3"></span> 
                            	<span id="star2" class="fa fa-star star-active"></span> 
                            	<span id="star3" class="fa fa-star star-active"></span> 
                            	<span id="star4" class="fa fa-star star-active"></span> 
                            	<span id="star5" class="fa fa-star star-inactive"></span>
                            	
       						</c:if>
       						<c:if test="${review_star eq 5 }">
       							<span id="star1" class="fa fa-star star-active ml-3"></span> 
                            	<span id="star2" class="fa fa-star star-active"></span> 
                            	<span id="star3" class="fa fa-star star-active"></span> 
                            	<span id="star4" class="fa fa-star star-active"></span> 
                            	<span id="star5" class="fa fa-star star-active"></span>
                            	
       						</c:if>
       						<span class="text-muted">&emsp;${r.review_star}점</span> 
                            </p>
                        </div>
                        <input type="hidden" id="review_star" value="${review_star}"/>
                    </div>
                    <div class="ml-auto">
      	<!-- 구매일 --> <fmt:parseDate value="${r.pay_order_time}" var="pay_order_time" pattern="yyyy-MM-dd HH:mm:ss.S"></fmt:parseDate>
                    	<fmt:formatDate value="${pay_order_time}" var="pay_order_time" pattern="yy-MM-dd"/>     
      	<!-- 사용일 -->	<fmt:parseDate value="${r.goods_ticket_date}" var="goods_ticket_date" pattern="yyyy-MM-dd HH:mm:ss.S"></fmt:parseDate>
          				<fmt:formatDate value="${goods_ticket_date}" var="goods_ticket_date" pattern="yy-MM-dd"/>
      					<h4 class="blue-text mt-3">구매일 : ${pay_order_time} | 사용일 : ${goods_ticket_date}</h4>
                    </div>
                </div>
                <p class="text-muted pt-5 pt-sm-3"></p>
                <div class="row text-left">
      <!-- 리뷰내용 --><p class="content">${r.review_content}</p>
                </div>
                <!-- 좋아요 싫어요는 나중에 구현 
                <div class="row text-left mt-4" >
                    <div class="like mr-3 vote"> <img src="https://i.imgur.com/mHSQOaX.png"><span class="blue-text pl-2">20</span> </div>
                    <div class="unlike vote"> <img src="https://i.imgur.com/bFBO3J7.png"><span class="text-muted pl-2">4</span> </div>
                </div> -->
                
          		<c:set var ="review_avg" value="${review_avg+review_star}"/> 
            </div>
  <!-- 반복문 끝! --></c:forEach>
  				<fmt:parseNumber value="${review_avg/count}" var="avgstar" integerOnly="true"/>
  				<input type="hidden" id="avgstar" value="${avgstar}"/>
  				<input type="hidden" id="rate1" value="${star1}"/>
  				<input type="hidden" id="rate2" value="${star2}"/>
  				<input type="hidden" id="rate3" value="${star3}"/>
  				<input type="hidden" id="rate4" value="${star4}"/>
  				<input type="hidden" id="rate5" value="${star5}"/>
        <!-- 개인리뷰 card 끝 -->
        		</div><!--col-xl-7 --> 
    		</div><!-- row justify-content-center -->
		</div><!-- 리뷰 container 끝 -->
	</c:if><!-- 리뷰가 존재하는 지 조건 끝 -->			 
</div><!-- 리뷰내용 -->		
				 
				 
				
	</div><!-- cont div 끝 -->
	
	
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
<input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}"/><!-- 
<div>아이콘 제작자 <a href="https://smashicons.com/" title="Smashicons">Smashicons</a> from <a href="https://www.flaticon.com/kr/" title="Flaticon">www.flaticon.com</a></div> -->
