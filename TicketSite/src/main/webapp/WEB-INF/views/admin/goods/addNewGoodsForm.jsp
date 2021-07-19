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
			<h1>ԼƠƔЄ 새상품 등록창</h1>
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
								<td>
								<textarea  rows="30" cols="80" name="goods_location" placeholder="위치"></textarea>
<!-- <div class="map_area" id="map" tabindex="0" style="position: relative; overflow: hidden; background: url(&quot;http://static.naver.net/maps/mantle/1x/pattern_1.png&quot;) 0px 0px repeat transparent; width: 690px; height: 400px;"><div style="position: absolute; display: block; margin: 0px; padding: 0px; border: 0px none; top: 0px; left: 0px; overflow: visible; width: 100%; height: 100%; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); z-index: 0; cursor: url(&quot;http://static.naver.net/maps/mantle/1x/openhand.cur&quot;), default;"><div style="position: absolute; display: block; margin: 0px; padding: 0px; border: 0px none; top: 0px; left: 0px; overflow: visible; width: 100%; height: 100%; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); z-index: 0;"><div style="overflow: visible; width: 100%; height: 0px; position: absolute; display: block; margin: 0px; padding: 0px; border: 0px none; top: 0px; left: 0px; z-index: 1;"><div style="overflow: visible; width: 100%; height: 0px; position: absolute; display: none; margin: 0px; padding: 0px; border: 0px none; top: 0px; left: 0px; z-index: 0; user-select: none;"></div><div style="overflow: visible; width: 100%; height: 0px; position: absolute; display: block; margin: 0px; padding: 0px; border: 0px none; top: 0px; left: 0px; z-index: 1; user-select: none;"><div style="position: absolute; top: 0px; left: 0px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; display: block; width: 0px; height: 0px; overflow: visible; box-sizing: content-box !important;"><div draggable="false" unselectable="on" style="position: absolute; top: 207px; left: 215px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; opacity: 1; width: 256px; height: 256px;"><img draggable="false" unselectable="on" alt="" crossorigin="anonymous" width="256" height="256" src="http://nrbe.map.naver.net/styles/basic/1625727725/11/1746/793.png?mt=bg.ol.sw.ar.lko" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important; opacity: 1; position: absolute; left: 0px; top: 0px; z-index: 0; width: 256px; height: 256px;"></div><div draggable="false" unselectable="on" style="position: absolute; top: -49px; left: 215px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; opacity: 1; width: 256px; height: 256px;"><img draggable="false" unselectable="on" alt="" crossorigin="anonymous" width="256" height="256" src="http://nrbe.map.naver.net/styles/basic/1625727725/11/1746/792.png?mt=bg.ol.sw.ar.lko" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important; opacity: 1; position: absolute; left: 0px; top: 0px; z-index: 0; width: 256px; height: 256px;"></div><div draggable="false" unselectable="on" style="position: absolute; top: 463px; left: 215px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; opacity: 1; width: 256px; height: 256px;"><img draggable="false" unselectable="on" alt="" crossorigin="anonymous" width="256" height="256" src="http://nrbe.map.naver.net/styles/basic/1625727725/11/1746/794.png?mt=bg.ol.sw.ar.lko" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important; opacity: 1; position: absolute; left: 0px; top: 0px; z-index: 0; width: 256px; height: 256px;"></div><div draggable="false" unselectable="on" style="position: absolute; top: -305px; left: 215px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; opacity: 1; width: 256px; height: 256px;"><img draggable="false" unselectable="on" alt="" crossorigin="anonymous" width="256" height="256" src="http://nrbe.map.naver.net/styles/basic/1625727725/11/1746/791.png?mt=bg.ol.sw.ar.lko" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important; opacity: 1; position: absolute; left: 0px; top: 0px; z-index: 0; width: 256px; height: 256px;"></div><div draggable="false" unselectable="on" style="position: absolute; top: -305px; left: 471px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; opacity: 1; width: 256px; height: 256px;"><img draggable="false" unselectable="on" alt="" crossorigin="anonymous" width="256" height="256" src="http://nrbe.map.naver.net/styles/basic/1625727725/11/1747/791.png?mt=bg.ol.sw.ar.lko" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important; opacity: 1; position: absolute; left: 0px; top: 0px; z-index: 0; width: 256px; height: 256px;"></div><div draggable="false" unselectable="on" style="position: absolute; top: 463px; left: -41px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; opacity: 1; width: 256px; height: 256px;"><img draggable="false" unselectable="on" alt="" crossorigin="anonymous" width="256" height="256" src="http://nrbe.map.naver.net/styles/basic/1625727725/11/1745/794.png?mt=bg.ol.sw.ar.lko" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important; opacity: 1; position: absolute; left: 0px; top: 0px; z-index: 0; width: 256px; height: 256px;"></div><div draggable="false" unselectable="on" style="position: absolute; top: -49px; left: 471px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; opacity: 1; width: 256px; height: 256px;"><img draggable="false" unselectable="on" alt="" crossorigin="anonymous" width="256" height="256" src="http://nrbe.map.naver.net/styles/basic/1625727725/11/1747/792.png?mt=bg.ol.sw.ar.lko" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important; opacity: 1; position: absolute; left: 0px; top: 0px; z-index: 0; width: 256px; height: 256px;"></div><div draggable="false" unselectable="on" style="position: absolute; top: 207px; left: -41px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; opacity: 1; width: 256px; height: 256px;"><img draggable="false" unselectable="on" alt="" crossorigin="anonymous" width="256" height="256" src="http://nrbe.map.naver.net/styles/basic/1625727725/11/1745/793.png?mt=bg.ol.sw.ar.lko" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important; opacity: 1; position: absolute; left: 0px; top: 0px; z-index: 0; width: 256px; height: 256px;"></div><div draggable="false" unselectable="on" style="position: absolute; top: 207px; left: 471px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; opacity: 1; width: 256px; height: 256px;"><img draggable="false" unselectable="on" alt="" crossorigin="anonymous" width="256" height="256" src="http://nrbe.map.naver.net/styles/basic/1625727725/11/1747/793.png?mt=bg.ol.sw.ar.lko" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important; opacity: 1; position: absolute; left: 0px; top: 0px; z-index: 0; width: 256px; height: 256px;"></div><div draggable="false" unselectable="on" style="position: absolute; top: -49px; left: -41px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; opacity: 1; width: 256px; height: 256px;"><img draggable="false" unselectable="on" alt="" crossorigin="anonymous" width="256" height="256" src="http://nrbe.map.naver.net/styles/basic/1625727725/11/1745/792.png?mt=bg.ol.sw.ar.lko" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important; opacity: 1; position: absolute; left: 0px; top: 0px; z-index: 0; width: 256px; height: 256px;"></div><div draggable="false" unselectable="on" style="position: absolute; top: 463px; left: 471px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; opacity: 1; width: 256px; height: 256px;"><img draggable="false" unselectable="on" alt="" crossorigin="anonymous" width="256" height="256" src="http://nrbe.map.naver.net/styles/basic/1625727725/11/1747/794.png?mt=bg.ol.sw.ar.lko" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important; opacity: 1; position: absolute; left: 0px; top: 0px; z-index: 0; width: 256px; height: 256px;"></div><div draggable="false" unselectable="on" style="position: absolute; top: -305px; left: -41px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; opacity: 1; width: 256px; height: 256px;"><img draggable="false" unselectable="on" alt="" crossorigin="anonymous" width="256" height="256" src="http://nrbe.map.naver.net/styles/basic/1625727725/11/1745/791.png?mt=bg.ol.sw.ar.lko" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important; opacity: 1; position: absolute; left: 0px; top: 0px; z-index: 0; width: 256px; height: 256px;"></div><div draggable="false" unselectable="on" style="position: absolute; top: -305px; left: 727px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; opacity: 1; width: 256px; height: 256px;"><img draggable="false" unselectable="on" alt="" crossorigin="anonymous" width="256" height="256" src="http://nrbe.map.naver.net/styles/basic/1625727725/11/1748/791.png?mt=bg.ol.sw.ar.lko" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important; opacity: 1; position: absolute; left: 0px; top: 0px; z-index: 0; width: 256px; height: 256px;"></div><div draggable="false" unselectable="on" style="position: absolute; top: 463px; left: -297px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; opacity: 1; width: 256px; height: 256px;"><img draggable="false" unselectable="on" alt="" crossorigin="anonymous" width="256" height="256" src="http://nrbe.map.naver.net/styles/basic/1625727725/11/1744/794.png?mt=bg.ol.sw.ar.lko" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important; opacity: 1; position: absolute; left: 0px; top: 0px; z-index: 0; width: 256px; height: 256px;"></div><div draggable="false" unselectable="on" style="position: absolute; top: -49px; left: 727px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; opacity: 1; width: 256px; height: 256px;"><img draggable="false" unselectable="on" alt="" crossorigin="anonymous" width="256" height="256" src="http://nrbe.map.naver.net/styles/basic/1625727725/11/1748/792.png?mt=bg.ol.sw.ar.lko" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important; opacity: 1; position: absolute; left: 0px; top: 0px; z-index: 0; width: 256px; height: 256px;"></div><div draggable="false" unselectable="on" style="position: absolute; top: 207px; left: -297px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; opacity: 1; width: 256px; height: 256px;"><img draggable="false" unselectable="on" alt="" crossorigin="anonymous" width="256" height="256" src="http://nrbe.map.naver.net/styles/basic/1625727725/11/1744/793.png?mt=bg.ol.sw.ar.lko" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important; opacity: 1; position: absolute; left: 0px; top: 0px; z-index: 0; width: 256px; height: 256px;"></div><div draggable="false" unselectable="on" style="position: absolute; top: 207px; left: 727px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; opacity: 1; width: 256px; height: 256px;"><img draggable="false" unselectable="on" alt="" crossorigin="anonymous" width="256" height="256" src="http://nrbe.map.naver.net/styles/basic/1625727725/11/1748/793.png?mt=bg.ol.sw.ar.lko" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important; opacity: 1; position: absolute; left: 0px; top: 0px; z-index: 0; width: 256px; height: 256px;"></div><div draggable="false" unselectable="on" style="position: absolute; top: -49px; left: -297px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; opacity: 1; width: 256px; height: 256px;"><img draggable="false" unselectable="on" alt="" crossorigin="anonymous" width="256" height="256" src="http://nrbe.map.naver.net/styles/basic/1625727725/11/1744/792.png?mt=bg.ol.sw.ar.lko" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important; opacity: 1; position: absolute; left: 0px; top: 0px; z-index: 0; width: 256px; height: 256px;"></div><div draggable="false" unselectable="on" style="position: absolute; top: 463px; left: 727px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; opacity: 1; width: 256px; height: 256px;"><img draggable="false" unselectable="on" alt="" crossorigin="anonymous" width="256" height="256" src="http://nrbe.map.naver.net/styles/basic/1625727725/11/1748/794.png?mt=bg.ol.sw.ar.lko" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important; opacity: 1; position: absolute; left: 0px; top: 0px; z-index: 0; width: 256px; height: 256px;"></div><div draggable="false" unselectable="on" style="position: absolute; top: -305px; left: -297px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; opacity: 1; width: 256px; height: 256px;"><img draggable="false" unselectable="on" alt="" crossorigin="anonymous" width="256" height="256" src="http://nrbe.map.naver.net/styles/basic/1625727725/11/1744/791.png?mt=bg.ol.sw.ar.lko" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important; opacity: 1; position: absolute; left: 0px; top: 0px; z-index: 0; width: 256px; height: 256px;"></div></div></div><div style="overflow: visible; width: 100%; height: 0px; position: absolute; display: block; margin: 0px; padding: 0px; border: 0px none; top: 0px; left: 0px; z-index: 100;"><div style="overflow: visible; width: 100%; height: 0px; position: absolute; display: block; margin: 0px; padding: 0px; border: 0px none; top: 0px; left: 0px; z-index: 101;"></div><div style="overflow: visible; width: 100%; height: 0px; position: absolute; display: block; margin: 0px; padding: 0px; border: 0px none; top: 0px; left: 0px; z-index: 103;"><div title="대학로 자유극장" style="position: absolute; overflow: hidden; box-sizing: content-box !important; cursor: inherit; left: 334px; top: 167px; width: 22px; height: 33px;"><map name="nmarker-98E94C64-0328-41B9-84CE-21E92A1038B5"><area href="#" shape="poly" coords="11,0,9,0,6,1,4,2,2,4,0,8,0,12,1,14,2,16,5,19,5,20,6,23,8,26,9,30,9,34,13,34,13,30,14,26,16,23,17,20,17,19,20,16,21,14,22,12,22,12,22,8,20,4,18,2,16,1,13,0" alt="마커의 경위도는 127.0036299,37.5827499 입니다." style="display: block; cursor: pointer;"></map><img draggable="false" unselectable="on" src="http://static.naver.net/maps/mantle/1x/marker-default.png" alt="" crossorigin="anonymous" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; user-select: none; -webkit-user-drag: none; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important; position: absolute; cursor: inherit; width: 22px; height: 33px; left: 0px; top: 0px;"><img src="http://static.naver.net/maps/mantle/1x/dot.gif" alt="" usemap="#nmarker-98E94C64-0328-41B9-84CE-21E92A1038B5" style="position: absolute; border: 0px; left: 0px; top: 0px; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important; user-select: none; width: 22px; height: 33px;"></div></div><div style="overflow: visible; width: 100%; height: 0px; position: absolute; display: block; margin: 0px; padding: 0px; border: 0px none; top: 0px; left: 0px; z-index: 106;"></div></div></div><div style="position: absolute; display: none; margin: 0px; padding: 0px; border: 0px none; top: 0px; left: 0px; overflow: visible; width: 100%; height: 100%; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); background-color: rgb(255, 255, 255); z-index: 10000; opacity: 0.5;"></div></div></div><div style="position: absolute; z-index: 100; margin: 0px; padding: 0px; pointer-events: none; bottom: 0px; right: 0px;"><div style="border: 0px none; margin: 0px; padding: 0px; pointer-events: none; float: right; height: 21px;"><div style="position: relative; width: 83px; height: 14px; margin: 0px 12px 7px 2px; overflow: hidden; pointer-events: auto;"><span style="display: block; margin: 0px; padding: 0px 4px; text-align: center; font-size: 10px; line-height: 11px; font-family: Helvetica, AppleSDGothicNeo-Light, nanumgothic, NanumGothic, 나눔고딕, Dotum, 돋움, sans-serif; font-weight: bold; color: rgb(0, 0, 0); text-shadow: rgba(255, 255, 255, 0.3) -1px 0px, rgba(255, 255, 255, 0.3) 0px 1px, rgba(255, 255, 255, 0.3) 1px 0px, rgba(255, 255, 255, 0.3) 0px -1px;">5km</span><img src="http://static.naver.net/maps/mantle/1x/scale-normal-b.png" width="75" height="4" alt="" style="position: absolute; left: 4px; bottom: 0px; z-index: 2; display: block; width: 75px; height: 4px; overflow: hidden; margin: 0px; padding: 0px; border: 0px none; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important;"><img src="http://static.naver.net/maps/mantle/1x/scale-normal-l.png" width="4" height="10" alt="" style="position:absolute;left:0;bottom:0;z-index:2;display:block;width:4px;height:10px;overflow:hidden;margin:0;padding:0;border:0 none;max-width:none !important;max-height:none !important;min-width:0 !important;min-height:0 !important;"><img src="http://static.naver.net/maps/mantle/1x/scale-normal-r.png" width="4" height="10" alt="" style="position:absolute;right:0;bottom:0;z-index:2;display:block;width:4px;height:10px;overflow:hidden;margin:0;padding:0;border:0 none;max-width:none !important;max-height:none !important;min-width:0 !important;min-height:0 !important;"></div></div><div style="border: 0px none; margin: -1px 0px 0px; padding: 0px; pointer-events: none; float: right; height: 22px;"><a href="https://ssl.pstatic.net/static/maps/mantle/notice/legal.html" target="_blank" style="display: block; width: 48px; height: 17px; overflow: hidden; margin: 0px 5px 5px 12px; pointer-events: auto;"><img src="http://static.naver.net/maps/mantle/1x/naver-normal-new.png" width="48" height="17" alt="NAVER" style="display:block;width:48px;height:17px;overflow:hidden;border:0 none;margin:0;padding:0;max-width:none !important;max-height:none !important;min-width:0 !important;min-height:0 !important;"></a></div></div><div style="position: absolute; z-index: 100; margin: 0px; padding: 0px; pointer-events: none; bottom: 0px; left: 0px;"><div style="border: 0px none; margin: 0px; padding: 0px; pointer-events: none; float: left; height: 21px;"><div class="map_copyright" style="margin: 0px; padding: 0px 0px 2px 10px; height: 19px; line-height: 19px; color: rgb(68, 68, 68); font-family: Helvetica, AppleSDGothicNeo-Light, nanumgothic, NanumGothic, 나눔고딕, Dotum, 돋움, sans-serif; font-size: 11px; clear: both; white-space: nowrap; pointer-events: none;"><div style="float: left;"><span style="white-space: pre; color: rgb(68, 68, 68);">© NAVER Corp.</span></div><a href="#" style="font-family: Helvetica, AppleSDGothicNeo-Light, nanumgothic, NanumGothic, 나눔고딕, Dotum, 돋움, sans-serif; font-size: 11px; line-height: 19px; margin: 0px 0px 0px 5px; padding: 0px; color: rgb(68, 68, 68); float: left; pointer-events: auto; text-decoration: underline; display: none;">더보기</a><div style="float: left;"><a target="_blank" href="http://www.openstreetmap.org/copyright" style="pointer-events: auto; white-space: pre; display: none; color: rgb(68, 68, 68);"> /OpenStreetMap</a></div></div></div></div><div style="border: 1px solid rgb(41, 41, 48); background: rgb(255, 255, 255); padding: 15px; color: rgb(51, 51, 51); position: absolute; font-size: 11px; line-height: 1.5; clear: both; display: none; max-width: 350px !important; max-height: 300px !important;"><h5 style="font-size: 12px; margin-top: 0px; margin-bottom: 10px;">지도 데이터</h5><a href="#" style="position: absolute; top: 8px; right: 8px; width: 14px; height: 14px; font-size: 14px; line-height: 14px; display: block; overflow: hidden; color: rgb(68, 68, 68); text-decoration: none; font-weight: bold; text-align: center;">x</a><div><span style="white-space: pre; color: rgb(68, 68, 68); float: left;">© NAVER Corp.</span><a target="_blank" href="http://www.openstreetmap.org/copyright" style="pointer-events: auto; white-space: pre; color: rgb(68, 68, 68); float: left; display: none;"> /OpenStreetMap</a></div></div><div style="position: absolute; z-index: 100; margin: 0px; padding: 0px; pointer-events: none; top: 0px; left: 0px;"><div style="border: 0px none; margin: 0px; padding: 0px; pointer-events: none; float: left;"><div style="position: relative; z-index: 4; pointer-events: auto;"><div style="position: relative; z-index: 0; width: 28px; margin: 10px; border: 1px solid rgb(68, 68, 68); box-sizing: content-box !important; user-select: none;"><a href="#" style="position: relative; z-index: 2; width: 28px; height: 22px; cursor: pointer; display: block; overflow: hidden; border-bottom: 1px solid rgb(202, 205, 209); box-sizing: content-box !important;"><img src="http://static.naver.net/maps/mantle/1x/zoom-in-large-normal.png" width="28" height="22" alt="지도 확대" style="margin:0;padding:0;border:solid 0 transparent;display:block;box-sizing:content-box !important;max-width:none !important;max-height:none !important;min-width:0 !important;min-height:0 !important;width:28px;height:22px;"></a><div style="position: relative; width: 28px; height: 156px; overflow: hidden; margin: 0px; padding: 7px 0px; background-color: rgb(255, 255, 255); cursor: pointer; box-sizing: content-box !important; display: block;"><div style="position: absolute; top: 7px; bottom: 7px; left: 12px; width: 4px; height: 156px; display: block; background-color: rgb(47, 135, 236);"></div><div style="position: absolute; top: 7px; bottom: 7px; left: 12px; width: 4px; height: 104px; display: block; background-color: rgb(202, 205, 209);"></div><a href="#" style="position: absolute; left: 4px; width: 18px; height: 10px; top: 104px; border: 1px solid rgb(68, 68, 68); cursor: move; display: block; overflow: hidden; box-sizing: content-box !important;"><img src="http://static.naver.net/maps/mantle/1x/zoom-handle.png" width="18" height="10" alt="지도 확대/축소 슬라이더" style="margin:0;padding:0;border:solid 0 transparent;display:block;box-sizing:content-box !important;max-width:none !important;max-height:none !important;min-width:0 !important;min-height:0 !important;width:18px;height:10px;"></a></div><a href="#" style="position: relative; z-index: 2; width: 28px; height: 22px; cursor: pointer; display: block; overflow: hidden; border-top: 1px solid rgb(202, 205, 209); box-sizing: content-box !important;"><img src="http://static.naver.net/maps/mantle/1x/zoom-out-large-normal.png" width="28" height="22" alt="지도 축소" style="margin:0;padding:0;border:solid 0 transparent;display:block;box-sizing:content-box !important;max-width:none !important;max-height:none !important;min-width:0 !important;min-height:0 !important;width:28px;height:22px;"></a><div style="position: absolute; top: 22px; width: 44px; height: 0px; overflow: visible; left: 36px; display: none;"><div style="display: block; margin: 0px; padding: 0px;"><h4 style="visibility:hidden;width:0;height:0;overflow:hidden;margin:0;padding:0;">지도 컨트롤러 범례</h4><div style="position: absolute; top: 43px; left: 0px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; display: block; width: 44px; height: 17px; overflow: hidden; box-sizing: content-box !important; visibility: visible;"><img src="http://static.naver.net/maps/mantle/1x/zoom-legend-right-on.png" alt="" style="position: absolute; top: 0px; left: 0px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; display: block; width: 44px; height: 17px; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important;"><span style="margin: 0px; border: 0px solid transparent; display: block; font-family: Helvetica, AppleSDGothicNeo-Light, nanumgothic, NanumGothic, 나눔고딕, Dotum, 돋움, sans-serif; position: relative; z-index: 2; line-height: 17px; color: rgb(255, 255, 255); font-size: 11px; padding: 0px 0px 0px 4px; text-align: center; letter-spacing: -1px; box-sizing: content-box !important;">부동산</span></div><div style="position: absolute; top: 63px; left: 0px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; display: block; width: 44px; height: 17px; overflow: hidden; box-sizing: content-box !important; visibility: visible;"><img src="http://static.naver.net/maps/mantle/1x/zoom-legend-right-normal.png" alt="" style="position: absolute; top: 0px; left: 0px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; display: block; width: 44px; height: 17px; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important;"><span style="margin: 0px; border: 0px solid transparent; display: block; font-family: Helvetica, AppleSDGothicNeo-Light, nanumgothic, NanumGothic, 나눔고딕, Dotum, 돋움, sans-serif; position: relative; z-index: 2; line-height: 17px; color: rgb(255, 255, 255); font-size: 11px; padding: 0px 0px 0px 4px; text-align: center; letter-spacing: -1px; box-sizing: content-box !important;">거리</span></div><div style="position: absolute; top: 83px; left: 0px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; display: block; width: 44px; height: 17px; overflow: hidden; box-sizing: content-box !important; visibility: visible;"><img src="http://static.naver.net/maps/mantle/1x/zoom-legend-right-normal.png" alt="" style="position: absolute; top: 0px; left: 0px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; display: block; width: 44px; height: 17px; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important;"><span style="margin: 0px; border: 0px solid transparent; display: block; font-family: Helvetica, AppleSDGothicNeo-Light, nanumgothic, NanumGothic, 나눔고딕, Dotum, 돋움, sans-serif; position: relative; z-index: 2; line-height: 17px; color: rgb(255, 255, 255); font-size: 11px; padding: 0px 0px 0px 4px; text-align: center; letter-spacing: -1px; box-sizing: content-box !important;">읍,면,동</span></div><div style="position: absolute; top: 113px; left: 0px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; display: block; width: 44px; height: 17px; overflow: hidden; box-sizing: content-box !important; visibility: visible;"><img src="http://static.naver.net/maps/mantle/1x/zoom-legend-right-normal.png" alt="" style="position: absolute; top: 0px; left: 0px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; display: block; width: 44px; height: 17px; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important;"><span style="margin: 0px; border: 0px solid transparent; display: block; font-family: Helvetica, AppleSDGothicNeo-Light, nanumgothic, NanumGothic, 나눔고딕, Dotum, 돋움, sans-serif; position: relative; z-index: 2; line-height: 17px; color: rgb(255, 255, 255); font-size: 11px; padding: 0px 0px 0px 4px; text-align: center; letter-spacing: -1px; box-sizing: content-box !important;">시,군,구</span></div><div style="position: absolute; top: 143px; left: 0px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; display: block; width: 44px; height: 17px; overflow: hidden; box-sizing: content-box !important; visibility: visible;"><img src="http://static.naver.net/maps/mantle/1x/zoom-legend-right-normal.png" alt="" style="position: absolute; top: 0px; left: 0px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; display: block; width: 44px; height: 17px; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important;"><span style="margin: 0px; border: 0px solid transparent; display: block; font-family: Helvetica, AppleSDGothicNeo-Light, nanumgothic, NanumGothic, 나눔고딕, Dotum, 돋움, sans-serif; position: relative; z-index: 2; line-height: 17px; color: rgb(255, 255, 255); font-size: 11px; padding: 0px 0px 0px 4px; text-align: center; letter-spacing: -1px; box-sizing: content-box !important;">시,도</span></div><div style="position: absolute; top: 163px; left: 0px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; display: block; width: 44px; height: 17px; overflow: hidden; box-sizing: content-box !important; visibility: hidden;"><img src="http://static.naver.net/maps/mantle/1x/zoom-legend-right-normal.png" alt="" style="position: absolute; top: 0px; left: 0px; z-index: 0; margin: 0px; padding: 0px; border: 0px solid transparent; display: block; width: 44px; height: 17px; box-sizing: content-box !important; max-width: none !important; max-height: none !important; min-width: 0px !important; min-height: 0px !important;"><span style="margin: 0px; border: 0px solid transparent; display: block; font-family: Helvetica, AppleSDGothicNeo-Light, nanumgothic, NanumGothic, 나눔고딕, Dotum, 돋움, sans-serif; position: relative; z-index: 2; line-height: 17px; color: rgb(255, 255, 255); font-size: 11px; padding: 0px 0px 0px 4px; text-align: center; letter-spacing: -1px; box-sizing: content-box !important;">국가</span></div></div></div></div></div></div></div><div style="position: absolute; z-index: 100; margin: 0px; padding: 0px; pointer-events: none; top: 0px; right: 0px;"><div style="border: 0px none; margin: 0px; padding: 0px; pointer-events: none; float: right;"><div style="position: relative; z-index: 5; margin: 10px; pointer-events: auto;"><ul style="position: relative; z-index: 1; padding: 0px; margin: 0px; list-style: none; display: block; height: 30px; box-sizing: content-box !important; border-right: 1px solid rgb(68, 68, 68);"><li style="position: relative; z-index: 1; float: left; display: block; margin: 0px; padding: 0px; list-style: none; border-width: 1px 0px 1px 1px; border-style: solid none solid solid; border-top-color: rgb(68, 68, 68); border-right-color: initial; border-bottom-color: rgb(68, 68, 68); border-left-color: rgb(68, 68, 68); border-image: initial; box-sizing: content-box !important;"><a href="#" style="margin: 0px; padding: 0px 7px; display: block; height: 26px; line-height: 26px; border: 1px solid rgb(42, 124, 221); background-color: rgb(47, 135, 236); text-decoration: none; color: rgb(255, 255, 255); font-size: 13px; letter-spacing: -1px; font-family: Helvetica, AppleSDGothicNeo-Light, nanumgothic, NanumGothic, 나눔고딕, Dotum, 돋움, sans-serif; box-sizing: content-box !important;">일반</a></li><li style="position: relative; z-index: 1; float: left; display: block; margin: 0px; padding: 0px; list-style: none; border-width: 1px 0px 1px 1px; border-style: solid none solid solid; border-top-color: rgb(68, 68, 68); border-right-color: initial; border-bottom-color: rgb(68, 68, 68); border-left-color: rgb(68, 68, 68); border-image: initial; box-sizing: content-box !important;"><a href="#" style="margin: 0px; padding: 0px 7px; display: block; height: 26px; line-height: 26px; border: 1px solid rgb(255, 255, 255); background-color: rgb(255, 255, 255); text-decoration: none; color: rgb(68, 68, 68); font-size: 13px; letter-spacing: -1px; font-family: Helvetica, AppleSDGothicNeo-Light, nanumgothic, NanumGothic, 나눔고딕, Dotum, 돋움, sans-serif; box-sizing: content-box !important;">위성</a></li></ul><ul style="position: absolute; z-index: 1; padding: 0px; margin: 0px; list-style: none; display: none; height: 30px; left: 0px; width: 100%; box-sizing: content-box !important; top: 32px;"><li style="position: relative; z-index: 1; display: none; margin: 0px; padding: 0px; list-style: none; border: 1px solid rgb(68, 68, 68); box-sizing: content-box !important;"><a href="#" style="margin: 0px; padding: 0px 0px 0px 25px; display: block; height: 26px; line-height: 26px; border: 1px solid rgb(255, 255, 255); background-color: rgb(255, 255, 255); text-decoration: none; color: rgb(102, 102, 102); font-size: 13px; letter-spacing: -1px; font-family: Helvetica, AppleSDGothicNeo-Light, nanumgothic, NanumGothic, 나눔고딕, Dotum, 돋움, sans-serif; box-sizing: content-box !important; position: relative;" title="지형도"><img src="http://static.naver.net/maps/mantle/1x/maptype-unchecked.png" width="13" height="13" alt="" style="position:absolute;display:block;top:7px;left:7px;width:13px;height:13px;border:0 none;cursor:pointer;max-width:none !important;max-height:none !important;min-width:0 !important;min-height:0 !important;"><span style="display:block;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;margin:0;padding:0;color:#666;font-size:13px;letter-spacing:-1px;font-family:Helvetica,AppleSDGothicNeo-Light,nanumgothic,NanumGothic,&quot;나눔고딕&quot;,Dotum,&quot;돋움&quot;,sans-serif;">지형도</span></a></li><li style="position: relative; z-index: 1; display: none; margin: 0px; padding: 0px; list-style: none; border: 1px solid rgb(68, 68, 68); box-sizing: content-box !important;"><a href="#" style="margin: 0px; padding: 0px 0px 0px 25px; display: block; height: 26px; line-height: 26px; border: 1px solid rgb(255, 255, 255); background-color: rgb(255, 255, 255); text-decoration: none; color: rgb(102, 102, 102); font-size: 13px; letter-spacing: -1px; font-family: Helvetica, AppleSDGothicNeo-Light, nanumgothic, NanumGothic, 나눔고딕, Dotum, 돋움, sans-serif; box-sizing: content-box !important; position: relative;" title="겹쳐보기"><img src="http://static.naver.net/maps/mantle/1x/maptype-checked.png" width="13" height="13" alt="" style="position:absolute;display:block;top:7px;left:7px;width:13px;height:13px;border:0 none;cursor:pointer;max-width:none !important;max-height:none !important;min-width:0 !important;min-height:0 !important;"><span style="display:block;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;margin:0;padding:0;color:#666;font-size:13px;letter-spacing:-1px;font-family:Helvetica,AppleSDGothicNeo-Light,nanumgothic,NanumGothic,&quot;나눔고딕&quot;,Dotum,&quot;돋움&quot;,sans-serif;">겹쳐보기</span></a></li></ul></div></div></div></div>								</td>						    -->
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