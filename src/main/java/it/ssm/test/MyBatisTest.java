package it.ssm.test;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import it.ssm.dao.DeptMapper;
import it.ssm.dao.EmployeeMapper;
import it.ssm.entity.Dept;
import it.ssm.entity.Employee;
import it.ssm.entity.EmployeeExample;
import it.ssm.service.EmployeeService;

@RunWith(SpringJUnit4ClassRunner.class)		/* 指定使用 Spring 提供的单元测试模块来进行测试 */
@ContextConfiguration(locations={"classpath:Spring.xml"})	/*指定Spring配置文件的位置*/
public class MyBatisTest {

	@Autowired	/* 使用 @autowired 注解注入要使用的组件 */
	DeptMapper deptMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlSession;
	
	@Autowired
	EmployeeService employeeService;
	
/*	@Test
	public void testInsertDept(){
		Dept dept = new Dept();
		dept.setDeptName("开发部");
		deptMapper.insert(dept);
	}*/
	
/*	@Test
	public void testInsertEmployee(){
		Employee employee = new Employee();
		employee.setEmpName("阿根");
		employee.setEmpGender("F");
		employee.setEmpBirthday(new Date());
		employee.setDeptId(1);
		employeeMapper.insertSelective(employee);
	}*/
	
/*	@Test
	public void testInserts(){
        //批量插入多个员工, 批量, 使用可以执行批量操作的 sqlSession
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for(int i = 0; i < 50; i++){
            String uuid = UUID.randomUUID().toString().substring(0,5)+i;
            mapper.insertSelective(new Employee(null, uuid, "M", new Date(), 1));
        }
        System.out.println("批量完成");
	}*/
	
/*	@Test
	public void testGet(){		// 测试获取
		Employee employee = employeeMapper.selectByPrimaryKey(1001);
		System.out.println(employee);
	}*/
	
/*	@Test
	public void testGetAll(){
		List<Employee> employees = employeeService.getAll();
		System.out.println(employees.size());
	}*/
	
/*	@Test
	public void testPageHelper(){
		PageHelper.startPage(5,10);
		List<Employee> employees = employeeService.getAll();
		PageInfo<Employee> pageInfo = new PageInfo<>(employees, 6);
		System.out.println(pageInfo);
	}*/
	
	@Test
	public void testSelectByExampleWithDept(){
		List<Employee> employees = employeeMapper.selectByExampleWithDept(null);
		System.out.println(employees.get(0).toString());
	}
}
