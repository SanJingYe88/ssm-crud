package it.ssm.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;

import it.ssm.entity.Dept;
import it.ssm.entity.Employee;

/**
 * 使用 Spring 测试模块提供的测试请求功能，测试 curd 请求的正确性.
 * Spring4 测试的时候，需要 servlet3.0 的支持
 */

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration		/* 添加这个注解,可以获取 springmvc 的 ioc 容器 */		
@ContextConfiguration(locations = { "classpath:Spring.xml","classpath:SpringMVC.xml" })		
									/* spring 配置文件 , SpringMVC 配置文件*/
public class SpringMVCTest {

	@Autowired
	WebApplicationContext context;		// 传入 Springmvc 的 ioc
	
	MockMvc mockMvc;	// 虚拟的 mvc请求,获取处理结果.
	
/*	@Test
	public void test() throws Exception {
		// 首先需要先进行初始化
		// 传入 Springmvc 的 ioc 获取 mockMvc
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
		// 如果是 get 请求,就使用 get("请求路径") 方法. 如果是 post 请求, 就使用 post("xxx") 方法, delete , put 也一样 .
		MockHttpServletRequestBuilder builder = MockMvcRequestBuilders.get("/test");
		//  如果请求有参数,则使用 param("参数名","参数值") 方法即可.
		MockHttpServletRequestBuilder param = builder.param("userName", "小白");
		// perform() 方法,可以模拟请求拿到返回值.需要传入 RequestBuilder 对象.
		ResultActions actions = mockMvc.perform(param);
		// 如果请求有返回值, 可以使用 addReturn() 方法获取到请求的返回值
		MvcResult result = actions.andReturn();
		MockHttpServletRequest request = result.getRequest();
		Dept dept = (Dept) request.getAttribute("dept");
		System.out.println(dept);
	}*/
	
	@Test
	public void testGetEmps() throws Exception {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
		MockHttpServletRequestBuilder builder = MockMvcRequestBuilders.get("/emps");
		MockHttpServletRequestBuilder param = builder.param("pn", "3");
		ResultActions actions = mockMvc.perform(param);
		MvcResult result = actions.andReturn();
		MockHttpServletRequest request = result.getRequest();
		//请求成功以后，请求域中会有 pageInfo 对象, 我们可以取出 pageInfo 进行验证分页是否正确.
		PageInfo<Employee> pageInfo = (PageInfo<Employee>) request.getAttribute("pageInfo");
		System.out.println(pageInfo);
        System.out.println("当前页码：" + pageInfo.getPageNum());
        System.out.println("总页码：" + pageInfo.getPages());
        System.out.println("每页显示的数量:" + pageInfo.getPageSize());
        System.out.println("当前页显示的数量:" + pageInfo.getSize());
        System.out.println("总记录数：" + pageInfo.getTotal());
        System.out.print("在页面需要连续显示的页码: ");
        int[] nums = pageInfo.getNavigatepageNums();
        for (int i : nums) {
            System.out.print(" " + i);
        }
        System.out.println();
        List<Employee> employees = pageInfo.getList();        // 获取所有数据
        System.out.println(employees);
	}
	
}
