package com.workit.employee.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.workit.employee.dao.EmployeeDao;
import com.workit.employee.model.dto.EmployeeUpdateInfo;
import com.workit.employee.model.vo.DepartmentVO;
import com.workit.employee.model.vo.JobVO;
import com.workit.member.model.dto.Department;
import com.workit.member.model.dto.Job;
import com.workit.member.model.dto.Member;
@Service
public class EmployeeServiceImpl implements EmployeeService{
	@Autowired
	private EmployeeDao dao;
	@Autowired
	private BCryptPasswordEncoder encoder;
	
	@Override
	public List<Department> selectDept() {
		return dao.selectDept();
	}

	@Override
	public List<Job> selectJob() {
		return dao.selectJob();
	}

	@Override
	public int insertEmployee(Map<String, Object> param) {
		param.put("password", encoder.encode("1234"));
		return dao.insertEmployee(param);
	}

	@Override
	public List<Member> selectMemberAll(Map<String, Object> param) {
		return dao.selectMemberAll(param);
	}

	@Override
	public int selectMemberCount() {
		return dao.selectMemberCount();
	}

	@Override
	public List<DepartmentVO> selectDeptCount(Map<String, Object> param) {
		return dao.selectDeptCount(param);
	}

	@Override
	public List<JobVO> selectJobCount(Map<String, Object> param) {
		return dao.selectJobCount(param);
	}

	@Override
	public int selectGradeCount(Map<String, Object> param) {
		return dao.selectGradeCount(param);
	}

	@Override
	public int insertDept(String deptName) {
		return dao.insertDept(deptName);
	}

	@Override
	public int deleteDept(String deptCode) {
		return dao.deleteDept(deptCode);
	}

	@Override
	public int updateDept(Map<String,Object> param) {
		return dao.updateDept(param);
	}

	@Override
	public int updateEmpInfo(Map<String, Object> param) {
		return dao.updateEmpInfo(param);
	}

	@Override
	public EmployeeUpdateInfo selectApprovEmp(String no) {
		return dao.selectApprovEmp(no);
	}

	@Override
	public int deleteApprov(String no) {
		return dao.deleteApprov(no);
	}

	@Override
	public int updateApprov(Map<String, Object> param) {
		int result=dao.updateEmployee(dao.selectApprovEmp(String.valueOf(param.get("no")))); //회원 테이블에 정보 업데이트 먼저 실행
		if(result>0) {
			return dao.updateApprov(param);			
		}else {
			return 0;
		}
	}

	@Override
	public int insertJob(Map<String, Object> param) {
		if(dao.selectJobByName((String)param.get("jobName"))!=null) {
			return -1;
		}else {
			return dao.insertJob(param);
		}
	}

	@Override
	public int deleteJob(String jobCode) {
		return dao.deleteJob(jobCode);
	}

	@Override
	public int updateJob(Map<String, Object> param) {
		if(dao.selectJobByName((String)param.get("jobName"))!=null) {
			return -1;
		}else {
			return dao.updateJob(param);			
		}
	}

	@Override
	public Member selectMemberByParam(Map<String, Object> param) {
		return dao.selectMemberByParam(param);
	}

	
	
	
	
}
