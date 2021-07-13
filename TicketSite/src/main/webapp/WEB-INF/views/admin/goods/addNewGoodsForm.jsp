<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />	
<!DOCTYPE html>

<meta charset="utf-8">
<head>
<script type="text/javascript">
  var cnt=0;
  function fn_addFile(){
	  if(cnt == 0){
		  $("#d_file").append("<br>"+"<input  type='file' name='main_image' id='f_main_image' />");	  
	  }else{
		  $("#d_file").append("<br>"+"<input  type='file' name='detail_image"+cnt+"' />");
	  }
  	
  	cnt++;
  }
  
  
  function fn_add_new_goods(obj){
		 fileName = $('#f_main_image').val();
		 if(fileName != null && fileName != undefined){
			 obj.submit();
		 }else{
			 alert("메인 이미지는 반드시 첨부해야 합니다.");
			 return;
		 }
		 
	}
  
  $("select[name=goods_discount]").val();
</script>

<script type="text/javascript"
src="https://code.jquery.com/jquery-2.1.0.min.js">
</script>

<script>
var price = 0;
var discount = 0;

$(document).ready(function(){
	$("#discount").change(function(){
		discount=$(this).val();		
		console.log(price);
		console.log(discount);
		console.log(price*discount);
		var hap = document.ANG.goods_sales_price;
		hap.value=price-(price*discount/100);
		console.log(hap);
    });
	
	$("#price").change(function(){	
		price=$(this).val();
		console.log(price);
		console.log(discount);
		
		console.log(price*discount);
	});
	

	
});
           
</script>  

</head>

<BODY>
	<form action="${contextPath}/admin/goods/addNewGoods.do" name="ANG" method="post"  enctype="multipart/form-data">
			<h1>새상품 등록창</h1>
		<div class="tab_container">
<!-- 내용 들어 가는 곳 -->
			<div class="tab_container" id="container">
				<ul class="tabs">
					<li><a href="#tab1">메인이미지</a></li>
					<li><a href="#tab2">상품정보</a></li>
					<li><a href="#tab3">상세설명</a></li>
					<li><a href="#tab4">이용약관</a></li>
					<li><a href="#tab5">이용방법</a></li>
					<li><a href="#tab6">위치</a></li>
<!-- 			<li><a href="#tab6">추천사</a></li> -->
<!-- 			<li><a href="#tab7">상품이미지</a></li> -->
				</ul>
				<div class="tab_container">
<!-- tab1. 메인이미지 -->
					<div class="tab_content" id="tab1">
						<h4>메인이미지</h4>
						<table >
							<tr>
								<td align="right">파일을 추가하세요 </td>
					            
					            <td  align="left"> <input type="button"  value="파일 추가" onClick="fn_addFile()"/></td>
					            <td>
						            <div id="d_file">
						            </div>
					            </td>
							</tr>
						</table>
					</div>
		
<!-- tab2. 상품 정보 -->			
					<div class="tab_content" id="tab2">
						<table >
							<tr >
								<td width=200 >분류선택</td>
								<td width=500>
									<select name="goods_sort">
										<option value="선택하세요"selected >선택하세요
										<option value="nature" >자연
										<option value="museum">박물관
										<option value="themepark">테마파크
										<option value="history">역사
										<option value="attraction">어트렉션
									</select>
								</td>
							</tr>
							<tr >
								<td width=200 >지역선택</td>
								<td width=500>
									<select name="goods_place">
										<option value="선택하세요"selected >선택하세요
										<option value="seoul">서울시
										<option value="ggi">경기도
										<option value="gang">강원도
										<option value="chung">충청도
										<option value="jeolla">전라도
										<option value="sang">경상도
										<option value="jeju">제주도
									</select>
								</td>
							</tr>
							<tr >
								<td >상품이름</td>
								<td><input name="goods_title" type="text" size="25"placeholder="please enter product name"/></td>
							</tr>
					
							<tr>
								<td >주최사</td>
								<td><input name="goods_publisher" type="text" size="25"placeholder="please enter product organizer"/></td>
							</tr>
		
							<tr>
								<td >상품가격</td>
								<td><input name="goods_price" type="text" size="25" id="price" placeholder="please enter product price"/></td>
							</tr>
							<tr >
								<td >할인율</td>
								<td>
									<select name="goods_discount" id="discount">
										<option value="000"selected>선택하세요
										<option value="5">5
										<option value="10" >10
										<option value="15">15
										<option value="20">20
										<option value="25">25
										<option value="30">30
										<option value="35">35
										<option value="40">40
										<option value="45">45
										<option value="50">50
										<option value="55">55
										<option value="60">60
										<option value="65">65
										<option value="70">70
										<option value="75">75
										<option value="80">80
										<option value="85">85
										<option value="90">90
										<option value="95">95
										<option value="100">100
										
									</select>
								</td>
							</tr>
							<tr>
								<td>상품판매가격</td>
								<td>
									<input name="goods_sales_price" id="sales_price" type="text" size="25" readonly/>
								</td>
							</tr>
					
					
							<tr>
								<td >포인트</td>
								<td>
									<select name="goods_point">
										<option value="000"selected>선택하세요
										<option value="100" >100
										<option value="200">200
										<option value="300">300
										<option value="400">400
										<option value="500">500
										<option value="600">600
										<option value="700">700
										<option value="800">800
										<option value="900">900
										<option value="1000">1000
										<option value="9999">9999
										</select>
								</td>
							</tr>
					
							<tr>
								<td >유효기간</td>
								<td><input  name="goods_expired_date"  type="date" size="25" /></td>
							</tr>
														
							<tr>
								<td >판매상태</td>
								<td>
									<select name="goods_status">
										<option value="000"selected >선택하세요
										<option value="bestseller" >베스트셀러</option>
										<option value="bigsale">초특가세일</option>
										<option value="newsale">신규 액티비티</option>
									</select>
								</td>
							</tr>
							
							<tr>
								<td>판매 종료일</td>
								<td><input  name="goods_lastsale_date"  type="date" size="25" /></td>
							</tr>
						</table>	
					</div>
<!-- tab3. 상세설명 -->			
					<div class="tab_content" id="tab3">
						<table>	
							<tr>
								<td><textarea  rows="30" cols="80" name="goods_description" placeholder="상세설명"></textarea></td>
							</tr>
						</table>	
					</div>
<!-- tab4. 이용약관 -->			
					<div class="tab_content" id="tab4">
						<table>
							<tr>
								<td><textarea  rows="30" cols="80" name="goods_terms" placeholder="이용약관"></textarea></td>
					   		</tr>
					   </table>
					</div>
<!-- tab5. 이용방법-->			
					<div class="tab_content" id="tab5">
						<table>
							<tr>
								<td><textarea  rows="30" cols="80" name="goods_usage" placeholder="이용방법"></textarea></td>
						    </tr>
					    </table>
					</div>
					
<!-- tab6. 위치 -->
					<div class="tab_content" id="tab6">
						<H4>위치</H4>
						<table>
							<tr>
								<td><textarea  rows="30" cols="80" name="goods_location" placeholder="위치"></textarea></td>						   
						    </tr>
					    </table>
					</div>
				</div>
			</div>
<!-- final. 상품 등록하기 -->	
			<div class="clear"></div>
				<input type="button" value="상품 등록하기"  onClick="fn_add_new_goods(this.form)">
	
		</div>
	</form>
</BODY> 