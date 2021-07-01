<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>${member.member_name}님의 아이디</h3>
<DIV id="detail_table">
<form action="${contextPath}/member/psearch.do" method="post">
		<TABLE>
			<TBODY>
				<TR class="dot_line">
					<TD class="fixed_join">아이디</TD>
					<TD>${member.member_id}</TD>
				</TR>
			</TBODY>
		</TABLE>
		<Br><br>
		 
	</form>		
		   <a href="${contextPath}/member/isearchv.do">전화번호로ID찾기</a>
		   <a href="${contextPath}/member/psearchv.do">비밀번호찾기</a>
		   <a href="${contextPath}/member/memberForm.do">회원가입</a>    
		   <a href="${contextPath}/main/customer.do">고객 센터</a>
</DIV>
</body>
</html>