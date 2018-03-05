<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax 轮询</title>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<script type="text/javascript" src="${APP_PATH }/html/js/jquery-1.8.2.min.js" ></script>
</head>
<body>
	<!-- AJAX 轮询 -->
	<script type="text/javascript">
		var getting = {
			url:"${APP_PATH }/depts",
			type:"get",
			success:function(result){
				console.log(new Date() + " : " + result.tips);
			}	
		}
		
		//关键在这里，Ajax定时访问服务端，不断获取数据 ，这里是1秒请求一次。
		window.setInterval(function(){$.ajax(getting)},1000);

	</script>
</body>
</html>
