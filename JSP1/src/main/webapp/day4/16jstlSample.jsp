<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>16jstlSample.jsp</title>
</head>
<body>
<h3>일반 변수 테스트</h3>
<% 
	String name = "김땡땡";
	
%>
${name }	<!-- 일반 자바변수는 애트리뷰트가 아니므로 출력이 안됨 -->
<hr>

<h3>core 태그(c로 시작하는 태그) 예시</h3>
<c:set var="age" value="10" />
age : ${age }	<br>
<!-- 일반적으로 el 출력은 c:out 태그로 합니다. (보안.웹취약성 문제를 없애기 위함.) -->
<hr>
<c:if test="${age<20 }">
	<div style="color:green;">청소년입니다.</div>
</c:if>
<hr>
<!-- c:if 조건은 test 속성에서 el 로 작성합니다. -->
<h3>if ~ else 형식 : else 해당하는 태그는 없습니다.</h3>
<c:set var="age" value="24" />
<!-- test 조건식이 거짓이므로 div 태그 출력 안함. -->
<c:if test="${age<20 }">
	<div style="color:green;">청소년입니다.</div>
</c:if>
<c:if test="${age>=20 }">
	<div style="color:blue;">성인입니다.</div>
</c:if>
<!-- else 해당하는 태그는 없습니다. c:choose 비슷한 동작을 합니다. 
	아래 c:choose 와 위의 c:if 2개는 같은 동작을 합니다. -->
<c:choose>
	<c:when test="${age<20 }">
		<div style="color:green;">청소년입니다.</div>
	</c:when>
	<c:otherwise>
		<div style="color:blue;">성인입니다.</div>
	</c:otherwise>
</c:choose>
<!-- 스크립트릿에서 for문을 작성하는 것 대신 사용 -->
<hr>
<h3>for each</h3>
<c:forEach var="i" begin="1" end="10" varStatus="status" step="2">
	<!-- for시작값은 1, 마지막값은 10, 변수명은 var로 지정. step 은 증가값.기본값 1 -->
	<c:out value="${i*10 }" /><br>
	<c:out value="${status.index }" /><br>
<!-- 몇번째 값인지를 나타내는 index 출력,
	varStatus는 for 동작의 상태(시작값, 마지막값, step, 현재순서)를 참조할 변수명 -->
</c:forEach>
<h3>배열과 컬렉션을 다루는 for each</h3>
<c:forEach items="${list }" var="vo">
	<c:out value="vo" /><br>
	<c:out value="${ststus.index }" /><br>
</c:forEach>
<hr>
<!-- fmt -->
<h3>fmt 서식 태그</h3>
<fmt:formatNumber  value="9999999"/> <br>  
<!-- formatNumber는 바로 출력과 저장 , value에는 값을 직접 또는 el -->
   <fmt:parseNumber var="test"  value="8888888"/> 
   <!-- fmt:parseNumber는 변수에 저장 -->
   test : ${test }<br>
   <fmt:formatNumber  value="9999999"  type="currency"/><br> 
   <!-- 현재 locale : ko_kr 표기는 언어_국가 형식 -->
   <fmt:setLocale value="en_us"/>  
   <!--  locale 변경 : en_us 표기는 언어_국가 형식 -->
   <fmt:formatNumber  value="9999999"  type="currency"/><br> 
   <!-- type: 화폐단위 또는 퍼센트(percent) 등 표시 , pattern : 직접 소수점 이하, 전체 자리수 지정-->
   <fmt:formatNumber value="789789.12345" /><br>  
   <!-- 789,789.123 기본패턴:소수점 최대 3자리 -->
   <fmt:formatNumber value="789789.12345" pattern="#,###.##"/><br>  
   <!-- 789,789.12 -->
   <fmt:formatNumber value="789789.123" pattern="0000,000,000.00000"/><br>
   
   <!-- 날짜 패턴에 대소문자 유의 : 일 dd, 월 MM , 분 mm , 시(12) hh , 시(24) HH -->
   <fmt:formatDate value="${now }" /><br>  
   <!-- Jan 20, 2023 *formatDate 도 var 로 변수 저장 -->
   <!-- parseDate의 pattern은 value 값의 형식을 알려줍니다. 문자열을 날짜 타입으로 캐스팅 -->
   <fmt:parseDate value="2022-11-03 20:14" var="datetime1" pattern="yyyy-MM-dd HH:mm"/> 
    현재시간과 날짜 : ${datetime1 }<br>  <!-- 출력결과 : Thu Nov 03 00:00:00 KST 2022 -->
   <fmt:formatDate value="${datetime1 }" type="date"/><br>  <!-- Jan 20, 2023 -->
   <fmt:formatDate value="${datetime1 }" type="time"/><br>  <!-- 10:35:29 AM -->
   <fmt:formatDate value="${datetime1 }" type="both"/><br>  <!-- Jan 20, 2023, 10:35:29 AM -->
   <fmt:formatDate value="${datetime1 }" pattern="yyyy-MM-dd HH:mm:ss"/><br> 
   <!-- 2022-11-03 20:14:00 시간이 24시 기준(대문자 HH) -->
   <fmt:formatDate value="${datetime1 }" pattern="yyyy-MM-dd a hh:mm:ss"/><br>
   <!-- 2022-11-03 PM 08:14:00 시간이 12시 기준(소문자 hh). a는 오전/오후 표시 -->
   
   <h3>문자열 메소드를 함수형태로 사용하기 : fn</h3> (태그가 아니며 el과 함께 사용합니다. 자바의 문자열 메소드와 상당부분 일치)<br>
      <c:set var="msg"  value="i am spring!!"/>
      length : ${fn:length(msg) }   <br>         <!-- 예상 : 13 -->
      indexOf : ${fn:indexOf(msg,"am") }  <br><!-- 예상 : 2 -->
      replace : ${fn:replace(msg,"spring","java") }<br>
      <!-- 특수문자 출력을 위해 사용. < &lt; &gt; 와 같이 기능이 정해진 문자를 출력 -->
      escapeXml : ${fn:escapeXml("<strong>테스트</strong>") }   
      <!-- fn 함수결과로 c:if 의 조건식으로 사용할 수 있습니다. --> 
</body>
</html>