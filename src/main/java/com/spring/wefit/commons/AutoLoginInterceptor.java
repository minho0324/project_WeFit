package com.spring.wefit.commons;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.spring.wefit.command.UserVO;
import com.spring.wefit.user.service.IUserService;

public class AutoLoginInterceptor extends HandlerInterceptorAdapter {

	
	@Autowired
	private IUserService service;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		System.out.println("자동 로그인 인터셉션 발동");
		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
		
		HttpSession session = request.getSession();
		if(loginCookie != null) {
			
			UserVO login = service.getUserWithSessionId(loginCookie.getValue());
			if(login != null) {
				session.setAttribute("loginuser", login);
			}
			
		}
		return true;
	}
	
}
