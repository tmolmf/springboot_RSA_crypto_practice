package com.webstart.exam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class JSPVIewController {
	
	@RequestMapping(value="/")  
	public String root(HttpServletRequest request) {
        HttpSession session = request.getSession();
		System.out.println("login? "+session.getAttribute("login")); 
		if(session.getAttribute("login")==null)
		{
			return "redirect:RSA";
			}
        return "rootview";          // 실제 호출될 /WEB-INF/jsp/rootview.jsp       
    }
	
	//form 요청 테스트
	@RequestMapping(value="/formtest")
	public String formtest() {
		return "formtest";
	}
	
	//form 요청 수신
	@RequestMapping(value="/request") 
	public String request(HttpServletRequest request){ 
		System.out.println("제목:"+request.getParameter("title")); 
		System.out.println("내용:"+request.getParameter("content"));	
		return "formtest"; //formtest.jsp 로 리다이렉트
	}
}
