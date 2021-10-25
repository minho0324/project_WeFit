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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.wefit.command.FreeBoardVO;
import com.spring.wefit.command.MarketBoardVO;
import com.spring.wefit.command.UserVO;
import com.spring.wefit.commons.CustomFileUpload;
import com.spring.wefit.commons.PageCreator;
import com.spring.wefit.commons.PageVO;
import com.spring.wefit.market.service.IMarketBoardService;

@Controller
@RequestMapping("/marketBoard")
public class MarketBoardController {

	@Autowired
	private IMarketBoardService service;

	// 장터 게시판으로
	@GetMapping("/market_board")
	public String marketList(PageVO vo, Model model) {
		
		PageCreator pc = new PageCreator();
		vo.setCountPerPage(9);
		pc.setPaging(vo);
		System.out.println(pc.toString());
		pc.setArticleTotalCount(service.getTotal(vo));
		
		List<MarketBoardVO> list = service.getList(vo);
		model.addAttribute("product", list);
		model.addAttribute("page", pc.getPaging());
		model.addAttribute("pc", pc);
		System.out.println(vo.toString());

		return "/board/market/market_board";
	}

	// 글 등록페이지로
	@GetMapping("/market_write")
	public String market_write() {
		return "/board/market/market_write";
	}

	@PostMapping("/regist")
	public String regist(MultipartFile[] fileName, HttpServletRequest request, MarketBoardVO vo, RedirectAttributes ra) {
		
		CustomFileUpload fileUp = new CustomFileUpload();
		String rootPath = request.getServletContext().getRealPath("");
		rootPath = rootPath + "resources\\..\\..\\..\\upload\\board\\market\\"+vo.getMemberNum()+"\\";
		List<String> fileNameList = fileUp.fileUpload(fileName, 10, rootPath);
		
		// 파일이름 받기
		vo.setMbImage1(fileNameList.get(0));
		vo.setMbRealImage1(fileNameList.get(1));
		
		vo.setMbImage2(fileNameList.get(2));
		vo.setMbRealImage2(fileNameList.get(3));
		
		vo.setMbImage3(fileNameList.get(4));
		vo.setMbRealImage3(fileNameList.get(5));
		
		vo.setMbImage4(fileNameList.get(6));
		vo.setMbRealImage4(fileNameList.get(7));
		
		vo.setMbImage5(fileNameList.get(8));
		vo.setMbRealImage5(fileNameList.get(9));

		vo.setMbImage6(fileNameList.get(10));
		vo.setMbRealImage6(fileNameList.get(11));
		
		vo.setMbImage7(fileNameList.get(12));
		vo.setMbRealImage7(fileNameList.get(13));
		
		vo.setMbImage8(fileNameList.get(14));
		vo.setMbRealImage8(fileNameList.get(15));
		
		vo.setMbImage1(fileNameList.get(16));
		vo.setMbRealImage9(fileNameList.get(17));
		
		vo.setMbImage10(fileNameList.get(18));
		vo.setMbRealImage10(fileNameList.get(19));
		
		
		int imgCount = 0;
		for(int i=0;i<20;i=i+2) {
			if(fileNameList.get(i)!=null) imgCount++;
		}
		for(String str : fileNameList) {
			System.out.println(str);
		}
		vo.setMbImageCount(imgCount);
		
		
//		String[] arr = vo.getMbAddrBasic().split(" ");
//		
//		vo.setMbAddrBasic(arr[0] + " " + arr[1] + " " + arr[2]);
		
		service.regist(vo);
		System.out.println(vo.getMbLatitude());
		System.out.println(vo.getMbLongitude());
		
		return "redirect:/marketBoard/market_board/?pageNum=1";
	}

	@GetMapping("/market_detail")
	public String detail(@RequestParam int mbNum, PageVO page, Model model) {
		
		service.updateViewCount(service.getContent(mbNum).getMbNum());
		
		PageCreator pc = new PageCreator();
		pc.setPaging(page);
		
		model.addAttribute("detail", service.getContent(mbNum));
		model.addAttribute("pc", pc);

		return "/board/market/market_detail";
	}

	@GetMapping("/market_modify")
	public String modify(@RequestParam int mbNum, Model model) {
		model.addAttribute("detail", service.getContent(mbNum));
		System.out.println("수정할 글 번호: " + mbNum);
		return "board/market/market_modify";
	}

	// 글 수정
	@PostMapping("/update")
	public String update(MarketBoardVO vo,MultipartFile[] fileName,HttpServletRequest request) {
		
		CustomFileUpload fileUp = new CustomFileUpload();
		String rootPath = request.getServletContext().getRealPath(""); // C:\Users\hwans\apache-tomcat-9.0.52\wtpwebapps\SpringWeFit\
		rootPath = rootPath + "resources\\..\\..\\..\\upload\\board\\market\\"+vo.getMemberNum()+"\\"; 
		
		MarketBoardVO origin = service.getContent(vo.getMbNum());
		
		if(origin.getMbRealImage1() != null) {
			fileUp.delete(origin.getMbRealImage1(), rootPath);
		}
		
		if(origin.getMbRealImage2() != null) {
			fileUp.delete(origin.getMbRealImage2(), rootPath);
		}
		
		if(origin.getMbRealImage3() != null) {
			fileUp.delete(origin.getMbRealImage3(), rootPath);
		}
		
		if(origin.getMbRealImage4() != null) {
			fileUp.delete(origin.getMbRealImage4(), rootPath);
		}
		
		if(origin.getMbRealImage5() != null) {
			fileUp.delete(origin.getMbRealImage5(), rootPath);
		}
		
		if(origin.getMbRealImage6() != null) {
			fileUp.delete(origin.getMbRealImage6(), rootPath);
		}
		
		if(origin.getMbRealImage7() != null) {
			fileUp.delete(origin.getMbRealImage7(), rootPath);
		}
		
		if(origin.getMbRealImage8() != null) {
			fileUp.delete(origin.getMbRealImage8(), rootPath);
		}
		
		if(origin.getMbRealImage9() != null) {
			fileUp.delete(origin.getMbRealImage9(), rootPath);
		}
		
		if(origin.getMbRealImage10() != null) {
			fileUp.delete(origin.getMbRealImage10(), rootPath);
		}
		
		List<String> fileNameList = fileUp.fileUpload(fileName, 10, rootPath);
		
		vo.setMbImage1(fileNameList.get(0));
		vo.setMbRealImage1(fileNameList.get(1));
		
		vo.setMbImage2(fileNameList.get(2));
		vo.setMbRealImage2(fileNameList.get(3));
		
		vo.setMbImage3(fileNameList.get(4));
		vo.setMbRealImage3(fileNameList.get(5));
		
		vo.setMbImage4(fileNameList.get(6));
		vo.setMbRealImage4(fileNameList.get(7));
		
		vo.setMbImage5(fileNameList.get(8));
		vo.setMbRealImage5(fileNameList.get(9));
		
		vo.setMbImage6(fileNameList.get(10));
		vo.setMbRealImage6(fileNameList.get(11));
		
		vo.setMbImage7(fileNameList.get(12));
		vo.setMbRealImage7(fileNameList.get(13));
		
		vo.setMbImage8(fileNameList.get(14));
		vo.setMbRealImage8(fileNameList.get(15));
		
		vo.setMbImage9(fileNameList.get(16));
		vo.setMbRealImage9(fileNameList.get(17));
		
		vo.setMbImage10(fileNameList.get(18));
		vo.setMbRealImage10(fileNameList.get(19));
		
		int imgCount = 0;
		for(int i=0;i<10;i=i+2) {
			if(fileNameList.get(i)!=null) imgCount++;
		}
		for(String str : fileNameList) {
			System.out.println(str);
		}
		vo.setMbImageCount(imgCount);
				
		
		System.out.println(vo);
		System.out.println(vo.getMbNum());
		service.update(vo);
		return "redirect:/marketBoard/market_detail?mbNum=" +vo.getMbNum();
	}

	@GetMapping("/delete")
	public String delete(@RequestParam int mbNum) {
		service.delete(mbNum);
		return "redirect:/marketBoard/market_board";
	}
	
	// 글 좋아요 처리하기
		@PostMapping("/marketLikely")
		@ResponseBody
		public String marketBoardLikely(@RequestBody MarketBoardVO vo) {
			System.out.println("글 번호:"+vo.getMbNum());
			System.out.println("유저 번호"+vo.getMemberNum());
			if(service.checkLovely(vo) == 1) {
				service.deleteLike(vo);
				return "duplicate";
			} else {
				service.insertLovely(vo);
				return "success";
			}
		}
		
		// 좋아요 수
		@GetMapping("/{mbNum}")
	   @ResponseBody
	   public Map<String, Object> marketCountLike(@PathVariable int mbNum) {
		   
		   int count = service.countLike(mbNum);
		   
		   Map<String, Object> map = new HashMap<>();
		   map.put("count", count);
		   System.out.println(count);
		   return map;
	   }
		
		// 글 신고 처리하기
		@PostMapping("/marketReport")
		@ResponseBody
		public String marketBoardReport(@RequestBody MarketBoardVO vo) {
			System.out.println("글 번호:"+vo.getMbNum());
			System.out.println("유저 번호"+vo.getMemberNum());
			if(service.checkReport(vo) == 1) {
				return "duplicate";
			} else {
				service.insertReport(vo);
				return "success";
			}
		}

		@PostMapping("/reportReset")
	   public String reportReset(HttpSession session, MarketBoardVO vo, RedirectAttributes ra) {
		   UserVO user = (UserVO) session.getAttribute("loginuser");
		   if(user.getMemberManagerYN().equals("YES")) {
			   service.reportReset(vo.getMbNum());
			   return "redirect:/marketBoard/market_board";
		   }
		   ra.addFlashAttribute("msg","관리자 권한이 아닙니다.");
		   return "redirect:/";
	   }
}
