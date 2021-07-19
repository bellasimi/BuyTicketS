<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	 isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<style>
:root{
	--body-background-color: #f5f6f7;
	--font-color: #4e4e4e;
	--border-gray-color : #dadada;
	--naver-green-color: #04c75a;
	--naver-green-border-color: #06b350;
}


*{
	margin:0;
	padding:0;
}

body{
	background:var(--body-background-color);
}

.main-container{
	width:100%;
	display:flex;
	flex-direction:column;
	align-items:center;
	margin-top: 21px;
}
.main-container .main-wrap{
	width:768px;

}
.main-container .main-wrap .sel-lang-wrap .lang-select
{
	width: 96px;
	height: 30px;
	color: var(--font-color);
	border: solid 1px var(--border-gray-color);
}
.main-container .main-wrap .logo-wrap{
	padding-top:55px;
}
.main-container .main-wrap .logo-wrap img
{
	width: 231px;
	height: 44px;
}

.main-container .main-wrap header .sel-lang-wrap{
	display:flex;
	justify-content:flex-end;
}

.main-container .main-wrap header .logo-wrap{
	display:flex;	
	flex-direction: column;
	align-items: center;
}
.login-input-section-wrap{
	padding: 0px 350px 0px 0px;
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 1100px;

}

.login-input-wrap{
	width: 465px;
	height :48px;
	border: solid 1px var(	--border-gray-color );
	background: white;
}
.password-wrap{
	margin-top: 13px;
}
.login-input-wrap input{
	border: none;
	width:430px;
	margin-top: 10px;
	font-size: 14px;
	margin-left: 10px;
	height:30px;
}
.login-button-wrap {
	padding-top: 13px;
}
.login-button-wrap button{
	width: 465px;
	height :48px;
	font-size: 18px;
	background: #2196F3;
	color: #E6F2FF;
	border: solid 1px blue;
}
.login-button-wrap button:hover{color: black; background-color: white;
	
}

.login-stay-sign-in{
	width: 465px;
	height: 52px;
	
	display: flex;
	font-size: 15px;
	color: #4e4e4e;
	align-items: center;
	justify-content: flex-start;
	border-bottom: solid 1px var(--border-gray-color);
}
.login-stay-sign-in i{
	font-size: 25px;
	color: #9ba1a3;
}
.login-stay-sign-in span{
	padding-left: 5px;
	line-height: 25px;
}

.Easy-sgin-in-wrap{

	display: flex;
	flex-direction: column;
	align-items: center;
	padding-top: 40px;

}
.Easy-sgin-in-wrap h2{
	font-size: 20px;
}
.Easy-sgin-in-wrap .sign-button-list
{
	padding-top:25px;
	list-style: none;
	width: 465px;
	display: flex;
	flex-direction: column;
	align-items: center;
}
.Easy-sgin-in-wrap .sign-button-list li{
	padding-bottom: 10px;
}
.Easy-sgin-in-wrap .sign-button-list li button{
	width: 465px;
	height: 56px;
	border: solid 1px var(--border-gray-color);
	text-align: left;
	background: white;
}
.Easy-sgin-in-wrap .sign-button-list li button i{
	padding-left: 15px;
	font-size: 20px;
}
.fa-qrcode
{
	color:var(--naver-green-color);
}
.fa-line{
	color:var(--naver-green-color);
}
.fa-facebook-square
{
	color:#4064ac;
}
.Easy-sgin-in-wrap .sign-button-list li button span{
	padding-left: 20px;
	font-size: 18px;
}
.Easy-sgin-in-wrap .forget-msg{
	color:var(--font-color);
	font-size: 14px;
	padding-top: 10px;

}
footer{
   
	padding-top: 95px;

}
.other{
	padding-left: 185px;
}

</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<c:if test='${not empty message}'>

<script>

</script>
</c:if>
</head>
<body>
<div class="main-container">
		<div class="main-wrap">
		<form action="${contextPath}/member/login.do" method="post">
		<section class="login-input-section-wrap">
			<div class="login-input-wrap">	
				<input name="member_id" placeholder="Username" type="text"></input>
			</div>
			<div class="login-input-wrap password-wrap">	
				<input name="member_pw" placeholder="Password" type="password"></input>
			</div>
			<div class="login-button-wrap">
				<button type="submit">Sign in</button>
			</div>

		</section>
		<Br><br>
		<div class="other">
		   <a href="${contextPath}/member/isearchv.do">아이디 찾기</a> |
		   <a href="${contextPath}/member/psearchv.do">비밀번호 찾기</a> | 
		   <a href="${contextPath}/member/memberForm.do">회원가입</a> |   
		   <a href="${contextPath}/main/customer.do">고객 센터</a> |
		   </div>
	</form>
		</div>
	</div>
</body>
</html>