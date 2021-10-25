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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.wefit.command.CourseReportVO;
import com.spring.wefit.command.FreeBoardVO;
import com.spring.wefit.command.NoticeBoardVO;
import com.spring.wefit.command.PlaceBoardVO;
import com.spring.wefit.command.UserVO;
import com.spring.wefit.commons.CustomFileUpload;
import com.spring.wefit.commons.PageCreator;
import com.spring.wefit.commons.PageVO;
import com.spring.wefit.placeboard.service.IPlaceBoardService;

@Controller
@RequestMapping("/placeBoard")
public class PlaceBoardController {

	@Autowired 
	private IPlaceBoardService service;
	

		//장소 목록 페이지 이동
		@GetMapping("/placeList")
		public String placeList(PageVO vo, Model model) {
			System.out.println("/placeBoard/placeList: GET");
			if(vo.getDistance() == 0) {
				vo.setDistance(15000);
			}
			
			System.out.println(vo.toString());
			// 페이지 버튼 계산하기
			vo.setCountPerPage(20);
			PageCreator pc = new PageCreator();
			pc.setPaging(vo);
			pc.setArticleTotalCount(service.getTotal(vo));
			
			
			// 총 게시물 개수
			int contentTotal = service.getTotal(vo);
			System.out.println("총 게시글 수 : "+contentTotal );
			
			// 게시글 리스트 뽑기
			List<PlaceBoardVO> list = service.getList(vo);
			System.out.println("DB에서 잘 갖고왔니?" + list);
			
			// jsp에 전달할 값들
			model.addAttribute("placeList", list);
			model.addAttribute("page", pc.getPaging());
			model.addAttribute("pc", pc);

			return "board/location/loc_board";
			
		}
	

	//장소 글쓰기 페이지 이동
	@GetMapping("/placeWrite")
	public String placeWrite() {
		System.out.println("/placeBoard/placeWrite: GET");
		return "board/location/loc_write";
	}
	
	//장소 글 등록
	@PostMapping("/placeWrite")
	public String placeBoardWrite(MultipartFile[] fileName, HttpServletRequest request, 
			PlaceBoardVO vo, RedirectAttributes ra) {
		
		System.out.println("/placeBoard/placeWrite: Post");
		System.out.println(vo.toString());
		
		CustomFileUpload fileUp = new CustomFileUpload();
		String rootPath = request.getServletContext().getRealPath(""); 
		rootPath = rootPath + "resources\\..\\..\\..\\upload\\board\\place\\"+vo.getMemberNick()+"\\"; 
		List<String> fileNameList = fileUp.fileUpload(fileName, 5, rootPath);
			
		// 파일이름 받기
		vo.setPbImage1(fileNameList.get(0));
		vo.setPbRealImage1(fileNameList.get(1));
			
		vo.setPbImage2(fileNameList.get(2));
		vo.setPbRealImage2(fileNameList.get(3));
			
		vo.setPbImage3(fileNameList.get(4));
		vo.setPbRealImage3(fileNameList.get(5));
			
		vo.setPbImage4(fileNameList.get(6));
		vo.setPbRealImage4(fileNameList.get(7));
			
		vo.setPbImage5(fileNameList.get(8));
		vo.setPbRealImage5(fileNameList.get(9));
			
		int imgCount = 0;
		for(int i=0;i<10;i=i+2) {
			if(fileNameList.get(i)!=null) imgCount++;
		}
		for(String str : fileNameList) {
			System.out.println(str);
		}
		vo.setPbImageCount(imgCount);
			
			
		System.out.println(vo.toString());
		service.regist(vo);
			
		ra.addFlashAttribute("msg","정상 등록 되었습니다.");
		return "redirect:/placeBoard/placeList";
	}
	
	//장소 글 상세 페이지 이동 
	@GetMapping("/placeDetail") 
	public String placeContent(@RequestParam int pbNum, PageVO page, Model model) {
		System.out.println("/placeBoard/placeDetail?pbNum="+pbNum+":GET");
		service.upHit(pbNum);
		System.out.println("요청된 글 번호: " + pbNum);
		model.addAttribute("placeList", service.getContent(pbNum));
		PageCreator pc = new PageCreator();
		pc.setPaging(page);
		System.out.println(pc.toString());
		
		System.out.println(service.getContent(pbNum).toString()); // 상세데이터 확인
		model.addAttribute("pc", pc);
		return "board/location/loc_detail";
	}
			
	//장소 수정 페이지 이동
	@GetMapping("/placeModify")
	public String placeModify(int pbNum, Model model) {
		System.out.println("수정 요청이 들어옴!");
		System.out.println("/placeBoard/placeModify: GET");
		System.out.println("수정 요청된 글 번호: " + pbNum);
		model.addAttribute("placeList", service.getContent(pbNum));
		
		return "board/location/loc_modify";
	}
	
	//장소 글 수정 처리 
	@PostMapping("/placeModify")
	public String placeUpdate(MultipartHttpServletRequest request, PlaceBoardVO vo, RedirectAttributes ra) {
		System.out.println("/placeBoard/placeUpdate: POST");
			
		service.update(vo);
		ra.addFlashAttribute("msg", "정상 수정 처리되었습니다.");
				
		return "redirect:/placeBoard/placeDetail?pbNum=" + vo.getPbNum();
	}
		
	//장소 글 삭제 처리
	@PostMapping("/placeDelete")
	public String placeDelete(PlaceBoardVO vo, RedirectAttributes ra) {
		System.out.println("/placeBoard/placeDelete: POST");
		service.delete(vo.getPbNum());
		ra.addFlashAttribute("msg", "게시글이 정상 삭제되었습니다.");
		
		return "redirect:/placeBoard/placeList";
	}
		
	//장소 글 좋아요 처리
	@PostMapping("/placeLike")
	@ResponseBody
	public String placeLike(@RequestBody PlaceBoardVO vo) {
		System.out.println("글 번호:"+vo.getPbNum());
		System.out.println("유저 번호"+vo.getMemberNum());
		if(service.checkLike(vo) == 1) {
			service.deleteLike(vo);
			return "likeDelete";
		} else {
			service.insertLike(vo);
			return "likeSuccess";
		}
	}

	//좋아요 개수 출력
	@GetMapping("/{pbNum}")
	@ResponseBody
	public Map<String, Object> placeCountLike(@PathVariable int pbNum) {
		   
		int count = service.countLike(pbNum);
		   
		Map<String, Object> map = new HashMap<>();
		map.put("count", count);
		return map;
	}

	//장소 글 신고 처리하기
	@PostMapping("/placeReport")
	@ResponseBody
	public String placeBoardReport(@RequestBody PlaceBoardVO vo) {
		
		System.out.println("글 번호:"+vo.getPbNum());
		System.out.println("유저 번호"+vo.getMemberNum());
		
		if(service.checkReport(vo) == 1) {
			return "reportFail";
		} else {
			service.insertReport(vo);
			return "success";
		}
	}
	
	@PostMapping("/reportReset")
   public String reportReset(HttpSession session, PlaceBoardVO vo, RedirectAttributes ra) {
	   UserVO user = (UserVO) session.getAttribute("loginuser");
	   if(user.getMemberManagerYN().equals("YES")) {
		   service.reportReset(vo.getPbNum());
		   return "redirect:/placeBoard/placeList";
	   }
	   ra.addFlashAttribute("msg","관리자 권한이 아닙니다.");
	   return "redirect:/";
   }
	
	
	
}
