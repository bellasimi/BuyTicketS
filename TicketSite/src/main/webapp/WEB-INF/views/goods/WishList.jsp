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
	var listmenu = $('#listmenu').val();
	console.log(listmenu);
	if(listmenu == 'list1'){
	 	 $('#list1').attr('class','active');}
	else if (listmenu == 'list2'){
		 $('#list2').attr('class','active');}
	else if (listmenu == 'list3'){
		 $('#list3').attr('class','active');}
	else if (listmenu == 'list4'){
		 $('#list4').attr('class','active');}
	

/* <input type="checkbox" id="checkall" checked>
<input type="checkbox" id="checked_goods" name="checked_goods"  value="${item.goods_id}" >
 */
	
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
      //체크박스 개수 
      
      
      
	});
	//부분선택/전체해제 
	$("#checked_goods").change(function() {  //prop으로 썼었다 change로 해도 일단 선택은 똑같이 됨 
		console.log($("input[id=checked_goods]:checked").length);
	console.log($("input[id=checked_goods]").length);
		if($("input[id=checked_goods]:checked").length==$("input[id=checked_goods]").length) {
			
			$("#checkall").prop("checked",true);
			
		} else {			
			$("#checkall").prop("checked",false);
		
			
		}

		
		
	});//체크박스 변화
});//이 페이지 들어오자마자 자동 실행되는 함수들	

//체크박스로 삭제하기
function deletechecked(){
		var checked_goods= $('input[id=checked_goods]:checked'); //체크박스 받아옴
		var length = checked_goods.length;
		var checked_goods_id;
		var isLogOn = $('#isLogOn').val();
		
		var idlist =[];
		checked_goods.each(function(){
			checked_goods_id = $(this).val();
			idlist.push(checked_goods_id);
		});
	console.log("체크된 상품:"+checked_goods);
	console.log("길이:"+length);

	console.log("체크된 상품 id 리스트:"+idlist);
	for(var i=0;i<length;i++){

		console.log("아이디 : "+idlist[i]);
	}
	/* 
	if(length=0){
		alert("체크박스를 선택해 주세요!!");
	}else{
		if(isLogOn==''){
			alert("로그인 후 이용할 수 있습니다.")
		}else{
		$.ajax({
			type : "post",
			traditional:true,// 이래야 java에서 배열값을 받는다!
			async : false, //false인 경우 동기식으로 처리한다.
			url : "${contextPath}/goods/deletecheckedwish.do",
			data : {
				idlist:idlist
			},
			
			success : function(data, textStatus) {
				console.log(data.trim());
				alert(data.trim());
				location.href="${contextPath}/goods/WishList.do";
			},
			error : function(data, textStatus) {
				alert("에러가 발생했습니다."+data);
			},
			complete : function(data, textStatus) {
				
				
			}
		}); //end ajax	
		}//else 로그인 */
	}//else 체크박스

}//함수종결
</script>
 <title>위시리스트</title>
</head>
<body>
	<hgroup>
		<h1>위시리스트</h1>
	</hgroup>
	<input type="hidden" value="${listmenu}" id="listmenu"/>
	<div id="sorting">
		<ul>

			<li><a id="list1" href="${contextPath}/goods/wishlastsale.do">판매 종료 임박</a></li>
			<li><a id="list2" href="${contextPath}/goods/wishcheap.do">가격 오름차순</a></li>
			<li><a id="list3" href="${contextPath}/goods/wishdiscount.do">할인율순</a></li>
			<li><a id="list4" style="border: currentColor; border-image: none;" href="${contextPath}/goods/wishrate.do">평점순</a></li>

		</ul>
	</div>
	<form id="wishform">
	<table id="list_view">
	<tr><td colspan="2"><input type="checkbox" id="checkall" ></td><td>상품명</td><td>원가</td><td>할인율</td><td>할인가</td><td></td></td>
		<tbody>
		  <c:forEach var="item" items="${goodsList}"> 
			<tr>
					<td><input type="checkbox" id="checked_goods" name="checked_goods"  value="${item.goods_id}" ></td>
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
					
				<!-- 
	<td class="buy_btns2">  main.css 702,705 a끼리 줄바꿈 안되게 수정 display: block;삭제 -->
	
	<td class="buy_btns">
						<UL>
						<li><a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">예매</a></li>
						<li><a href="${contextPath}/goods/deletewish.do?goods_id=${item.goods_id}">삭제</a></li>
						
							
						</UL>
					</td>

			</tr>
			</c:forEach>
			
		<!-- <td class="buy_btns2" style="width:20px"> -->
		<tr>
		<td class="buy_btns" >
						<UL>
						<li>
						<a href="javascript:deletechecked()">선택삭제</a>
						</li>
						</UL>
		</td>
		<td class="buy_btns">
						<UL>
						<li><a href="${contextPath}/goods/deletewishall.do">전체삭제</a>
						
						</li>
						</UL>
		</td>
		
		</tr>
		
		</tbody>
		
	</table>
	
	</form>				
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
<input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}"/>