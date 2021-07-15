<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="navbar">
  <a href="#default" id="logo">고객 Q&A</a>
  <div id="navbar-right">
  

  </div>
</div>
<ul class="qna">
            <li>
                <input type="checkbox" id="qna-1">
                <label for="qna-1">다른 사람 명의의 계좌로 환불받을 수 있나요?</label>
                <div>
                    <p>다른 사람 명의로는 환불할 수 없습니다. 고객님 본인 명의 계좌로만 환불이 가능합니다.</p>
                </div>
            </li>
            <li>
                <input type="checkbox" id="qna-2">
                <label for="qna-2">등록한 환불계좌를 등록/변경하고 싶어요.</label>
                <div>
                    <p>마이페이지에서 환불계좌 등록 및 수정이 불가능합니다. 환불계좌는 주문자 명의의 본인 계좌만 등록할 수 있습니다.</p>
                    <p>주문 진행 상태가 변경되면 돌이킬수 없습니다.</p>
                </div>
            </li>
            <li>
                <input type="checkbox" id="qna-3">
                <label for="qna-3">반품 신청을 철회하고 싶어요.</label>
                <div>
                    <p>반품할 상품을 아직 보내지 않은 경우, 마이페이지에서 반품철회를 하실 수 있습니다.</p>
                    <p>반품철회 후 택배사에서 상품 수거가 된 것으로 확인될 경우 해당 주문은 반품처리한 것으로 재 변경됩니다.</p>
                </div>
            </li>
            <li>
                <input type="checkbox" id="qna-4">
                <label for="qna-4">배송된 상품이 부재중으로 반송된 경우 어떻게 하나요?</label>
                <div>
                    <p>저희는 온라인 티켓만 판매함으로 반송이 불가능 합니다.</p>
                </div>
            </li>
            <li>
                <input type="checkbox" id="qna-5">
                <label for="qna-5">상품에 대해서 문의하려면 어떻게 해야 하나요?</label>
                <div>
                    <p>상품에 관한 내용은 상품상세 화면에 자세히 안내되어 있습니다. 마이페이지 > 주문내역에서 주문한 상품을 선택하면 상세페이지로 이동합니다.</p>
                    <p>상품 상세 내용에 표시되어 있지 않은 내용은 대표전화로 연락주시면 상담해 드립니다.</p>
                   
                </div>
            </li>
        </ul>
        
        <script>
// When the user scrolls down 80px from the top of the document, resize the navbar's padding and the logo's font size
window.onscroll = function() {scrollFunction()};

function scrollFunction() {
  if (document.body.scrollTop > 80 || document.documentElement.scrollTop > 80) {
    document.getElementById("navbar").style.padding = "30px 10px";
    document.getElementById("logo").style.fontSize = "25px";
  } else {
    document.getElementById("navbar").style.padding = "80px 10px";
    document.getElementById("logo").style.fontSize = "35px";
  }
}
</script>

</body>
</html>