package com.spring.wefit.commons;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.spring.wefit.command.UserVO;

public class ManagerInteceptor extends HandlerInterceptorAdapter{
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		System.out.println("관리자 인터셉터 발동");
		HttpSession session = request.getSession();
		UserVO login = (UserVO) session.getAttribute("loginuser");
		
		
		if(login == null) {
			msgreturn(response, request);
			return false;
		}
		if(!login.getMemberManagerYN().equals("YES")) {
			
			msgreturn(response, request);
			return false;
		}
		return true;
	}
	
	private void msgreturn(HttpServletResponse response, HttpServletRequest request) {
		FlashMap flashMap = new FlashMap();
		flashMap.put("msg", "관리자만 접근 가능합니다!");
		FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
		flashMapManager.saveOutputFlashMap(flashMap, request, response);
		System.out.println("관리자 계정이 아닙니다.");
		String referer = (String)request.getHeader("REFERER"); // 이전페이지 url 가져오기
		System.out.println(referer);
		if(referer!=null) {
			try {
				response.sendRedirect(referer);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			try {
				response.sendRedirect("/wefit");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
