package com.spring.wefit.controller;

import java.io.IOException;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.spring.wefit.command.UserVO;
import com.spring.wefit.user.service.IUserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private IUserService service;
	
	// 회원가입 처리
	@PostMapping("/join")
	public String join(UserVO vo,RedirectAttributes ra) {
		System.out.println("회원가입 컨트롤러 요청"+vo.toString());
		service.join(vo);
		service.mailSendAuth(service.getInfo(vo.getMemberEmail()));
		ra.addFlashAttribute("msg","메일함을 확인해주세요");
		return "redirect:/";
	}
	
	// 유저 탈퇴했거나 휴면계정인 경우 복구 처리
	@PostMapping("/recovery")
	public String recovery(UserVO vo,RedirectAttributes ra) {
		System.out.println("/user/recovery: POST");
		System.out.println(vo.toString());
		service.recovery(vo.getMemberEmail());
		ra.addFlashAttribute("msg","복구가 완료되었습니다.");
		return "redirect:/";
	}
	
	// 인증링크 받아서 인증처리 
	@GetMapping("/auth/{nick}/{code}")
	public String auth(@PathVariable String nick, @PathVariable String code) {
		System.out.println("GET: 인증요청");
		System.out.println(nick);
		System.out.println(code);
		service.authUser(nick,code);
		
		return "redirect:/";
	}
	
	//이메일 중복 여부 확인
	@PostMapping("/emailChk")
	@ResponseBody
	public String emailChk(@RequestBody String email) {
		System.out.println(service.emailCheck(email));
		if((service.emailCheck(email) == 0)) {
			return "success";
		}
		return "duplicate";
	}
	// 닉네임 중복 여부 확인
	@PostMapping("/nickChk")
	@ResponseBody
	public String nickChk(@RequestBody String nick) {
		if(service.nickCheck(nick) == 0) {
			return "success";
		}
		return "duplicate";
		
	}
	
	
	// 로그인 요청
	@PostMapping("/login")
	public ModelAndView login(UserVO vo,
			HttpSession session, 
			HttpServletResponse response,
			HttpServletRequest request,
			RedirectAttributes ra) {
		
		System.out.println("/user/login:POST");
		System.out.println("param:"+vo.toString());
		
		UserVO login = service.getInfo(vo.getMemberEmail());
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();	
	
		if(login != null) {
			if(encoder.matches(vo.getMemberPasswd(), login.getMemberPasswd())) {
				if(login.getMemberEmailYN().equals("N")) {
					ra.addFlashAttribute("msg", "이메일 확인 필요");
					return new ModelAndView("redirect:/");
				} else if(login.getMemberHumanYN().equals("Y")||!(login.getMemberDelDate() == null)) {
					ra.addFlashAttribute("msg", "복구 필요");
					ra.addFlashAttribute("login", login);
					return new ModelAndView("redirect:/");
				}
				session.setAttribute("loginuser", login);
				long limitTime = 7*24*60*60; //7일동안 자동로그인
				System.out.println(vo.toString());
				if(vo.isAutoLoginCheck()) {
					Cookie logincookie = new Cookie("loginCookie", session.getId());
					logincookie.setPath("/");
					logincookie.setMaxAge((int) limitTime);
					response.addCookie(logincookie);
					
					long currentTime = System.currentTimeMillis() + (limitTime*1000);
					Date limitDate = new Date(currentTime);
					service.keepLogin(session.getId(), limitDate, login.getMemberEmail());
				}
				ra.addFlashAttribute("msg","로그인 성공!");
				
				String referer = request.getHeader("Referer"); // 헤더에서 이전 페이지를 읽는다.
				return new ModelAndView("redirect:"+ referer);
			}
			
		}
		ra.addFlashAttribute("msg", "이메일 또는 비밀번호가 맞지 않습니다.");
		
		String referer = request.getHeader("Referer"); // 헤더에서 이전 페이지를 읽는다.
		return new ModelAndView("redirect:"+ referer);
		
	}
	
	// 로그아웃 요청
	@GetMapping("/logout")
	public ModelAndView logout(HttpSession session, RedirectAttributes ra,
			HttpServletRequest request, HttpServletResponse response) throws IOException{
		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
		UserVO vo = (UserVO) session.getAttribute("loginuser");
		System.out.println("/user/logout: GET");
		
		if(session.getAttribute("loginuser") != null) {
			//session.invalidate();
			
			session.removeAttribute("loginuser");
			if(loginCookie != null) {
				loginCookie.setValue(null);
				loginCookie.setPath("/"); //쿠키 생성시 유효 url을 지정한 경우, 삭제할 때도 명시해 줍니다.
				loginCookie.setMaxAge(0);
				response.addCookie(loginCookie);
				System.out.println(vo.getMemberEmail());
				service.keepLogin("none",new Date(), vo.getMemberEmail());
			}
			ra.addFlashAttribute("msg","로그아웃 완료 되었습니다.");
		}
		String referer = request.getHeader("Referer"); // 헤더에서 이전 페이지를 읽는다.
		return new ModelAndView("redirect:"+ referer);
	}
	
	// 위치정보 등록 이벤트
	@PostMapping("/geoRegist")
	@ResponseBody
	public String geoRegist(@RequestBody UserVO vo) {
		System.out.println(vo.toString());
		double latitude = Math.round(vo.getMemberLatitude()*1000000)/1000000.0;
		double longitude = Math.round(vo.getMemberLongitude()*1000000)/1000000.0;
		vo.setMemberLatitude(latitude);
		vo.setMemberLongitude(longitude);
		System.out.println("위치값 조정 후 ");
		System.out.println(vo.toString());
		service.geoRegist(vo);
		return "success";
	}
	
	@PostMapping("/passwdEmailSend")
	@ResponseBody
	public String passwdEmailSend(@RequestBody String email) {
		UserVO vo = service.getInfo(email);
		if(vo == null) {
			return "none";
		} else {
			service.mailSendPasswdChange(vo);
			return "success";
		}
		
	}
	
	@GetMapping("/passwdChange/{memberNick}/{memberCode}")
	public String passwdChangeView(@PathVariable String memberNick, @PathVariable String memberCode,RedirectAttributes ra, Model model) {
		UserVO vo = new UserVO();
		vo.setMemberNick(memberNick);
		vo.setMemberCode(memberCode);
		System.out.println("/user/passwdChange:GET");
		System.out.println(vo);
		if(service.codeCheck(vo) != 1) {
			ra.addFlashAttribute("msg", "코드가 맞지 않습니다.");
			return "redirect:/";
		}
		model.addAttribute("nick", vo.getMemberNick());
		return "user/pwchange";
	}
	
	@PostMapping("/passwdChange")
	public String passwdChange(UserVO vo, RedirectAttributes ra) {
		service.passwdChange(vo);
		ra.addFlashAttribute("msg","패스워드가 정상적으로 변경되었습니다.");
		return "redirect:/";
	}
	@GetMapping("/mypage")
	public String myPageView() {
		return "user/mypage";
	}
	
	//탈퇴처리
	@PostMapping("/delUser")
	public String delUser(HttpSession session, RedirectAttributes ra,
			HttpServletRequest request, HttpServletResponse response)throws IOException {
		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
		UserVO vo = (UserVO) session.getAttribute("loginuser");
		System.out.println("/user/logout: GET");
		
		if(session.getAttribute("loginuser") != null) {
			//session.invalidate();
			
			session.removeAttribute("loginuser");
			if(loginCookie != null) {
				loginCookie.setValue(null);
				loginCookie.setPath("/"); //쿠키 생성시 유효 url을 지정한 경우, 삭제할 때도 명시해 줍니다.
				loginCookie.setMaxAge(0);
				response.addCookie(loginCookie);
				System.out.println(vo.getMemberEmail());
				service.keepLogin("none",new Date(), vo.getMemberEmail());
			}
			service.withdrawal(vo.getMemberEmail());
		}
		ra.addFlashAttribute("msg", "탈퇴가 완료되었습니다.");
		return "redirect:/";
	}
	
	@PostMapping("/modifyUser")
	@ResponseBody
	public String modifyUser(@RequestBody Map<String, Object> map) {
		
		String memberEmail = (String) map.get("memberEmail");
		String memberNick = (String) map.get("memberNick");
		String memberPasswd = (String) map.get("memberPasswd");
		String memberPhone = (String) map.get("memberPhone");
		boolean nickChk = (boolean) map.get("nickChk");
		
		if(!nickChk) {
			if(service.nickCheck(memberNick) == 1) {
				return "duplicate";
			}
		}
		
		UserVO vo = new UserVO();
		vo = service.getInfo(memberEmail);
		vo.setMemberNick(memberNick);
		vo.setMemberPasswd(memberPasswd);
		vo.setMemberPhone(memberPhone);
		
		service.modify(vo);
		
		return "success";
	}
		
}
