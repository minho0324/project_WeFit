package com.spring.wefit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.wefit.command.DietBoardVO;
import com.spring.wefit.command.FreeBoardVO;
import com.spring.wefit.command.FreeReplyVO;
import com.spring.wefit.command.UserVO;
import com.spring.wefit.commons.CustomFileUpload;
import com.spring.wefit.commons.PageCreator;
import com.spring.wefit.commons.PageVO;
import com.spring.wefit.free.service.FreeReplyService;
import com.spring.wefit.free.service.IFreeBoardService;
import com.spring.wefit.free.service.IFreeReplyService;

@Controller
@RequestMapping("/freeBoard")
public class FreeBoardController {
	
	@Autowired
	private IFreeBoardService service;
	
	@Autowired
	private IFreeReplyService replyService;
	
	
	//목록 페이지 이동
	@GetMapping("/") 
	public String freeBoardListPage(Model model, PageVO vo) {
		System.out.println("/freeBoard/:GET");
		
		// 페이지 버튼 계산하기
		PageCreator pc = new PageCreator();
		
		pc.setPaging(vo);
		pc.setArticleTotalCount(service.getTotal(vo));
		vo.setCountPerPage(20);
		
		
		// 총 게시물 개수
		int contentTotal = service.getTotal(vo);
		System.out.println("총 게시글 수 : "+contentTotal );
		
		// 게시글 리스트 뽑기
		List<FreeBoardVO> list = service.getList(vo);
		for(FreeBoardVO d : list) {
			System.out.println(d.getFbReportCount());
		}
		//jsp에 전달할 값들
		model.addAttribute("freeList", list);
		model.addAttribute("page",pc.getPaging());
		model.addAttribute("pc",pc);	
		
		
		return "board/free/free_board";
	}
	
	// 쓰기 페이지 이동
	@GetMapping("/freeWrite") 
	public String freeBoardWritePage() {
		System.out.println("/freeBoard/freeWrite:GET");
		return "board/free/free_write";
	}
	
	// 글 쓰기 요청
	@PostMapping("/freeWrite")
	public String freeBoardWrite(MultipartFile[] fileName,HttpServletRequest request, FreeBoardVO vo, RedirectAttributes ra) {
	
		CustomFileUpload fileUp = new CustomFileUpload();
		String rootPath = request.getServletContext().getRealPath(""); // C:\Users\hwans\apache-tomcat-9.0.52\wtpwebapps\SpringWeFit\
		rootPath = rootPath + "resources\\..\\..\\..\\upload\\board\\free\\"+vo.getMemberNick()+"\\"; 
		List<String> fileNameList = fileUp.fileUpload(fileName, 5, rootPath);
		
		// 파일이름 받기
		vo.setFbImage1(fileNameList.get(0));
		vo.setFbRealImage1(fileNameList.get(1));
		
		vo.setFbImage2(fileNameList.get(2));
		vo.setFbRealImage2(fileNameList.get(3));
		
		vo.setFbImage3(fileNameList.get(4));
		vo.setFbRealImage3(fileNameList.get(5));
		
		vo.setFbImage4(fileNameList.get(6));
		vo.setFbRealImage4(fileNameList.get(7));
		
		vo.setFbImage5(fileNameList.get(8));
		vo.setFbRealImage5(fileNameList.get(9));
		
		int imgCount = 0;
		for(int i=0;i<10;i=i+2) {
			if(fileNameList.get(i)!=null) imgCount++;
		}
		for(String str : fileNameList) {
			System.out.println(str);
		}
		vo.setFbImageCount(imgCount);
		
		
		System.out.println(vo.toString());
		service.regist(vo);
		
		ra.addFlashAttribute("msg","정상 등록 되었습니다.");
		return "redirect:/freeBoard/?pageNum=1";
	}
	
	// 상세 페이지 이동
	@GetMapping("/freeDetail") 
	public String freeBoardDetailPage(@RequestParam int fbNum, PageVO pvo, Model model) {
		System.out.println("/freeBoard/freeDetail?fbNum="+fbNum+":GET");
		System.out.println(fbNum);
		service.updateViewCount(service.getContent(fbNum).getFbNum());
		System.out.println(service.getContent(fbNum).toString()); // 상세데이터 확인
		
		PageCreator pc = new PageCreator();
		pc.setPaging(pvo);
		System.out.println(pc.toString());

		
		model.addAttribute("content",service.getContent(fbNum));
		model.addAttribute("pc", pc);
		return "board/free/free_detail";
	}
	
	// 수정 페이지 이동
	@GetMapping("/freeModify")
	public String freeBoardModifyPage(@RequestParam int fbNum,PageVO page, Model model) {
		System.out.println("/freeBoard/freeModify:GET");
		model.addAttribute("content", service.getContent(fbNum));
		model.addAttribute("pc", page);
		
		return "board/free/free_modify";
	}
	
	// 글 수정하기
	@PostMapping("/freeModify")
	public String freeBoardModify(MultipartFile[] fileName,HttpServletRequest request, FreeBoardVO vo, RedirectAttributes ra) {
		System.out.println("/freeBoard/freeModify: POST");
		
		
		CustomFileUpload fileUp = new CustomFileUpload();
		String rootPath = request.getServletContext().getRealPath(""); // C:\Users\hwans\apache-tomcat-9.0.52\wtpwebapps\SpringWeFit\
		rootPath = rootPath + "resources\\..\\..\\..\\upload\\board\\free\\"+vo.getMemberNick()+"\\"; 
		
		FreeBoardVO origin = service.getContent(vo.getFbNum());
		
		if(origin.getFbRealImage1() != null) {
			fileUp.delete(origin.getFbRealImage1(), rootPath);
			System.out.println(origin.getFbRealImage1()+"삭제 완료");
		}
		if(origin.getFbRealImage2() != null) {
			fileUp.delete(origin.getFbRealImage2(), rootPath);
			System.out.println(origin.getFbRealImage2()+"삭제 완료");
		}
		if(origin.getFbRealImage3()!=null) {
			fileUp.delete(origin.getFbRealImage3(), rootPath);
			System.out.println(origin.getFbRealImage3()+"삭제 완료");
		}
		if(origin.getFbRealImage4()!=null) {
			fileUp.delete(origin.getFbRealImage4(), rootPath);
			System.out.println(origin.getFbRealImage4()+"삭제 완료");
		}
		if(origin.getFbRealImage5()!=null) {
			fileUp.delete(origin.getFbRealImage5(), rootPath);
			System.out.println(origin.getFbRealImage5()+"삭제 완료");
		}
		
		
		
		List<String> fileNameList = fileUp.fileUpload(fileName, 5, rootPath);
		
		// 파일이름 받기
		vo.setFbImage1(fileNameList.get(0));
		vo.setFbRealImage1(fileNameList.get(1));
		
		vo.setFbImage2(fileNameList.get(2));
		vo.setFbRealImage2(fileNameList.get(3));
		
		vo.setFbImage3(fileNameList.get(4));
		vo.setFbRealImage3(fileNameList.get(5));
		
		vo.setFbImage4(fileNameList.get(6));
		vo.setFbRealImage4(fileNameList.get(7));
		
		vo.setFbImage5(fileNameList.get(8));
		vo.setFbRealImage5(fileNameList.get(9));
		
		int imgCount = 0;
		for(int i=0;i<10;i=i+2) {
			if(fileNameList.get(i)!=null) imgCount++;
		}
		for(String str : fileNameList) {
			System.out.println(str);
		}
		vo.setFbImageCount(imgCount);
		
		
		service.update(vo);
		
		ra.addFlashAttribute("msg", "수정 완료되었습니다.");
		return "redirect:/freeBoard/freeDetail?fbNum="+vo.getFbNum();
	}
	
	
	// 글 삭제하기
	@PostMapping("/freeDelete")
	public String freeBoardDelete(FreeBoardVO vo, RedirectAttributes ra) {
		service.delete(vo.getFbNum());
		ra.addFlashAttribute("msg","삭제 완료되었습니다.");
		return "redirect:/freeBoard/";
		
	}
	
	// 글 좋아요 처리하기
	@PostMapping("/freeLikely")
	@ResponseBody
	public String freeBoardLikely(@RequestBody FreeBoardVO vo) {
		System.out.println("글 번호:"+vo.getFbNum());
		System.out.println("유저 번호"+vo.getMemberNum());
		if(service.checkLovely(vo) == 1) {
			service.deleteLovely(vo);
			return "duplicate";
		} else {
			service.insertLovely(vo);
			return "success";
		}
	}
	
	//좋아요 개수 출력
   @GetMapping("/{fbNum}")
   @ResponseBody
   public Map<String, Object> freeCountLike(@PathVariable int fbNum) {
	   
	   int count = service.countLike(fbNum);
	   
	   Map<String, Object> map = new HashMap<>();
	   map.put("count", count);
	   System.out.println(count);
	   return map;
   }
	
	// 글 신고 처리하기
	@PostMapping("/freeReport")
	@ResponseBody
	public String freeBoardReport(@RequestBody FreeBoardVO vo) {
		System.out.println("글 번호:"+vo.getFbNum());
		System.out.println("유저 번호"+vo.getMemberNum());
		if(service.checkReport(vo) == 1) {
			return "duplicate";
		} else {
			service.insertReport(vo);
			return "success";
		}
	}

	@PostMapping("/reportReset")
   public String reportReset(HttpSession session, FreeBoardVO vo, RedirectAttributes ra) {
	   UserVO user = (UserVO) session.getAttribute("loginuser");
	   if(user.getMemberManagerYN().equals("YES")) {
		   service.reportReset(vo.getFbNum());
		   return "redirect:/freeBoard/";
	   }
	   ra.addFlashAttribute("msg","관리자 권한이 아닙니다.");
	   return "redirect:/";
   }

	
}
