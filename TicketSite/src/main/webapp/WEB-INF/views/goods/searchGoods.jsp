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
	
	//체크박스 함수
	//전체 체크박스
	$('#checkall').click(function(){
		if($('input[id=checkall]').prop("checked")){//checkall 체크됐으면 이거 atrr나 input[id=checkall]:checked 안돼!! 이게 속성 고정되서 else 안먹힘
			//prop("checked",true) 하면 else false로 인식으로 못해... 그냥 checked만 해
			$('input[type=checkbox]').prop("checked",true);}
		else{
			$('input[type=checkbox]').prop("checked",false);
		}
		

		
	});// 전체 체크 클릭시

	//개별 체크박스 전체 체크박스 비교
	$('#checked_goods').change(function(){
		var length = $('input[id=checked_goods]').length;
		console.log(length);
		var clength = $('input[id=checked_goods]:checked').length;
		console.log(clength);
		if(length == clength){
			$('#checkall').prop("checked",true);
		}else{
			$('#checkall').prop("checked",false);
		}		
		
	});//체크박스 변동 사항 있다면 실행되는 함수 

});// 페이지 들어오자 마자 자동 실행 함수

	 
	

function add_wish(goods_id){
	var isLogOn = $('#isLogOn').val();
	console.log(isLogOn);
	if(isLogOn =='false'|| isLogOn ==''){
		alert("로그인 후 이용해주세요!");
		location.href="${contextPath}/member/loginForm.do"
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
			}else if(data.trim()=='isAlreadyExisted'){
				alert("이미 위시리스트에 담긴 상품입니다.");	
			}
			
		},
		error : function(data, textStatus) {
			alert("로그인 후 이용해주세요!");
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


function add_checkwish(){
	var isLogOn = $('#isLogOn').val();
	console.log(isLogOn);


	var checked_goods = $('input[id=checked_goods]:checked');
	var length = checked_goods.length;
	console.log("체크된 길이: "+length);
	
	//상품 체크  확인
	if(length==0){
		alert("상품을 체크해주세요!");
	}
	else{
		var idlist =[];
		var checked_goods_id;
		
		checked_goods.each(function(){
			
				checked_goods_id = $(this).val();
				idlist.push(checked_goods_id);
				
		});//체크박스 각각의 값 배열로 전달	
	
		console.log("idlist: "+idlist);

		//로그인 확인

		if(isLogOn==''||isLogOn=='false'){
			alert("로그인 후 이용할 수 있습니다!");
			location.href="${contextPath}/member/loginForm.do"
		}
		else{ 				
			$.ajax({
				type : "post",
				traditional:true,// 이래야 java에서 배열값을 받는다!
				async : false, //false인 경우 동기식으로 처리한다.
				url : "${contextPath}/goods/addcheckwish.do",
				data : {
					idlist:idlist
				},
				
				success : function(data, textStatus) {
					if(data.trim()=='add_success'){
						imgpopup('#layer','open');
					}else{
						imgpopup('#layer2','open');
						var exist_title = data.trim();
						document.getElementById('exist_title').innerHTML= exist_title+'등..';
					
					}
					
					
				},
				error : function(data, textStatus) {
					alert("에러가 발생했습니다."+data);
				},
				complete : function(data, textStatus) {
					
					
				}
			}); //end ajax	
		}//else 로그인  
	}//else 상품을 체크한 경우

}//function add_checkwish
</script>
<style>
#layer,#layer2{
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
	<tr style="background-color: #2196F3; color: white;"><td>&emsp;<input type="checkbox" id="checkall" ></td><td></td><td>&emsp;상품명</td><td>&emsp;원가</td><td>&emsp;&emsp;할인율</td><td>&emsp;할인가</td><td></td></td>
		<tbody>
		  <c:forEach var="item" items="${goodsList}"> 
			<tr>
					<td>&emsp;<input type="checkbox" id="checked_goods" name="checked_goods"  value="${item.goods_id}" ></td>
					<td class="goods_image">
						<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
							   <img width="75" alt="" src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"/>
						</a>
					</td>
					<td class="goods_description">
						<h2>
							<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">${item.goods_title }</a>
						</h2>
						
						<div class="writer_press" >
						판매종료일: ${item.goods_lastsale_date} | 유효기간: ${item.goods_expired_date}까지|
						<c:out value="${arr[0]}" />
						</div>
					</td>
					<td class="price">
						<fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />		        
						<span>${goods_price}원</span>						
					</td>
					<td class="price">
						<strong>${item.goods_discount}% 할인</strong>					
					</td>
					<td class="price">
						<strong>
						<fmt:formatNumber  value="${item.goods_sales_price}" type="number" var="goods_sales_price" />
				               ${goods_sales_price}원 
						</strong>			
					</td>
					

						
					<td class="buy_btns"style="width:82px">
						<UL>
						<li><a href="javascript:add_wish(${item.goods_id})">위시리스트</a></li>
						
							
						</UL>
					</td>
			</tr>
			</c:forEach>
		</tbody>
		<tr>
		<td class="buy_btns" style="width:100px">
						<UL>
						<li><a href="javascript:add_checkwish()">선택한 것<br>위시리스트</a></li>
						
							
						</UL>
					</td>
			</tr>
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
	
	<div id="layer" style="visibility: hidden" >
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
	<div id="layer2" style="visibility: hidden" >
		<div id="popup">
			<a href="javascript:" onClick="javascript:imgpopup('#layer2','close');">
			<img
				src="${contextPath}/resources/image/close.png" id="close" />
			</a>  <font size="12" id="contents" style="font-size:20pt; text-align: center;"><br> 이미 등록된 상품이 <br> 있습니다!!</font><br><div id="exist_title"></div><br>
			<form   action='${contextPath}/goods/WishList.do'  >				
				<input  type="submit" value="위시리스트 보기">
			</form>			
			
		</div>
	</div>
	<input type="hidden" value="${isLogOn}" id="isLogOn">