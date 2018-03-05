package it.ssm.entity;

import java.util.Date;

import javax.validation.constraints.Future;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;

public class Employee {
    private Integer empId;

    @Pattern(regexp="(^[\u2E80-\u9FFF]{2,5}$)|(^[a-zA-Z0-9_-]{6,10}$)",
    		 message="用户名只能是2-5位中文或者6-10位英文和数字的组合.(来自后端校验)")
    private String empName;

    @NotBlank(message="员工性别不能为空.(来自后端校验)")				// 对于 String 类型, 使用 @NotBlank
    private String empGender;

    //@NotBlank(message="员工生日不能为空.(来自后端校验)")				// 其他类型好像也是使用 @NotBlank
	//@DateTimeFormat(pattern="yyyy/MM/dd")
    private Date empBirthday;

    @NotNull(message="员工所在部门不能为空.(来自后端校验)")			// 对于 基本类型, 使用 @NotNull
    private Integer deptId;	
    
    private Dept dept;		// 添加 Dept 的引用

    public Employee() {
	}
    
    public Employee(Integer empId, String empName, String empGender, Date empBirthday, Integer deptId) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.empGender = empGender;
		this.empBirthday = empBirthday;
		this.deptId = deptId;
	}

	public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getEmpGender() {
        return empGender;
    }

    public void setEmpGender(String empGender) {
        this.empGender = empGender == null ? null : empGender.trim();
    }

    public Date getEmpBirthday() {
        return empBirthday;
    }

    public void setEmpBirthday(Date empBirthday) {
        this.empBirthday = empBirthday;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

	public Dept getDept() {
		return dept;
	}

	public void setDept(Dept dept) {
		this.dept = dept;
	}

	@Override
	public String toString() {
		return "Employee [empId=" + empId + ", empName=" + empName + ", empGender=" + empGender + ", empBirthday="
				+ empBirthday + ", deptId=" + deptId + ", dept=" + dept + "]";
	}
}