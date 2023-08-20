package com.workit.employee.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.workit.employee.mapper.EmployeeMapper;
import com.workit.employee.model.dto.EmployeeUpdateInfo;
import com.workit.employee.model.vo.DepartmentVO;
import com.workit.employee.model.vo.JobVO;
import com.workit.member.model.dto.Department;
import com.workit.member.model.dto.Job;
import com.workit.member.model.dto.Member;
@Repository
public class EmployeeDaoImpl implements EmployeeDao {
	@Autowired
	private EmployeeMapper mapper;
	
	@Override
	public List<Department> selectDept() {
		return mapper.selectDeptAll();
	}

	@Override
	public List<Job> selectJob() {
		return mapper.selectJobAll();
	}

	@Override
	public int insertEmployee(Map<String, Object> param) {
		return mapper.insertEmployee(param);
	}

	@Override
	public List<Member> selectMemberAll(Map<String, Object> param) {
		int cPage=(int)param.get("cPage");
		int numPerpage=(int)param.get("numPerpage");
		RowBounds rb=new RowBounds((cPage-1)*numPerpage,numPerpage);
		return mapper.selectMemberAll(param,rb);
	}

	@Override
	public int selectMemberCount() {
		return mapper.selectMemberCount();
	}

	@Override
	public List<DepartmentVO> selectDeptCount(Map<String, Object> param) {
		int cPage=(int)param.get("cPage");
		int numPerpage=(int)param.get("numPerpage");
		RowBounds rb=new RowBounds((cPage-1)*numPerpage,numPerpage);
		return mapper.selectDeptCount(rb);
	}

	@Override
	public List<JobVO> selectJobCount(Map<String, Object> param) {
		int cPage=(int)param.get("cPage");
		int numPerpage=(int)param.get("numPerpage");
		RowBounds rb=new RowBounds((cPage-1)*numPerpage,numPerpage);
		return mapper.selectJobCount(rb);
	}

	@Override
	public int selectGradeCount(Map<String, Object> param) {
		return mapper.selectGradeCount(param);
	}

	@Override
	public int insertDept(String deptName) {
		return mapper.insertDept(deptName);
	}

	@Override
	public int deleteDept(String deptCode) {
		return mapper.deleteDept(deptCode);
	}

	@Override
	public int updateDept(Map<String,Object> param) {
		return mapper.updateDept(param);
	}

	@Override
	public int updateEmpInfo(Map<String, Object> param) {
		return mapper.updateEmpInfo(param);
	}

	@Override
	public EmployeeUpdateInfo selectApprovEmp(String no) {
		return mapper.selectApprovEmp(no);
	}

	@Override
	public int deleteApprov(String no) {
		return mapper.deleteApprov(no);
	}

	@Override
	public int updateApprov(Map<String, Object> param) {
		return mapper.updateApprov(param);
	}

	@Override
	public int updateEmployee(EmployeeUpdateInfo approvEmpInfo) {
		return mapper.updateEmployee(approvEmpInfo);
	}

	@Override
	public Job selectJobByName(String jobName) {
		return mapper.selectJobByName(jobName);
	}

	@Override
	public int insertJob(Map<String, Object> param) {
		return mapper.insertJob(param);
	}

	@Override
	public int deleteJob(String jobCode) {
		return mapper.deleteJob(jobCode);
	}

	@Override
	public int updateJob(Map<String, Object> param) {
		return mapper.updateJob(param);
	}

	@Override
	public Member selectMemberByParam(Map<String, Object> param) {
		return mapper.selectMemberByParam(param);
	}
	
	
}
