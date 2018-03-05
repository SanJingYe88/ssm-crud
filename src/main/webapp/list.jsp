<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
                <h4>SSM-CRUD</h4>
            </div>
        </div>
        <!-- 按钮 -->
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary" id="emp_add_model_btn">新增</button>
                <button class="btn btn-danger" id="emp_del_all_btn">批量删除</button>
            </div>
        </div>
        <br/>
        <!-- 显示表格数据 -->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="emp_table">
                	<thead>
	                    <tr>
							<th><input type="checkbox" id="check_all"/></th>
	                        <th>#</th>
	                        <th>EmpName</th>
	                        <th>EmpGender</th>
	                        <th>EmpBirthday</th>
	                        <th>DeptName</th>
	                        <th>操作</th>
	                    </tr>
                	</thead>
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
    
    
    <!-- 员工添加的模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal" id="emp_add_form">
	          <div class="form-group">
	            <label class="col-sm-2 control-label">EmpName</label>
	            <div class="col-sm-10">
	              <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
	              <span class="help-block"></span>
	            </div>
	          </div>
	          <div class="form-group">
	            <label class="col-sm-2 control-label">EmpGender</label>
	            <div class="col-sm-10">
	              <label class="radio-inline">
	                  <input type="radio" name="empGender" id="gender1_add_input" value="M" checked="checked"> 男
	                </label>
	                <label class="radio-inline">
	                  <input type="radio" name="empGender" id="gender2_add_input" value="F"> 女
	                </label>
	            </div>
	          </div>
			  <div class="form-group">
	            <label class="col-sm-2 control-label">EmpBirthday</label>
	            <div class="col-sm-10">
	              <input type="date" name="empBirthday" class="form-control" id="empBirthday_add_input">
	              <span class="help-block"></span>
	            </div>
	          </div>
	          <div class="form-group">
	            <label class="col-sm-2 control-label">DeptName</label>
	            <div class="col-sm-4">
	                <!-- 部门提交部门id即可 -->
	              <select class="form-control" name="deptId" >
	              </select>
	            </div>
	          </div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	<!-- 员工修改的模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工修改</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal" id="emp_update_form" enctype="application/x-www-form-urlencoded">
	          <div class="form-group">
	            <label class="col-sm-2 control-label">EmpName</label>
	            <div class="col-sm-10">
	              <p class="form-control-static" id="empName_update_static"></p>
	              <input type="hidden" id="emp_update_hidden_id" name="empId"/>	<!-- 保存 empId -->
	             <!--  <input type="hidden" name="_method" value="PUT"/> -->
	            </div>
	          </div>
	          <div class="form-group">
	            <label class="col-sm-2 control-label">EmpGender</label>
	            <div class="col-sm-10">
	              <label class="radio-inline">
	                  <input type="radio" name="empGender" id="gender1_update_input" value="M" checked="checked"> 男
	                </label>
	                <label class="radio-inline">
	                  <input type="radio" name="empGender" id="gender2_update_input" value="F"> 女
	                </label>
	            </div>
	          </div>
			  <div class="form-group">
	            <label class="col-sm-2 control-label">EmpBirthday</label>
	            <div class="col-sm-10">
	              <input type="date" name="empBirthday" class="form-control" id="empBirthday_update_input">
	              <span class="help-block"></span>
	            </div>
	          </div>
	          <div class="form-group">
	            <label class="col-sm-2 control-label">DeptName</label>
	            <div class="col-sm-4">
	                <!-- 部门提交部门id即可 -->
	              <select class="form-control" name="deptId" >
	              </select>
	            </div>
	          </div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	<!-- 显示员工数据 -->
	<script type="text/javascript">
	
		//	ajax 显示员工表以及分页信息
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
    			var checkbox = $("<td><input type='checkbox'class='check_item' /></td>");
    			var empId = $("<td></td>").append(this.empId);
    			var empName = $("<td></td>").append(this.empName);
    			var empGender = $("<td></td>").append(this.empGender);
    			var empBirthday = $("<td></td>").append(this.empBirthday);
    			var deptName = $("<td></td>").append(this.dept.deptName);
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                				.append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                				.append("&nbsp;&nbsp;编辑")
                				.attr("edit-emp",this.empId)
                var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                				.append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                				.append("&nbsp;&nbsp;删除")
                				.attr("del-emp",this.empId);
                var btn = $("<td></td>").append(editBtn).append("&nbsp;&nbsp;").append(delBtn);
    			
	    		$("<tr></tr>").append(checkbox).append(empId).append(empName)
	    					  .append(empGender).append(empBirthday).append(deptName)
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
    					+ "总共有 "+ result.data.pageInfo.total + " 条记录";
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
    
    <!-- 添加员工模态框 -->
    <script type="text/javascript">
        // 添加员工
    	$("#emp_add_model_btn").click(function(){
    		
       		// 先清空表单信息
    		$("#empAddModal form")[0].reset();	// jquery 没有重置表单的方法, 所以需要使用 DOM 提供的方法
			// 清空表单样式
			$("#empAddModal form").find("*").removeClass("has-error has-success");
			$("#empAddModal form").find(".help-block").text("");
    		
			console.log("清空表单数据");
			
            // 发送 ajax 请求，查出部门信息，显示在下拉列表中
            getDepts("#empAddModal select");
            
            // 弹出模态框
            $("#empAddModal").modal({
                backdrop:"static"                /*设置背景属性为 static*/
            });
    	})
    	
    	
    	// ajax 获取 depts
    	function getDepts(ele){
    		// 先清空原有的 Depts
    		$(ele).empty();
    		// 发送 ajax 获取 Depts
    		$.ajax({
    			url: "${APP_PATH }/depts",
    			method:"POST",
    			success:function(result){
    				var depts = result.data.depts;
    				$.each(depts,function(){
    					var option = $("<option></option>").attr("value",this.deptId).append(this.deptName);
    					$(ele).append(option);
    				})
    			}
    		})
    	}
    	
    </script>
    
    <!-- 保存员工 -->
	<script type="text/javascript">	
    	// 保存 Employee
    	$("#emp_save_btn").click(function(){
    		
    		console.log("表单开始校验");
    		
    		// 保存Employee 前, 先校验表单.
     		if(validate_emp_add_form() == false){
    			return false;	// 表单校验失败, 结束方法
    		}
    		
    		console.log("表单校验成功");
    		
    		// 保存 Employee 前, 先看 ajax 查询 empName 是否可用.
    		var ajax_va = $("emp_save_btn").attr("ajax_va");
    		if(ajax_va == "error"){
    			return false;
    		}
    		
    		console.log("ajax校验用户名可用");
    		
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
	    function validate_emp_add_form(){

	        // 校验 empName, 使用正则表达式校验
	        var empName = $("#empName_add_input").val();
	        var regName = /(^[\u2E80-\u9FFF]{2,5}$)|(^[a-zA-Z0-9_-]{6,10}$)/;	/*a-zA-Z0-9_- 可以是 6-10位, 或者是 2-5位的中文*/
	        if(regName.test(empName) == false){            /*校验失败*/
	            show_validate_msg("#empName_add_input", "error", "用户名只能是2-5位中文或者6-10位英文和数字的组合");
	            return false;
	        }else{            /*校验成功*/
	            show_validate_msg("#empName_add_input", "success", "");
	        };
	    	
	        // 校验 empBirthday, 使用正则表达式校验
	        var empBirthday = $("#empBirthday_add_input").val();
	        var regBirthday = /^(\d{4})-(\d{2})-(\d{2})$/;	
	        if(!regBirthday.test(empBirthday)){	/*校验失败*/
	            show_validate_msg("#empBirthday_add_input", "error", "未选择时间");
	            return false;
	        }else{	/*校验成功*/
	            show_validate_msg("#empBirthday_add_input", "success", "");
	        };
	        
	        console.log("empBirthday:" + empBirthday);
	        
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
	    
    
        // ajax 判断用户名是否可用
		$("#empName_add_input").change(function(){
	        // 校验 empName, 使用正则表达式校验
	        var empName = $("#empName_add_input").val();
	        var regName = /(^[\u2E80-\u9FFF]{2,5}$)|(^[a-zA-Z0-9_-]{6,10}$)/;	/*a-zA-Z0-9_- 可以是 6-10位, 或者是 2-5位的中文*/
			
	        if(regName.test(empName) == false){            /*校验失败*/
	            show_validate_msg("#empName_add_input", "error", "用户名只能是2-5位中文或者6-10位英文和数字的组合");
	            return false;
	        }
			
			$.ajax({
				url: "${APP_PATH }/checkUser",
				data: {"empName": this.value},
				type: "POST",
				success:function(result){
					if(result.code == 100){
						show_validate_msg("#empName_add_input","success","员工名可用");
						// 给 emp_save_btn 添加一个自定义属性, 标记员工名可用.
						$("emp_save_btn").attr("ajax_va","success");
					}else{
						show_validate_msg("#empName_add_input","error","员工名不可用");
						// 给 emp_save_btn 添加一个自定义属性, 标记员工名不可用.
						$("emp_save_btn").attr("ajax_va","error");
					}
				}
			})
		})
	</script>
		
	<!-- 员工修改模态框 -->
	<script type="text/javascript">
		// 按钮时动态创建的, 按钮创建之前就绑定了 click, 所以绑定不上.
		// 解决方式:
		// 1.可以在创建按钮的时候绑定点击事件.    
		// 2.使用 jQuery 中的 on() 给所有的编辑按钮添加点击事件.
		$(document).on("click",".edit_btn",function(){
			console.log("弹出员工修改模态框");
			// 发送 ajax 请求, 获取 Depts
			getDepts("#empUpdateModal select");
			
			// 发送 ajax 请求, 获取 emp
			var id = $(this).attr("edit-emp");
			getEmpById(id);
			
			// 弹出模态框
			$("#empUpdateModal").modal({
				backdrop:"static"                /*设置背景属性为 static*/
			});
		})
		
		// 根据 id 获取 emp 并显示在 模态框
		function getEmpById(id){
			$.ajax({
				url: "${APP_PATH }/emp/" + id,
				type: "GET",
				success:function(result){
					var emp = result.data.emp;
					$("#empName_update_static").text(emp.empName);
					$("#empUpdateModal :radio").val([emp.empGender]);	// 给 radio 赋值.
					$("#empUpdateModal select").val([emp.deptId]);		// 给 select 赋值
					$("#emp_update_hidden_id").val(emp.empId);	
					// 将后台传来的 毫秒值转为 标准时间
					var date = new Date(emp.empBirthday);
					// 获取 month
					var month = date.getMonth() + 1;
					month = month < 10 ? "0" + month : month; 
					// 获取 day
					var day = date.getDate();
					day = day < 10 ? "0" + day : day;
					// 获取年月日, 组装 2017-05-25.	type="date"的 input 输出的赋值, 必须是 2017-05-05 格式才行.
					var empBirthday = date.getFullYear() + "-" + month + "-" + day;
					$("#empBirthday_update_input").val(empBirthday);		// 给 type="date" 的 input 赋值
				}
			})
		}
	
	</script>
	
	<!-- 修改员工 -->
	<script type="text/javascript">	
	
		// 更改 emp
		$("#emp_update_btn").click(function(){
			console.log("修改员工按钮");
			// 更改 emp
			update_emp();
		})
		
		// 更改 emp
		function update_emp(){
			// 获取 id
			var id = $("#emp_update_hidden_id").val();
 			$.ajax({
				url: "${APP_PATH }/emp/" + id,
				type: "PUT",
				data: $("#emp_update_form").serialize(),
				success:function(result){
					console.log(result.tips);
				}
			})
		}
		
	</script>	
	
	<!-- 删除员工 -->
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
	
	<!-- 全选/全不选 -->
	<script type="text/javascript">
	
		// 给全选按钮添加点击事件 
		$("#check_all").click(function(){
			var checked = $(this).prop("checked");	// 获取全选框的状态,返回 boolean 类型
			$(".check_item").prop("checked",checked);	// 给每一行的选择框设置和全选框一样的选择状态.
		})
		
		// 给每一行的选择框添加点击事件
		$(document).on("click",".check_item",function(){
			// 如果选择框被选中的数量  == 每一页的选择框的数量,(也就是每一行的选择框都选中了),就让全选框也被选中.
			var checked = $(".check_item:checked").length;
			var sum = $(".check_item").length;
			if(checked == sum){
				$("#check_all").prop("checked",true);
			}else{
				$("#check_all").prop("checked",false);
			}
		})
		
	</script>
	
	<!-- 批量删除 -->
	<script type="text/javascript">
		// 给批量删除按钮添加点击事件
		$("#emp_del_all_btn").click(function(){
			if($(".check_item:checked").length <= 0){
				alert("未选择员工");
				return false;
			}
			
			var ids = "";
			var names = "";
			
			// 对被选中的选择框进行遍历
			$(".check_item:checked").each(function(index,item){
				var id = $(item).parents("tr").find("td:eq(1)").text();
				var name = $(item).parents("tr").find("td:eq(2)").text()
				ids = ids + "-" + id;
				names = names + "," + name;
			})
			
			ids = ids.substring(1,ids.length);
			names = names.substring(1,names.length);
			
			if(confirm("确定删除 " + names + " 吗?")){
				// 确定, 发送 ajax 请求
				$.ajax({
					url: "${APP_PATH }/emps/" + ids,
					type: "DELETE",
					success:function(result){
						alert(result.tips);
						// 刷新当前页面
						get_data($(".pagination .active").text());
					}
				})
			}
		})
	</script>
	
</body>
</html>
