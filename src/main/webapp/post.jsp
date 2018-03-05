<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>帖子详情</title>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<script type="text/javascript" src="${APP_PATH }/html/js/jquery-1.8.2.min.js" ></script>
<script type="text/javascript" src="${APP_PATH }/html/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<link href="${APP_PATH }/html/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" >
</head>
<body>

	<!-- 搭建显示页面 -->
    <div class="container">
        <!-- 标题 -->
        <div class="row">
            <div class="col-md-12">
                <h4>帖子标题</h4>
            </div>
        </div>
        <!-- 按钮 -->
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary" id="reply_add_btn">回复该贴</button>
                <button class="btn btn-primary" id="only_see_model_btn">只看楼主</button>
            </div>
        </div>
        <br/>
        <!-- 显示表格数据 -->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="emp_table">
                	<tbody>
                	</tbody>
                </table>
            </div>
        </div>

        <!-- 显示分页信息 -->
        <div class="row">
            <!--分页文字信息  -->
            <div class="col-md-6" id="page_info_area"></div>
            <!-- 分页条信息 -->
            <div class="col-md-6" id="page_nav_area">
            </div>
        </div>
    </div>
    
    

    
    
	<!-- 显示帖子数据 -->
	<script type="text/javascript">
	
		//	ajax 显示帖子以及分页信息
		$(function(){
			
			// 页面加载完成以后，直接去发送 ajax 请求, 获取到分页数据
			get_data(1);	// 页面加载, 获取第1页的数据
		})
    
    	// 获取指定 pageNum 的数据
	    function get_data(pageNum){
    		console.log("调用了 get_data() 方法");
	        $.ajax({
	            url: "${APP_PATH }/emps/" + pageNum,
	            type:"POST",
	            success:function(result){
	                // 1.解析并显示员工数据
	                build_emps_table(result);
					// 2.解析并显示分页信息
	                build_page_info(result);
	                // 3.解析并显示分页条数据
	                build_page_nav(result);
	            }
	        });
	    }
    	
    	// 1.解析并显示员工数据
    	function build_emps_table(result){
    		// 先清空 员工表 原有数据
    		$("#emp_table tbody").empty();
    		// 添加新数据
    		var emps = result.data.pageInfo.list;
    		$.each(emps,function(){
    			var empName = $("<td></td>").append(this.empName);
    			var empBirthday = $("<td></td>").append(this.empBirthday);
    			var deptName = $("<td></td>").append(this.dept.deptName);
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                				.append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                				.append("&nbsp;&nbsp;回复此楼")
                				.attr("edit-emp",this.empId)
                var btn = $("<td></td>").append(editBtn).append("&nbsp;&nbsp;");
    			
	    		$("<tr></tr>").append(empName).append(empBirthday).append(deptName)
	    					  .append(btn)
	    					  .appendTo($("#emp_table tbody"));
    		})
    	}

    	// 2.解析并显示分页信息
    	function build_page_info(result){
    		// 先清空原有的分页信息
            $("#page_info_area").empty();
    		// 添加新的分页信息
    		var info = "当前在第 " + result.data.pageInfo.pageNum + " 页,"
    					+ "总共有 " + result.data.pageInfo.pages + " 页,"
    					+ "总共有 "+ result.data.pageInfo.total + " 条回复";
            $("#page_info_area").append(info);
    	}
    	
    	// 3.解析并显示分页条
        function build_page_nav(result){
    		// 先清空原有的分页条
    		$("#page_nav_area").empty();
    		
    		// 将使用次数多的数据提取出来
    		var rdp_pageNum = result.data.pageInfo.pageNum;		// 当前页码
    		var rdp_navigatepageNums = result.data.pageInfo.navigatepageNums;	// 连续显示页码
    		var rdp_pages = result.data.pageInfo.pages;			// 总页码
    		
            // 构建分页条
            var ul = $("<ul></ul>").addClass("pagination");
            
            // 如果 当前页码 > 1 时, 添加 首页 和 上一页 元素
            if(rdp_pageNum > 1){
	            //构建 首页 元素
	            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
	            //构建 上一页 元素
	            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
            	// 给 首页 和 上一页 添加点击事件
            	firstPageLi.click(function(){
                	get_data(1);
                })
            	prePageLi.click(function(){
                	get_data(rdp_pageNum - 1);
                })
	            // 添加 首页 和 前一页 元素
	            ul.append(firstPageLi).append(prePageLi);
            }

            // 遍历给 ul 中添加 页码 元素
            $.each(rdp_navigatepageNums, function(index,item){
                // 构建 数字页码 元素
                var numLi = $("<li></li>").append($("<a></a>").append(item));
                if(rdp_pageNum == item){	// 如果当前页码是正在遍历的页码
                	numLi.addClass("active");
                }
                // 给 数字页码 添加点击事件
                numLi.click(function(){
                	get_data(item);
                })
                ul.append(numLi);
            });

            // 如果 当前页码 < 最大页码 时, 添加 下一页 和 末页 元素.
            if(rdp_pageNum < rdp_pages){
            	 //构建 下一页 元素
                var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
                //构建 末页 元素
                var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
            	// 给 下一页 和 末页  添加点击事件
            	nextPageLi.click(function(){
                	get_data(rdp_pageNum + 1);
                })
            	lastPageLi.click(function(){
                	get_data(result.data.pageInfo.pages);
                })
	            // 添加 下一页 和 末页 元素
	            ul.append(nextPageLi).append(lastPageLi);
            }
            
            // 把  分页条 ul 加入到 nav
            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");
    	}
    	
	</script>
    
    
	<!-- 回复本帖 -->
    <script type="text/javascript">
    
    	$("#reply_add_btn").click(function(){
    		var reply_add_div = $("<div></div>").append("<textarea >你好</textarea>");
    		$("#emp_table").append(reply_add_div);
    	})
    
    </script>
    
    <!-- 回复 -->
	<script type="text/javascript">	
	
    	// 保存回复
    	$("#post_save_btn").click(function(){
    		console.log("表单开始校验");
    		
    		// 保存新帖前, 先校验表单.
     		if(validate_post_add_form() == false){
    			return false;	// 表单校验失败, 结束方法
    		}
    		
    		console.log("表单校验成功");
    		
    		$.ajax({
    			url: "${APP_PATH }/emp",
    			data: $("#emp_add_form").serialize(),
    			type: "POST",
    			success:function(result){
    				alert(result.tips);
    				if(result.code == 100){
	    				$("#empAddModal").modal("hide");	// 处理成功,关闭模态框
	    				get_data(999999);	// 前往最后一页, 传给一个很大的值,pageHelper 会帮我们处理.
    				}else{
    					// 对后端传来的 数据进行遍历, 获取发生了错误的字段, 以及对应的提示信息
    					for(var key in result.data.fieldErrors){
    						var value = result.data.fieldErrors[key];
    						var ele = "#" + key + "_add_input";
    						// 显示校验结果的提示信息
    						show_validate_msg(ele,"error",value);
    					}
    				}
    			}
    		})
    	})
    
    
	    // 校验表单数据
	    function validate_post_add_form(){

	        // 校验 postTitle
	        var postTitle = $("#postTitle_add_input").val();
	        
	        if(postTitle.trim().length <= 0){            /*校验失败*/
	            show_validate_msg("#postTitle_add_input", "error", "帖子标题不能为空");
	            return false;
	        }else{            /*校验成功*/
	            show_validate_msg("#postTitle_add_input", "success", "");
	        };
	        if(postTitle.trim().length > 50){            /*校验失败*/
	            show_validate_msg("#postTitle_add_input", "error", "帖子标题不能超过50个字符");
	            return false;
	        }else{            /*校验成功*/
	            show_validate_msg("#postTitle_add_input", "success", "");
	        };
	    	
	        return true;
	    }

	    // 显示校验结果的提示信息
        function show_validate_msg(ele,status,msg){		// 要校验的元素, 校验的状态, 校验的提示信息
            // 先清除当前元素的之前的校验状态
            $(ele).parent().removeClass("has-success has-error");  /* 移除多个类, 用空格表示 或者 */
            $(ele).next("span").text("");
            
            if("success" == status){
                $(ele).parent().addClass("has-success");	/* 校验成功, 给输入框所在的元素的父元素添加 has-success 样式*/
                $(ele).next("span").text(msg);
            }else if("error" == status){
                $(ele).parent().addClass("has-error");	/* 校验失败, 给输入框所在的元素的父元素添加 has-error 样式*/
                $(ele).next("span").text(msg);
            }
        }
	    
	</script>
			
	
	<!-- 删除回复 -->
	<script type="text/javascript">
		
		// 给每一行的员工删除按钮添加点击事件
		$(document).on("click",".delete_btn",function(){
			var empId = $(this).attr("del-emp");
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			if(confirm("确认删除 " + empName + " 吗?")){
				// 确认, 发送 ajax 请求
				$.ajax({
					url: "${APP_PATH }/emp/" + empId,
					type: "DELETE",
					success:function(result){
						alert(result.tips);
						// 刷新当前页面
						var pageNum = $("#page_nav_area .pagination .active").text();	// 获取当前页面的页码
    					get_data(pageNum);
					}
				})
			}
		})
	
	</script>
	

	
</body>
</html>
