<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="goods"  value="${goodsMap.goods}"  />
<c:set var="imageFileList"  value="${goodsMap.imageFileList}"  />

<c:choose>
<c:when test='${not empty goods.goods_status}'>
<script>
window.onload=function()
{
	init();
}

function init(){
	var frm_mod_goods=document.frm_mod_goods;
	var h_goods_status=frm_mod_goods.h_goods_status;
	var goods_status=h_goods_status.value;
	var select_goods_status=frm_mod_goods.goods_status;
	 select_goods_status.value=goods_status;
}
</script>
</c:when>
</c:choose>
<script type="text/javascript">
function fn_modify_goods(goods_id, attribute)
{
	var frm_mod_goods=document.frm_mod_goods;
	var value="";
	if(attribute=='goods_sort'){ value=frm_mod_goods.goods_sort.value; }
	else if(attribute=='goods_title'){ value=frm_mod_goods.goods_title.value; }
	else if(attribute=='goods_publisher'){ value=frm_mod_goods.goods_publisher.value; }
	else if(attribute=='goods_price'){ value=frm_mod_goods.goods_price.value; }
	else if(attribute=='goods_sales_price'){ value=frm_mod_goods.goods_sales_price.value; }
	else if(attribute=='goods_point'){ value=frm_mod_goods.goods_point.value; }
	else if(attribute=='goods_expired_date'){ value=frm_mod_goods.goods_expired_date.value;	}
	else if(attribute=='goods_status'){ value=frm_mod_goods.goods_status.value; }
	else if(attribute=='goods_place'){ value=frm_mod_goods.goods_place.value; }
	else if(attribute=='goods_description'){ value=frm_mod_goods.goods_description.value; }
	else if(attribute=='goods_terms'){ value=frm_mod_goods.goods_terms.value; }
	else if(attribute=='goods_usage'){ value=frm_mod_goods.goods_usage.value; }
	else if(attribute=='goods_location'){ value=frm_mod_goods.goods_location.value; }
	else if(attribute=='goods_lastsale_date'){ value=frm_mod_goods.goods_lastsale_date.value; }

	$.ajax({
		type : "post",
		async : false, //false인 경우 동기식으로 처리한다.
		url : "${contextPath}/admin/goods/modifyGoodsInfo.do",
		data : {
			goods_id:goods_id,
			attribute:attribute,
			value:value
		},
		success : function(data, textStatus) {
			if(data.trim()=='mod_success'){
				alert("상품 정보를 수정했습니다.");
			}else if(data.trim()=='failed'){
				alert("다시 시도해 주세요.");	
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



  function readURL(input,preview) {
	//  alert(preview);
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#'+preview).attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
  }  

  var cnt =1;
  function fn_addFile(){
	  $("#d_file").append("<br>"+"<input  type='file' name='detail_image"+cnt+"' id='detail_image"+cnt+"'  onchange=readURL(this,'previewImage"+cnt+"') />");
	  $("#d_file").append("<img  id='previewImage"+cnt+"'   width=200 height=200  />");
	  $("#d_file").append("<input  type='button' value='추가'  onClick=addNewImageFile('detail_image"+cnt+"','${imageFileList[0].goods_id}','detail_image')  />");
	  cnt++;
  }
  
  function modifyImageFile(fileId,goods_id, image_id,fileType){
    // alert(fileId);
	  var form = $('#FILE_FORM')[0];
      var formData = new FormData(form);
      formData.append("fileName", $('#'+fileId)[0].files[0]);
      formData.append("goods_id", goods_id);
      formData.append("image_id", image_id);
      formData.append("fileType", fileType);
      
      $.ajax({
        url: '${contextPath}/admin/goods/modifyGoodsImageInfo.do',
        processData: false,
        contentType: false,
        data: formData,
        type: 'POST',
	      success: function(result){
	         alert("이미지를 수정했습니다!");
	       }
      });
  }
  
  function addNewImageFile(fileId,goods_id, fileType){
	   //  alert(fileId);
		  var form = $('#FILE_FORM')[0];
	      var formData = new FormData(form);
	      formData.append("uploadFile", $('#'+fileId)[0].files[0]);
	      formData.append("goods_id", goods_id);
	      formData.append("fileType", fileType);
	      
	      $.ajax({
	          url: '${contextPath}/admin/goods/addNewGoodsImage.do',
	                  processData: false,
	                  contentType: false,
	                  data: formData,
	                  type: 'post',
	                  success: function(result){
	                      alert("이미지를 수정했습니다!");
	                  }
	          });
	  }
  
  function deleteImageFile(goods_id,image_id,imageFileName,trId){
	var tr = document.getElementById(trId);

      	$.ajax({
    		type : "post",
    		async : true, //false인 경우 동기식으로 처리한다.
    		url : "${contextPath}/admin/goods/removeGoodsImage.do",
    		data: {goods_id:goods_id,
     	         image_id:image_id,
     	         imageFileName:imageFileName},
    		success : function(data, textStatus) {
    			alert("이미지를 삭제했습니다!!");
                tr.style.display = 'none';
    		},
    		error : function(data, textStatus) {
    			alert("에러가 발생했습니다."+textStatus);
    		},
    		complete : function(data, textStatus) {
    			//alert("작업을완료 했습니다");	
    		}
    	}); //end ajax	
  }
</script>

</HEAD>
<BODY>
<form  name="frm_mod_goods"  method=post >
<DIV class="clear"></DIV>
	<!-- 내용 들어 가는 곳 -->
	<DIV id="container">
		<UL class="tabs">
			<li><a href="#tab1">메인이미지</a></li>
			<li><a href="#tab2">상품정보</a></li>
			<li><a href="#tab3">상세설명</a></li>
			<li><a href="#tab4">이용약관</a></li>
			<li><a href="#tab5">이용방법</a></li>
			<li><a href="#tab6">위치</a></li>
		</UL>
		<DIV class="tab_container">
<!-- tab1. 메인이미지 -->
		<div class="tab_content" id="tab1">
<!-- 			<h4>메인이미지</h4> -->
<!-- 			<table > -->
<!-- 				<tr> -->
<!-- 					<td align="right">파일을 추가하세요 </td> -->
		            
<!-- 		            <td  align="left"> <input type="button"  value="파일 추가" onClick="fn_addFile()"/></td> -->
<!-- 		            <td> -->
<!-- 			            <div id="d_file"> -->
<!-- 			            </div> -->
<!-- 		            </td> -->
<!-- 					<td> -->
<%-- <%-- 	 					<input  type="button" value="수정반영"  onClick="fn_modify_goods('${goods.goods_id }','goods_status')"/> --%>
<%-- 	 					<input  type="button" value="수정"  onClick="modifyImageFile('main_image','${item.goods_id}','${item.image_id}','${item.fileType}')"/> --%>
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 			</table> -->
			
			<form id="FILE_FORM" method="post" enctype="multipart/form-data"  >
				<h4>상품이미지</h4>
				 <table>
					 <tr>
					<c:forEach var="item" items="${imageFileList }"  varStatus="itemNum">
			        <c:choose>
			            <c:when test="${item.fileType=='main_image' }">
			              <tr>
						    <td>메인 이미지</td>
						    <td>
							  <input type="file"  id="main_image"  name="main_image"  onchange="readURL(this,'preview${itemNum.count}');" />
						      <input type="text" id="image_id${itemNum.count }"  value="${item.fileName }" disabled  />
							  <input type="hidden"  name="image_id" value="${item.image_id}"  />
							<br>
						</td>
						<td>
						  <img  id="preview${itemNum.count }"   width=200 height=200 src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}" />
						</td>
						<td>
						  &nbsp;&nbsp;&nbsp;&nbsp;
						</td>
						 <td>
						 <input  type="button" value="수정"  onClick="modifyImageFile('main_image','${item.goods_id}','${item.image_id}','${item.fileType}')"/>
						</td> 
					</tr>
					<tr>
					 <td>
					   <br>
					 </td>
					</tr>
			         </c:when>
			         <c:otherwise>
			           <tr  id="${itemNum.count-1}">
						<td>상세 이미지${itemNum.count-1 }</td>
						<td>
							<input type="file" name="detail_image"  id="detail_image"   onchange="readURL(this,'preview${itemNum.count}');" />
							<input type="text" id="image_id${itemNum.count }"  value="${item.fileName }" disabled  />
							<input type="hidden"  name="image_id" value="${item.image_id }"  />
							<br>
						</td>
						<td>
						  <img  id="preview${itemNum.count }"   width=200 height=200 src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}">
						</td>
						<td>
						  &nbsp;&nbsp;&nbsp;&nbsp;
						</td>
						 <td>
						 <input  type="button" value="수정"  onClick="modifyImageFile('detail_image','${item.goods_id}','${item.image_id}','${item.fileType}')"/>
						  <input  type="button" value="삭제"  onClick="deleteImageFile('${item.goods_id}','${item.image_id}','${item.fileName}','${itemNum.count-1}')"/>
						</td> 
					</tr>
					<tr>
					 <td>
					   <br>
					 </td>
					</tr> 
			         </c:otherwise>
			       </c:choose>		
			    </c:forEach>
			    <tr align="center">
			      <td colspan="3">
				      <div id="d_file">
						  <img  id="preview${itemNum.count }"  src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}" />
				      </div>
			       </td>
			    </tr>
		   <tr>
		     <td align=center colspan=2>
		     
		     <input   type="button" value="이미지파일추가하기"  onClick="fn_addFile()"  />
		   </td>
		</tr> 
	</table>
	</form>
		</div>
					
<!-- tab2. 상품 정보 -->			
		<div class="tab_content" id="tab2">
			<table>
				<tr>
					<td width=150>분류선택</td>
					<td width=200>${goods.goods_sort}</td>
					<td width=200>
						<select name="goods_sort">
							<option value="nature" selected>자연
							<option value="museum">박물관
							<option value="themepark">테마파크
							<option value="history">역사
							<option value="attraction">어트렉션
						</select>
					</td>
					<td>
						<input  type="button" value="수정반영"  onClick="fn_modify_goods('${goods.goods_id }','goods_status')"/>
					</td>
				</tr>
				<tr >
					<td>지역선택</td>
					<td>${goods.goods_place}</td>
					<td>
						<select name="goods_place">
							<option value="seoul" selected>서울시
							<option value="ggi">경기도
							<option value="gang">강원도
							<option value="chung">충청도
							<option value="jeolla">전라도
							<option value="sang">경상도
							<option value="jeju">제주도
						</select>
					</td>
					<td>
						<input  type="button" value="수정반영"  onClick="fn_modify_goods('${goods.goods_id }','goods_status')"/>
					</td>
				</tr>
				<tr >
					<td>상품이름</td>
					<td>${goods.goods_title}</td>
					<td><input name="goods_title" type="text" size="20" value="${goods.goods_title}"/></td>
					<td>
						<input  type="button" value="수정반영"  onClick="fn_modify_goods('${goods.goods_id }','goods_status')"/>
					</td>
				</tr>
				<tr>
					<td>주최사</td>
					<td>${goods.goods_publisher}</td>
					<td><input name="goods_publisher" type="text" size="20" value="${goods.goods_publisher}"/></td>
					<td>
						<input  type="button" value="수정반영"  onClick="fn_modify_goods('${goods.goods_id }','goods_status')"/>
					</td>
				</tr>
				<tr>
					<td>상품가격</td>
					<td>${goods.goods_price}</td>
					<td><input name="goods_price" type="text" size="20" value="${goods.goods_price}"/></td>
					<td>
						<input  type="button" value="수정반영"  onClick="fn_modify_goods('${goods.goods_id }','goods_status')"/>
					</td>
				</tr>
		
				<tr>
					<td>상품판매가격</td>
					<td>${goods.goods_sales_price}</td>
					<td><input name="goods_sales_price" type="text" size="20" value="${goods.goods_sales_price}"/></td>
					<td>
						<input  type="button" value="수정반영"  onClick="fn_modify_goods('${goods.goods_id }','goods_status')"/>
					</td>
				</tr>
		
		
				<tr>
					<td>포인트</td>
					<td>${goods.goods_point}</td>
					<td><input name="goods_point" type="text" size="20" value="${goods.goods_point}"/></td>
					<td>
						<input  type="button" value="수정반영"  onClick="fn_modify_goods('${goods.goods_id }','goods_status')"/>
					</td>
				</tr>
		
				<tr>
					<td>유효기간</td>
					<td>${goods.goods_expired_date}</td>
					<td><input  name="goods_expired_date"  type="date" size="20" value="${goods.goods_expired_date}"/></td>
					<td>
						<input  type="button" value="수정반영"  onClick="fn_modify_goods('${goods.goods_id }','goods_status')"/>
					</td>
				</tr>

				<tr>
					<td >판매상태</td>
					<td>${goods.goods_status}</td>
					<td>
						<select name="goods_status">
							<option value="bestseller" selected>베스트셀러</option>
							<option value="bigsale">할인행사</option>
							<option value="new">새로운아이</option>
<!-- 							<option value="on_sale" >판매중</option> -->
<!-- 							<option value="buy_out" >품절</option> -->
<!-- 							<option value="main_book" >절판</option> -->
						</select>
					</td>
					<td>
						<input  type="button" value="수정반영"  onClick="fn_modify_goods('${goods.goods_id }','goods_status')"/>
					</td>
				</tr>
			</table>
		</div>
<!-- tab3. 상세설명 -->			
		<div class="tab_content" id="tab3">
			<H4>상세설명</H4>
			<table>	
				<tr>
					<td><textarea  rows="30" cols="80" name="goods_description" placeholder="상세설명" value="${goods.goods_description}"></textarea></td>
					<td>
						<input  type="button" value="수정반영"  onClick="fn_modify_goods('${goods.goods_id }','goods_status')"/>
					</td>
							</tr>
						</table>	
					</div>
<!-- tab4. 이용약관 -->			
		<div class="tab_content" id="tab4">
			<H4>이용약관</H4>
			<table>
				<tr>
					<td><textarea  rows="30" cols="80" name="goods_terms" placeholder="이용약관" value="${goods.goods_terms}"></textarea></td>
					<td>
						<input  type="button" value="수정반영"  onClick="fn_modify_goods('${goods.goods_id }','goods_status')"/>
					</td>
		   		</tr>
		   </table>
		</div>
<!-- tab5. 이용방법-->			
		<div class="tab_content" id="tab5">
			<H4>이용방법</H4>
			<table>
				<tr>
					<td><textarea  rows="30" cols="80" name="goods_usage" placeholder="이용방법" value="${goods.goods_title}"></textarea></td>
					<td>
						<input  type="button" value="수정반영"  onClick="fn_modify_goods('${goods.goods_id }','goods_status')"/>
					</td>
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
					<td>
						<input  type="button" value="수정반영"  onClick="fn_modify_goods('${goods.goods_id }','goods_status')"/>
					</td>
			    </tr>
		    </table>
		</div>
					
<!-- 			<DIV class="tab_content" id="tab7"> -->
<!-- 			   <form id="FILE_FORM" method="post" enctype="multipart/form-data"  > -->
<!-- 				<h4>상품이미지</h4> -->
<!-- 				 <table> -->
<!-- 					 <tr> -->
<%-- 					<c:forEach var="item" items="${imageFileList }"  varStatus="itemNum"> --%>
<%-- 			        <c:choose> --%>
<%-- 			            <c:when test="${item.fileType=='main_image' }"> --%>
<!-- 			              <tr> -->
<!-- 						    <td>메인 이미지</td> -->
<!-- 						    <td> -->
<%-- 							  <input type="file"  id="main_image"  name="main_image"  onchange="readURL(this,'preview${itemNum.count}');" /> --%>
<%-- 						      <input type="text" id="image_id${itemNum.count }"  value="${item.fileName }" disabled  /> --%>
<%-- 							  <input type="hidden"  name="image_id" value="${item.image_id}"  /> --%>
<!-- 							<br> -->
<!-- 						</td> -->
<!-- 						<td> -->
<%-- 						  <img  id="preview${itemNum.count }"   width=200 height=200 src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}" /> --%>
<!-- 						</td> -->
<!-- 						<td> -->
<!-- 						  &nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 						</td> -->
<!-- 						 <td> -->
<%-- 						 <input  type="button" value="수정"  onClick="modifyImageFile('main_image','${item.goods_id}','${item.image_id}','${item.fileType}')"/> --%>
<!-- 						</td>  -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 					 <td> -->
<!-- 					   <br> -->
<!-- 					 </td> -->
<!-- 					</tr> -->
<%-- 			         </c:when> --%>
<%-- 			         <c:otherwise> --%>
<%-- 			           <tr  id="${itemNum.count-1}"> --%>
<%-- 						<td>상세 이미지${itemNum.count-1 }</td> --%>
<!-- 						<td> -->
<%-- 							<input type="file" name="detail_image"  id="detail_image"   onchange="readURL(this,'preview${itemNum.count}');" /> --%>
<%-- 							<input type="text" id="image_id${itemNum.count }"  value="${item.fileName }" disabled  /> --%>
<%-- 							<input type="hidden"  name="image_id" value="${item.image_id }"  /> --%>
<!-- 							<br> -->
<!-- 						</td> -->
<!-- 						<td> -->
<%-- 						  <img  id="preview${itemNum.count }"   width=200 height=200 src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}"> --%>
<!-- 						</td> -->
<!-- 						<td> -->
<!-- 						  &nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 						</td> -->
<!-- 						 <td> -->
<%-- 						 <input  type="button" value="수정"  onClick="modifyImageFile('detail_image','${item.goods_id}','${item.image_id}','${item.fileType}')"/> --%>
<%-- 						  <input  type="button" value="삭제"  onClick="deleteImageFile('${item.goods_id}','${item.image_id}','${item.fileName}','${itemNum.count-1}')"/> --%>
<!-- 						</td>  -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 					 <td> -->
<!-- 					   <br> -->
<!-- 					 </td> -->
<!-- 					</tr>  -->
<%-- 			         </c:otherwise> --%>
<%-- 			       </c:choose>		 --%>
<%-- 			    </c:forEach> --%>
<!-- 			    <tr align="center"> -->
<!-- 			      <td colspan="3"> -->
<!-- 				      <div id="d_file"> -->
<%-- 						  <img  id="preview${itemNum.count }"   width=200 height=200 src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}" /> --%>
<!-- 				      </div> -->
<!-- 			       </td> -->
<!-- 			    </tr> -->
<!-- 		   <tr> -->
<!-- 		     <td align=center colspan=2> -->
		     
<!-- 		     <input   type="button" value="이미지파일추가하기"  onClick="fn_addFile()"  /> -->
<!-- 		   </td> -->
<!-- 		</tr>  -->
<!-- 	</table> -->
<!-- 	</form> -->
<!-- 	</DIV> -->
	<DIV class="clear"></DIV>
					
</form>	