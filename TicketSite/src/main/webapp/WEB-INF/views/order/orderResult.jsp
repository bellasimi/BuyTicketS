<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
</head>
<BODY>
	<H1>주문완료</H1>
	<TABLE class="list_view">
		<TBODY align=center>
			<tr style="background: #33ff00">
			<!--   <td>주문번호 </td> -->   
				<td colspan=2 class="fixed">주문상품명</td>
				<td>수량</td>
				<td>예약일</td>
				<td>주문금액</td>
				<td>적립금</td>
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
					     <A href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">${item.goods_title }</A>
					  </h2>
					</td>
					<td><!-- 수량 -->
					  <h2>${item.order_goods_qty}개<h2>
					</td>
					<td>
					${item.goods_ticket_date }
					</td>
				<!--  주문금액 -->
					<!-- 여기는 그냥 가격ㅁ나 나오면 될거같은데  -->
					<td><h2>${item.order_goods_qty *item.goods_sales_price}원</h2></td>
							
				<!-- 적립금 -->
					<td><h2>${item.goods_point }원</h2></td>
					<td>
				<!--  주문금액 합계 -->
					  <h2>${item.order_goods_qty *item.goods_sales_price}원</h2>
					</td>
			</TR>
			
			</c:forEach>
			<tr><td colspan="4">총 주문금액:${myOrderInfo.order_total_price }</td></tr> 
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
	<H1>3.결제정보</H1>
	<DIV class="detail_table"><!-- 여기도 구분해서 나오게 해야됨 -->
		<table>
			<TBODY>
				<TR class="dot_line">
					<TD class="fixed_join">결제방법</TD>
					<TD>
					   ${myOrderInfo.pay_method }
				    </TD>
				</TR>
				<TR class="dot_line">
					<TD class="fixed_join">결제카드</TD>
					<TD>
					   ${myOrderInfo.card_com_name}
				    </TD>
				</TR>
				<TR class="dot_line">
					<TD class="fixed_join">할부기간</TD>
					<TD>
					   ${myOrderInfo.card_pay_month }
				    </TD>
				</TR>
			</TBODY>
		</table>
	</DIV>
</form>
    <DIV class="clear"></DIV>
	<br>
	<br>
	<br>
	<center>
		<br>
		<br> 
		<a href="${contextPath}/main/main.do"> 
		   <IMG width="75" alt="" src="${contextPath}/resources/image/btn_shoping_continue.jpg">
		</a>
<DIV class="clear"></DIV>		
	
			
			
			