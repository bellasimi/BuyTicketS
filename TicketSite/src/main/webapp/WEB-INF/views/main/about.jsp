<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <meta name="viewport" content="width=device-width, initial-scale=1">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div id="navbar">
  <a href="#default" id="logo">우리의 ㈜BuyTicketS를 소개합니다</a>
  <div id="navbar-right">
  

  </div>
</div>

<div style="margin-top:210px;padding:15px 15px 2500px;font-size:30px">
  <p><b>BuyTicketS란?</b></p>
  <br><p>BuyTicketS는</p>
  <p>다양한 여행 상품과 어드랙션을 손쉽게 예약할 수 있는 여행 플랫폼입니다.</p>
  <br><p>BuyTicketS에서는 다양한 지역에 다양한 상품을 종류별로 볼수 있으며 각종 입장권과 여행 패키지를 손쉽게 구매할수 있습니다. </p>
  <br><p></p>

</div>

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