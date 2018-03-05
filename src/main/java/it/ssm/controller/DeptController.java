package it.ssm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import it.ssm.entity.Dept;
import it.ssm.entity.Message;
import it.ssm.service.DeptService;

@Controller
public class DeptController {

	@Autowired
	DeptService deptService;
	
	// 查询所有的 Dept
	@RequestMapping("depts")
	@ResponseBody
	public Message getDepts(){
		System.out.println("DeptController.getDepts()");
		List<Dept> depts = deptService.getAll();
		Message message = Message.success().add("depts", depts);
		return message;
	}
}
