package it.ssm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.ssm.dao.DeptMapper;
import it.ssm.entity.Dept;

@Service
public class DeptService {

	@Autowired
	DeptMapper deptMapper;
	
	public List<Dept> getAll(){
		return deptMapper.selectByExample(null);
	}
}
