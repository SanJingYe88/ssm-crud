<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax 长轮询</title>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<script type="text/javascript" src="${APP_PATH }/html/js/jquery-1.8.2.min.js" ></script>
</head>
<body>
	<!-- AJAX 长轮询 -->
	<script type="text/javascript">
		var getting = {
			url:"${APP_PATH }/depts",
			type:"get",
			success:function(result){
				console.log(new Date() + " : " + result.tips);
				// 关键在这里，回调函数内再次请求 Ajax
				$.ajax(getting);
			},
			// 当请求时间过长, (默认为60秒), 就再次调用 ajax 长轮询
			error:function(result){
				$.ajax(getting);
			}
		}
		
		$.ajax(getting);
	</script>
</body>
</html>
