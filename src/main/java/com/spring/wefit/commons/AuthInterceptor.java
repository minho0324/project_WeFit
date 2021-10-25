package com.spring.wefit.commons;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.spring.wefit.command.UserVO;
import com.spring.wefit.course.service.ICourseBoardService;
import com.spring.wefit.course.service.ICourseReplyService;
import com.spring.wefit.diet.service.IDietBoardService;
import com.spring.wefit.diet.service.IDietReplyService;
import com.spring.wefit.free.service.IFreeBoardService;
import com.spring.wefit.free.service.IFreeReplyService;
import com.spring.wefit.market.service.IMarketBoardService;
import com.spring.wefit.market.service.IMarketReplyService;
import com.spring.wefit.noticeboard.service.INoticeBoardService;
import com.spring.wefit.noticeboard.service.INoticeReplyService;
import com.spring.wefit.placeboard.service.IPlaceBoardService;
import com.spring.wefit.placeboard.service.IPlaceReplyService;

public class AuthInterceptor extends HandlerInterceptorAdapter {
	/////////////게시글 서비스 등록///////////////////
	@Autowired
	private ICourseBoardService courseBoardService;
	
	@Autowired
	private IDietBoardService dietBoardService;
	
	@Autowired
	private IFreeBoardService freeBoardService;
	
	@Autowired
	private IMarketBoardService marketBoardService;
	
	@Autowired
	private INoticeBoardService noticeBoardService;
	
	@Autowired
	private IPlaceBoardService placeBoardService;
	
	/////////////댓글 서비스 등록///////////////////
	@Autowired
	private ICourseReplyService courseReplyService;
	
	@Autowired
	private IDietReplyService dietReplyService;
	
	@Autowired
	private IFreeReplyService freeReplyService;
	
	@Autowired
	private IMarketReplyService marketReplyService;
	
	@Autowired
	private INoticeReplyService noticeReplyService;
	
	@Autowired
	private IPlaceReplyService placeReplyService;
	
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		System.out.println("권한 인터셉터 발동");
		HttpSession session = request.getSession();
		UserVO login = (UserVO) session.getAttribute("loginuser");
		
		String cbNum = request.getParameter("cbNum");
		String crNum = request.getParameter("crNum");
		
		String dbNum = request.getParameter("dbNum");
		String drNum = request.getParameter("drNum");
		
		String fbNum = request.getParameter("fbNum");
		String frNum = request.getParameter("frNum");
		
		String mbNum = request.getParameter("mbNum");
		String mrNum = request.getParameter("mrNum");
		
		String nbNum = request.getParameter("nbNum");
		String nrNum = request.getParameter("nrNum");
		
		String pbNum = request.getParameter("pbNum");
		String prNum = request.getParameter("prNum");
		
		if(login == null) { // 로그인 안됨
			msgreturn(response, request, "로그인 후 이용해주세요");
			return false;
		} else if(login.getMemberManagerYN().equals("YES")) { // 관리자 권한 요청
			System.out.println("관리자 권한으로 접근했습니다.");
			return true;
		} else if(request.getParameter("memberNum") == null && request.getParameter("memberNick") == null) { // 수정페이지 또는 새 글 쓰기 요청
			
			if(cbNum !=null) { // 강의 게시글
				if(login.getMemberNum() == 
						courseBoardService.getContent(Integer.parseInt(cbNum)).getMemberNum()) {
					System.out.println("강의 게시글 수정 접근");
					return true;
				}
				msgreturn(response, request, "본인글만 수정 가능합니다.");
				return false;
			} else if(crNum !=null) { // 강의 댓글
				if(login.getMemberNum() == 
						courseReplyService.getContent(Integer.parseInt(crNum)).getMemberNum()) {
					System.out.println("강의 댓글 수정 접근");
					return true;
				}
				msgreturn(response, request, "본인댓글만 수정 가능합니다.");
				return false;
				
			} else if(dbNum !=null) { // 식단 게시글
				if(login.getMemberNum() == 
						dietBoardService.getContent(Integer.parseInt(dbNum)).getMemberNum()) {
					System.out.println("식단 게시글 수정 접근");
					return true;
				}
				msgreturn(response, request, "본인글만 수정 가능합니다.");
				return false;
				
			} else if(drNum !=null) {
				if(login.getMemberNum() == 
						dietReplyService.getContent(Integer.parseInt(drNum)).getMemberNum()) {
					System.out.println("식단 댓글 수정 접근");
					return true;
				}
				msgreturn(response, request, "본인글만 수정 가능합니다.");
				return false;
			} else if(fbNum !=null) {
				if(login.getMemberNum() == 
						freeBoardService.getContent(Integer.parseInt(fbNum)).getMemberNum()) {
					System.out.println("자유 게시글 수정 접근");
					return true;
				}
				msgreturn(response, request, "본인글만 수정 가능합니다.");
				return false;
				
			} else if(frNum !=null) {
				if(login.getMemberNum() == 
						freeReplyService.getContent(Integer.parseInt(frNum)).getMemberNum()) {
					System.out.println("자유 댓글 수정 접근");
					return true;
				}
				msgreturn(response, request, "본인글만 수정 가능합니다.");
				return false;
			} else if(mbNum !=null) {
				if(login.getMemberNum() == 
						marketBoardService.getContent(Integer.parseInt(mbNum)).getMemberNum()) {
					System.out.println("장터 게시글 수정 접근");
					return true;
				}
				msgreturn(response, request, "본인글만 수정 가능합니다.");
				return false;
			} else if(mrNum !=null) {
				if(login.getMemberNum() == 
						marketReplyService.getContent(Integer.parseInt(mrNum)).getMemberNum()) {
					System.out.println("장터 댓글 수정 접근");
					return true;
				}
				msgreturn(response, request, "본인글만 수정 가능합니다.");
				return false;
			} else if(nbNum !=null) {
				if(login.getMemberNum() == 
						noticeBoardService.getContent(Integer.parseInt(nbNum)).getMemberNum()) {
					System.out.println("공지사항 게시글 수정 접근");
					return true;
				}
				msgreturn(response, request, "본인글만 수정 가능합니다.");
				return false;
			} else if(nrNum !=null) {
				if(login.getMemberNum() == 
						noticeReplyService.getContent(Integer.parseInt(nrNum)).getMemberNum()) {
					System.out.println("공지사항 댓글 수정 접근");
					return true;
				}
				msgreturn(response, request, "본인글만 수정 가능합니다.");
				return false;
			} else if(pbNum !=null) {
				if(login.getMemberNum() == 
						placeBoardService.getContent(Integer.parseInt(pbNum)).getMemberNum()) {
					System.out.println("장소 게시판 수정 접근");
					return true;
				}
				msgreturn(response, request, "본인글만 수정 가능합니다.");
				return false;
			} else if(prNum !=null) {
				if(login.getMemberNum() == 
						placeReplyService.replyGetContent(Integer.parseInt(prNum)).getMemberNum()) {
					System.out.println("장소 게시판 수정 접근");
					return true;
				}
				msgreturn(response, request, "본인글만 수정 가능합니다.");
				return false;
			} else {
				System.out.println("새 글 쓰기 접근");
				return true;
			}
			
			
			
			
			
//			System.out.println("새 글 쓰기 접근");
//			return true;
		} else { // 수정 및 삭제 요청
			if(request.getParameter("memberNum")!=null) {
				if(login.getMemberNum() == Integer.parseInt(request.getParameter("memberNum"))) {
					System.out.println("수정권한 맞음");
					return true;
				} else {
					msgreturn(response, request, "권한이 맞지 않습니다.");
					return false;
				}
			} else {
				if(login.getMemberNick().equals(request.getParameter("memberNick"))) {
					System.out.println("수정권한 맞음");
					return true;
				} else {
					msgreturn(response, request, "권한이 맞지 않습니다.");
					return false;
				}
			}
			
		}
	}
	private void msgreturn(HttpServletResponse response, HttpServletRequest request, String msg) {
		FlashMap flashMap = new FlashMap();
		flashMap.put("msg", msg);
		FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
		flashMapManager.saveOutputFlashMap(flashMap, request, response);
		
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
