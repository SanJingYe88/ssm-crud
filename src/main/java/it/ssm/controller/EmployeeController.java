package it.ssm.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import it.ssm.dao.DeptMapper;
import it.ssm.entity.Employee;
import it.ssm.entity.Message;
import it.ssm.service.EmployeeService;

@Controller
public class EmployeeController {

	@Autowired
	DeptMapper deptMapper;
	
	@Autowired
	EmployeeService employeeService;
	
	@InitBinder
	public void initBinder(ServletRequestDataBinder binder){
		System.out.println("EmployeeController.initBinder()");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		CustomDateEditor sde = new CustomDateEditor(sdf, true);
		binder.registerCustomEditor(Date.class, sde);
	}
	
/*	@RequestMapping("/test")
	public String test(@RequestParam("userName") String userName, Model model){
		System.out.println(userName);
		
		Dept dept = deptMapper.selectByPrimaryKey(1);
		System.out.println(dept.getDeptName());
		
		model.addAttribute("dept",dept);
		return "index";
	}*/
	
/*    // 查询所有 Employee , 分页查询
	@RequestMapping("/emps")
    public String getEmps( @RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        System.out.println("请求参数 pn = " + pn);
		// 分页查询, 可以引入 PageHelper 分页插件
        // 在查询之前, 只需要调用 startPage() 方法即可. 
		// 参数1: 查询开始的页码 . 参数2:每页的大小.
        PageHelper.startPage(pn, 5);
        // startPage() 方法后面紧跟的这个查询就是一个分页查询.
        List<Employee> employees = employeeService.getAll();
        // 使用 pageInfo 包装查询后的结果, 只需要将 pageInfo 传给页面就行了.
        // pageInfo 封装了十分详细的分页信息, 包括有我们查询出来的数据, 传入连续显示的页数, .....
        // 参数1: 要显示的数据. 参数2: 页码下标连续显示几页.  
        PageInfo<Employee> page = new PageInfo<>(employees, 5);
        model.addAttribute("pageInfo", page);
        return "list";
    }*/

    // 查询所有 Employee , 分页查询, JSON
	@RequestMapping("/emps/{pn}")
	@ResponseBody
    public Message getEmps( @PathVariable(name = "pn") Integer pn) {
        System.out.println("请求参数 pn = " + pn);
        PageHelper.startPage(pn, 5);
        List<Employee> employees = employeeService.getAll();
        PageInfo<Employee> page = new PageInfo<>(employees, 5);
        Message message = Message.success().add("pageInfo", page);
        return message;
    }

	// 保存 Employee
	@RequestMapping(value="/emp",method={RequestMethod.POST})
	@ResponseBody
	public Message saveEmployee(@Valid Employee employee, BindingResult binding){
		System.out.println("saveEmployee :" + employee);
		
		if(binding.hasErrors()){		// 如果字段有发生错误
			// 存储发生错误的字段以及提示信息
			Map<String, Object> map = new HashMap<String, Object>();
			// 获取发生错误的字段
			List<FieldError> fieldErrors = binding.getFieldErrors();
			// 遍历
			for (FieldError fieldError : fieldErrors) {
				System.out.println("字段发生错误:" + fieldError.getField());
				System.out.println("错误消息:" + fieldError.getDefaultMessage());
				// 将错误的字段和提示信息保存到 map 中.
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Message.fail().add("fieldErrors", map);
		}
		// 字段没有发生错误
		employeeService.saveEmployee(employee);
		Message message = Message.success();
		return message;
	}
	
	// ajax 检查 empName 是否已经存在
	@RequestMapping("/checkUser")
	@ResponseBody
	public Message checkUser(String empName){
		boolean checkUser = employeeService.checkUser(empName);
		if(checkUser){		// 不存在
			return Message.success();
		}
		return Message.fail();
	}
	
	// 通过 id 获取 emp
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Message getEmpById(@PathVariable("id") Integer id){
		Employee employee = employeeService.getEmpById(id);
		return Message.success().add("emp", employee);
	}
	
	// 修改 emp
	@RequestMapping(value="/emp/{id}",method=RequestMethod.PUT)
	@ResponseBody
	public Message updateEmpById(Employee employee){
		System.out.println("修改后的 emp:" + employee);
		employeeService.updateEmp(employee);
		return Message.success();
	}
	
	// 删除单个员工
	@RequestMapping(value="/emp/{id}",method=RequestMethod.DELETE)
	@ResponseBody
	public Message deleteEmp(@PathVariable("id") Integer id){
		employeeService.deleteEmpById(id);
		return Message.success();
	}
	
	// 批量删除员工
	@RequestMapping(value="/emps/{ids}",method=RequestMethod.DELETE)
	@ResponseBody
	public Message deleteEmps(@PathVariable("ids") String ids){
		String[] id_array = ids.split("-");
		List<Integer> id_list = new ArrayList<>();
		for (String id : id_array) {
			id_list.add(Integer.parseInt(id));
		}
		employeeService.deleteEmpBatch(id_list);
		return Message.success();
	}
}
