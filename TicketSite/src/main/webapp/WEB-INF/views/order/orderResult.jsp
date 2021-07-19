<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="total_order_goods_qty" value="0"/>
<c:set var="total_goods_point" value="0"/>
<head>
<style>
.pay_info {
	background-color: #E6F2FF;
	 padding: 50px 170px 50px 50px;
	 float:left;
	 font-size: 20px;
	 border-radius: 10px;
	 font-family: 'NanumBarunGothic', 'sans-serif';

}


</style>
<script type="text/javascript">
window.onload=function()
{
  init_pay_method();
}

function init_pay_method(){
	//var form_order=document.form_order;
	var pay_method=document.form_order.pay_method.value;
	console.log("pay_method"+pay_method);
	if(pay_method=="신용카드") {
		var e_card=document.getElementById("pay_card");
		var e_phone=document.getElementById("pay_phone");
		var e_account=document.getElementById("pay_random_account");
		e_card.style.visibility="visible";
		e_phone.style.visibility="hidden";
		e_account.style.visibility="hidden";
	}
	else if(pay_method=="휴대폰결제") {
		var e_card=document.getElementById("pay_card");
		var e_phone=document.getElementById("pay_phone");
		var e_account=document.getElementById("pay_random_account");
		e_card.style.visibility="hidden";
		e_phone.style.visibility="visible";
		e_account.style.visibility="hidden";
	}
	else if(pay_method=="무통장입금") {
		var e_card=document.getElementById("pay_card");
		var e_phone=document.getElementById("pay_phone");
		var e_account=document.getElementById("pay_random_account");
		e_card.style.visibility="hidden";
		e_phone.style.visibility="hidden";
		e_account.style.visibility="visible";
	}
}    



</script> 

</head>
<BODY>
	<H1>주문완료</H1>
	<TABLE class="list_view">
		<TBODY align=center>
			<tr style="background: #2196F3; color:white; font-weight:bold; font-size:15px;">
				<td colspan=2 class="fixed">주문상품명</td>
				<td>예약일</td>
				<td>주문금액</td>
				<td>수량</td>
				<td>적립금 합계</td>
				<td>주문금액합계</td>
			</tr>
			<tr>
			<c:forEach var="item" items="${myOrderList}">
				<!--   <td> ${item.order_id }</td>-->   
				<td class="goods_image">
					  <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
					    <IMG width="75" alt=""  src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
					  </a>
				</td>
				<td>
					  <h2>
					     <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">${item.goods_title }</a>
					  </h2>
				</td>
					
				<td>
					${item.goods_ticket_date }
				</td>
				<!--  주문금액 -->
					
				<td>
					<fmt:formatNumber var="goods_sales_price" value="${item.goods_sales_price}" pattern="#,###"/>
					${goods_sales_price}원
				</td>
				<td><!-- 수량 -->
				    ${item.order_goods_qty}개
				</td>		
				<!-- 적립금 합계-->
				<td>
					<fmt:formatNumber var="goodsPointXqty" value="${item.goods_point*item.order_goods_qty}" pattern="#,###"/>
					<h2>${goodsPointXqty}원</h2>
				</td>
				<td>
				<!--  주문금액 합계 -->
				<fmt:formatNumber var="priceXqty" value="${item.order_goods_qty *item.goods_sales_price}" pattern="#,###"/>
					  <h2>${priceXqty}원</h2>
				</td>
			</tr>
				<c:set var="total_order_goods_qty" value="${total_order_goods_qty+item.order_goods_qty}"/>
				<c:set var="total_goods_point" value="${total_goods_point+(item.goods_point*item.order_goods_qty)}"/>			
			</c:forEach>
			<tr style="background: #E6F2FF; font-size:20px;">
				<td colspan="4"></td>
				<td>${total_order_goods_qty}개</td>
				<td>
					<fmt:formatNumber var="totalGoodsPoint" value="${total_goods_point}" pattern="#,###"/>
					${totalGoodsPoint}
				</td>
				<td>
					<fmt:formatNumber var="orderTotalPrice" value="${myOrderInfo.order_total_price}" pattern="#,###"/>
					총 주문금액:${orderTotalPrice} 원
				</td>
			</tr> 
		</TBODY>
	</TABLE>
	<DIV class="clear"></DIV>
<form  name="form_order">
	<br>
	<br>

	<DIV class="clear"></DIV>
	<br>
	<br>
	<br>
	<H1>결제정보</H1>
	<input type="hidden" name="pay_method" value="${myOrderInfo.pay_method }">
	<DIV id="pay_card" class="pay_info" style="visibility:hidden"><!-- 여기도 구분해서 나오게 해야됨 -->
		<dl>
			<dd>결제방법 : ${myOrderInfo.pay_method }</dd>
			<dd>결제카드 : ${myOrderInfo.card_com_name}</dd>
			<dd>결제카드번호 : ${myOrderInfo.card_number}</dd>
		</dl>
	
	</DIV>
	
	
	<div id="pay_phone" class="pay_info" style="visibility:hidden">
		<dl>
			<dd>결제방법 : ${myOrderInfo.pay_method }</dd>
			<dd>통신사 : ${myOrderInfo.pay_hp_com}</dd>
			<dd>결제 전화번호 : ${myOrderInfo.pay_hp_num}</dd>
		</dl>
	</div>
	
	<div id="pay_random_account" class="pay_info" style="visibility:hidden">
		<dl>
			<dd>결제방법 : ${myOrderInfo.pay_method }</dd>
			<dd>계좌번호 : ${myOrderInfo.random_account}</dd>
		</dl>
	</div>
	
</form>
    <DIV class="clear"></DIV>
	<br>
	<div align="center">
		<br>
		<br> 
		    <button type="button" class="cart_btn" name="total" onclick="location.href='${contextPath}/main/main.do'">쇼핑계속하기</button>
		</div>
<DIV class="clear"></DIV>		
	
			
			
			