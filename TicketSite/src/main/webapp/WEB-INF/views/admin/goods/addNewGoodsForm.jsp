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
</script>    
</head>

<BODY>
	<form action="${contextPath}/admin/goods/addNewGoods.do" method="post"  enctype="multipart/form-data">
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
										<option value="nature" selected>자연
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
										<option value="seoul" selected>서울시
										<option value="gyeonggi">경기도
										<option value="gangwon">강원도
										<option value="chungcheong">충청도
										<option value="jeolla">전라도
										<option value="gyeongsang">경상도
										<option value="jeju">제주도
									</select>
								</td>
							</tr>
							<tr >
								<td >상품이름</td>
								<td><input name="goods_title" type="text" size="40" /></td>
							</tr>
					
							<tr>
								<td >주최사</td>
								<td><input name="goods_publisher" type="text" size="40" /></td>
							</tr>
		
							<tr>
								<td >상품가격</td>
								<td><input name="goods_price" type="text" size="40" /></td>
							</tr>
					
							<tr>
								<td >상품판매가격</td>
								<td><input name="goods_sales_price" type="text" size="40" /></td>
							</tr>
					
					
							<tr>
								<td >포인트</td>
								<td><input name="goods_point" type="text" size="40" /></td>
							</tr>
					
							<tr>
								<td >유효기간</td>
								<td><input  name="goods_expired_date"  type="date" size="40" /></td>
							</tr>
							
				
							<tr>
								<td >상품 배송비</td>
								<td><input name="goods_delivery_price" type="text" size="40" /></td>
							</tr>
							<tr>
								<td >상품 도착일</td>
								<td><input name="goods_delivery_date"  type="date" size="40" /></td>
							</tr>
							
							<tr>
								<td >판매상태</td>
								<td>
									<select name="goods_status">
										<option value="bestseller"  >베스트셀러</option>
										<option value="bigsale" selected>스테디셀러</option>
										<option value="newbook"  >신간</option>
										<option value="on_sale" >판매중</option>
										<option value="buy_out" >품절</option>
										<option value="main_book" >절판</option>
									</select>
								</td>
							</tr>
						</table>	
					</div>
<!-- tab3. 상세설명 -->			
					<div class="tab_content" id="tab3">
						<H4>상세설명</H4>
						<table>	
							<tr>
								<td >상세설명</td>
								<td><textarea  rows="100" cols="80" name="goods_description"></textarea></td>
							</tr>
						</table>	
					</div>
<!-- tab4. 이용약관 -->			
					<div class="tab_content" id="tab4">
						<H4>이용약관</H4>
						<table>
							<tr>
								<td>이용약관</td>
								<td><textarea  rows="100" cols="80" name="goods_terms"></textarea></td>
					   		</tr>
					   </table>
					</div>
<!-- tab5. 이용방법-->			
					<div class="tab_content" id="tab5">
						<H4>이용방법</H4>
						<table>
							<tr>
								<td >이용방법</td>
								<td><textarea  rows="100" cols="80" name="goods_usage"></textarea></td>
						    </tr>
					    </table>
					</div>
					
<!-- tab6. 위치 -->
					<div class="tab_content" id="tab6">
						<H4>위치</H4>
						<table>
							<tr>
								<td >위치</td>
								<td>내용 추가 예정</td>
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