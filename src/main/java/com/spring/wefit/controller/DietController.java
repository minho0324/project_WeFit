package com.spring.wefit.controller;

import java.util.List;

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

import com.spring.wefit.command.CourseBoardVO;
import com.spring.wefit.command.DietBoardVO;
import com.spring.wefit.command.UserVO;
import com.spring.wefit.commons.CustomFileUpload;
import com.spring.wefit.commons.PageCreator;
import com.spring.wefit.commons.PageVO;
import com.spring.wefit.diet.service.IDietBoardService;

@Controller
@RequestMapping("/dietBoard")
public class DietController {
	
	@Autowired
	private IDietBoardService service;

	
	//글 목록전체보기
	@GetMapping("/dietList") 
	public String dietList(Model model, PageVO vo, DietBoardVO VO) {
		System.out.println("/board/dietList: GET 글 목록 전체보기!!");
		
		PageCreator dpc = new PageCreator();
		vo.setCountPerPage(9);
		dpc.setPaging(vo);
		dpc.setArticleTotalCount(service.getTotal(vo));
		System.out.println("페이지 정보: " + dpc);
		
		//총 게시물 개수
		int contentTotal = service.getTotal(vo);
		System.out.println("총 게시글 수: " + contentTotal);
		
		
		//게시글 리스트 뽑기
		List<DietBoardVO> list = service.getList(vo);
		System.out.println("list: " + list);
		
		//jsp에 전달 할 값들
		model.addAttribute("dietList", list);
		model.addAttribute("paging", dpc.getPaging());
		model.addAttribute("dpc" , dpc);
		
		return "/board/diet/diet_board";
	}

	//글쓰기 화면 이동처리
	@GetMapping("/dietWrite")
	public String dietWrite() {
		System.out.println("/diet_Write 글쓰기 화면 이동!!");
		return "/board/diet/diet_write";
	}
	
	//글 등록
	@PostMapping("/dietWrite")
	public String dietWrite(MultipartFile[] fileName, HttpServletRequest request, DietBoardVO vo, RedirectAttributes ra) {
		
		
		System.out.println("/board/dietWrite : 파일 업로드!");
		CustomFileUpload fileUp = new CustomFileUpload();
		String rootPath = request.getServletContext().getRealPath(""); // C:\Users\hwans\apache-tomcat-9.0.52\wtpwebapps\SpringWeFit\
		rootPath = rootPath + "resources\\..\\..\\..\\upload\\board\\diet\\"+vo.getMemberNick()+"\\"; 
		
		List<String> fileNameList = fileUp.fileUpload(fileName, 5, rootPath);
		
		// 파일이름 받기
		vo.setDbImage1(fileNameList.get(0));
		vo.setDbRealImage1(fileNameList.get(1));
		
		vo.setDbImage2(fileNameList.get(2));
		vo.setDbRealImage2(fileNameList.get(3));
		
		vo.setDbImage3(fileNameList.get(4));
		vo.setDbRealImage3(fileNameList.get(5));
		
		vo.setDbImage4(fileNameList.get(6));
		vo.setDbRealImage4(fileNameList.get(7));
		
		vo.setDbImage5(fileNameList.get(8));
		vo.setDbRealImage5(fileNameList.get(9));
		
		int imgCount = 0;
		for(int i=0;i<10;i=i+2) {
			if(fileNameList.get(i)!=null) imgCount++;
		}
		for(String str : fileNameList) {
			System.out.println(str);
		}
		vo.setDbImageCount(imgCount);
		
		System.out.println("/board/dietWrite: POST 등록하기!!");
		service.regist(vo);
		//System.out.println("DietBoardVO: " + vo);
		//System.out.println("글 작성자의 닉네임: " + vo.getMemberNick());
		
		ra.addFlashAttribute("msg", "게시물이 등록되었습니다.");
		return "redirect:/dietBoard/dietList";
	}
	
	//글 상세보기
	@GetMapping("/dietDetail")
	public String dietContent(@RequestParam int dbNum, Model model, DietBoardVO vo, PageVO pvo) {
		System.out.println("/board/dietDatail: GET 상세보기!!");
		System.out.println("요청된 상세보기 글 번호: " + dbNum);
		System.out.println("service.getContent(dbNum).toString(): " + service.getContent(dbNum).toString());
		
		//System.out.println("글 작성자의 닉네임: " + service.getContent(dbNum).getMemberNick());
		
		PageCreator pc = new PageCreator();
		pc.setPaging(pvo);
		System.out.println(pc.toString());
		service.updateViewCount(service.getContent(dbNum).getDbNum());
		model.addAttribute("dietList", service.getContent(dbNum));
		model.addAttribute("pc",pc);
		return "/board/diet/diet_detail";
	}
	
	//글 수정화면 요청
	@GetMapping("/dietModify")
	public String dietModify(@RequestParam int dbNum, Model model) {
		System.out.println("/board/diet/diet_modify: GET 글 수정목록 요청!");
		model.addAttribute("dietList", service.getContent(dbNum));
		System.out.println("수정할 글 번호: " + dbNum);
		return "/board/diet/diet_modify";
	}
	
	//글 수정하기
	@PostMapping("/dietModify")
	public String dietModify(MultipartFile[] fileName, HttpServletRequest request, DietBoardVO vo, RedirectAttributes ra) {
		
			//System.out.println("/dietBoard/dietModify: POST1");
		
		CustomFileUpload fileUp = new CustomFileUpload();
		
			//System.out.println("/dietBoard/dietModify: POST2");
		
		String rootPath = request.getServletContext().getRealPath(""); // C:\Users\hwans\apache-tomcat-9.0.52\wtpwebapps\SpringWeFit\
		
			//System.out.println("/dietBoard/dietModify: POST3");
		
		rootPath = rootPath + "resources\\..\\..\\..\\upload\\board\\diet\\"+vo.getMemberNick()+"\\"; 
		
			//System.out.println("/dietBoard/dietModify: POST4");
		
		DietBoardVO origin = service.getContent(vo.getDbNum());
			
			System.out.println("해당 글번호의 글 내용 정보 , origin: " + service.getContent(vo.getDbNum()));
			
			System.out.println("orgin의 getDbRealImage1: " + origin.getDbRealImage1());
			
			System.out.println("/dietBoard/dietModify: POST5");
		
		if(origin.getDbRealImage1() != null) {
			fileUp.delete(origin.getDbRealImage1(), rootPath);
			System.out.println(origin.getDbRealImage1() + "삭제완료");
		}
		
			System.out.println("/dietBoard/dietModify: POST6");
		
		if(origin.getDbRealImage2() != null) {
			fileUp.delete(origin.getDbRealImage2(), rootPath);
			System.out.println(origin.getDbRealImage2()+"삭제 완료");
		}
		if(origin.getDbRealImage3()!=null) {
			fileUp.delete(origin.getDbRealImage3(), rootPath);
			System.out.println(origin.getDbRealImage3()+"삭제 완료");
		}
		if(origin.getDbRealImage4()!=null) {
			fileUp.delete(origin.getDbRealImage4(), rootPath);
			System.out.println(origin.getDbRealImage4()+"삭제 완료");
		}
		if(origin.getDbRealImage5()!=null) {
			fileUp.delete(origin.getDbRealImage5(), rootPath);
			System.out.println(origin.getDbRealImage5()+"삭제 완료");
		}
		
		
		List<String> fileNameList = fileUp.fileUpload(fileName, 5, rootPath);
		
		// 파일이름 받기
		vo.setDbImage1(fileNameList.get(0));
		vo.setDbRealImage1(fileNameList.get(1));
		
		vo.setDbImage2(fileNameList.get(2));
		vo.setDbRealImage2(fileNameList.get(3));
		
		vo.setDbImage3(fileNameList.get(4));
		vo.setDbRealImage3(fileNameList.get(5));
		
		vo.setDbImage4(fileNameList.get(6));
		vo.setDbRealImage4(fileNameList.get(7));
		
		vo.setDbImage5(fileNameList.get(8));
		vo.setDbRealImage5(fileNameList.get(9));
		
		int imgCount = 0;
		for(int i=0;i<10;i=i+2) {
			if(fileNameList.get(i)!=null) imgCount++;
		}
		for(String str : fileNameList) {
			System.out.println(str);
		}
		vo.setDbImageCount(imgCount);
		
		
		service.update(vo);
		
		ra.addFlashAttribute("msg", "수정 완료되었습니다.");
		return "redirect:/dietBoard/dietDetail?dbNum="+vo.getDbNum();
	}

	
	//글 삭제하기
	@PostMapping("/dietDelete")
	public String dietDelete(DietBoardVO vo, RedirectAttributes ra) {
		service.delete(vo.getDbNum());
		ra.addFlashAttribute("msg", "게시글이 정상 삭제되었습니다.");
		System.out.println("삭제완료");
		return "redirect:/dietBoard/dietList";
	}
	
	//좋아요 처리
	@PostMapping("/dietLikely")
	@ResponseBody
	public String dietBoardLikely(@RequestBody DietBoardVO vo) {
		System.out.println("좋아요한 글 번호:"+vo.getDbNum());
		System.out.println("좋아요 한유저 번호"+vo.getMemberNum());
		if(service.checkLovely(vo) == 1) {
			service.deleteLike(vo);
			return "deleteLike";
		}else {
			service.insertLovely(vo);
			return "success";
		}
	}
	
	//좋아요 숫자 카운트
	@GetMapping("/{dbNum}")
	@ResponseBody
	public int dietLikeCount(@PathVariable int dbNum, Model countModel) {
		int countLovely = service.countLovely(dbNum);
		System.out.println("좋아요 갯수: " + countLovely);
		return countLovely;
	}
	

	
	//신고 처리하기
	@PostMapping("/dietReport")
	@ResponseBody
	public String dietBoardReport(@RequestBody DietBoardVO vo) {
		System.out.println("신고한 글 번호:"+vo.getDbNum());
		System.out.println("신고한 유저 번호"+vo.getMemberNum());
		if(service.checkReport(vo) == 1) {
			return "duplicate";
		} else {
			service.insertReport(vo);
			return "success";
		}
	}
	
	

	@PostMapping("/reportReset")
   public String reportReset(HttpSession session, DietBoardVO vo, RedirectAttributes ra) {
	   UserVO user = (UserVO) session.getAttribute("loginuser");
	   if(user.getMemberManagerYN().equals("YES")) {
		   service.reportReset(vo.getDbNum());
		   return "redirect:/dietBoard/dietList";
	   }
	   ra.addFlashAttribute("msg","관리자 권한이 아닙니다.");
	   return "redirect:/";
   }
	
	
	
	
	
	
	
	
}
