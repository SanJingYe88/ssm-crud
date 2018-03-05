package it.ssm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.ssm.dao.EmployeeMapper;
import it.ssm.entity.Employee;
import it.ssm.entity.EmployeeExample;
import it.ssm.entity.EmployeeExample.Criteria;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;
	
	// 获取所有的 Employee
	public List<Employee> getAll(){
		EmployeeExample example = new EmployeeExample();	// 设置查询条件
		example.setOrderByClause("emp_id asc");				// 查询条件  emp_id asc
		return employeeMapper.selectByExampleWithDept(example);	/* 传入查询条件, 如果没有, 传入 null 即可 */
	}

	// 保存 Employee
	public void saveEmployee(Employee employee) {
		employeeMapper.insertSelective(employee);
	}

	// 查询指定 empName 是否存在
	// true : 不存在.  false: 存在.
	public boolean checkUser(String empName) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);			// 添加查询条件
		long count = employeeMapper.countByExample(example);		// 根据条件, 查询数量
		return count == 0;
	}

	// 根据 id 获取 emp
	public Employee getEmpById(Integer id) {
		return employeeMapper.selectByPrimaryKey(id);
	}

	// 更新 emp
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	// 删除员工,根据id
	public void deleteEmpById(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}

	// 批量删除员工, 根据 id
	public void deleteEmpBatch(List<Integer> id_list) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		// delete from xxx where emp_id in(1,2,3)
		criteria.andEmpIdIn(id_list);
		employeeMapper.deleteByExample(example);
	}
}
