package com.workit.main.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.workit.approve.model.service.ApproveService;
import com.workit.employee.service.EmployeeService;

@Controller
public class MainController {
	@Autowired
	private ApproveService service;

	@Autowired
	private EmployeeService eservice;

	@Autowired
	private ObjectMapper mapper;
	
	@RequestMapping("/") // 메인페이지
	public String mainPage(Model m) {

		m.addAttribute("a","a");
		return "/";
	}
}
