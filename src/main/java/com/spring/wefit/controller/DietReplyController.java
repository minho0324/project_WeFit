package com.spring.wefit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.wefit.command.DietBoardReplyVO;
import com.spring.wefit.commons.PageVO;
import com.spring.wefit.diet.service.IDietReplyService;
import com.spring.wefit.user.service.IUserService;

@RestController
@RequestMapping("/dietReply")
public class DietReplyController {
	
	@Autowired
	private IDietReplyService service;
	@Autowired
	private IUserService userservice;
	
	//댓글 쓰기
	@PostMapping("/replyRegist")
	public String replyRegist(@RequestBody DietBoardReplyVO vo ) {
		System.out.println("댓글쓰기 요청");
		service.replyRegist(vo);
		return "regSucess";
	}
	
	
//	//댓글 목록불러오기 
//	@GetMapping("/replyList/{dbNum}")
//	public List<DietBoardReplyVO> getList(@PathVariable int dbNum) {
//		List<DietBoardReplyVO> list = service.getList(dbNum);
//		
//		return list;
//	}
	
	
	//댓글 목록불러오기 페이징
	@GetMapping("/replyList/{dbNum}/{pageNum}")
	public Map<String, Object> getList(@PathVariable int dbNum, @PathVariable int pageNum) {
		PageVO vo = new PageVO();
		vo.setPageNum(pageNum);
		vo.setCountPerPage(10);
		
		List<DietBoardReplyVO> list = service.getList(vo, dbNum);
		int total = service.getTotal(dbNum);
		System.out.println("총 댓글 갯수(컨트롤러)" + total);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("total", total);
		
		return map;
	}
		
	//댓글 수정하기
	@PostMapping("/dietReplyModify")
	public String dietReplyModify(@RequestBody Map<String, Object> map) {
		System.out.println(map.get("memberNum").getClass().getName());
		System.out.println(map.get("drContent").getClass().getName());
		System.out.println(map.get("drNum").getClass().getName());
		
		int memberNum = (int) map.get("memberNum");
		String drContent = (String) map.get("drContent");
		int drNum = Integer.parseInt(((String) map.get("drNum")).substring(11));
		System.out.println("memberNum: " + memberNum);
		System.out.println("drContent: " + drContent);
		System.out.println("drNum: " + drNum);
		System.out.println(service.getContent(drNum).getMemberNum());
		if(service.getContent(drNum).getMemberNum() == memberNum) {
			DietBoardReplyVO vo = new DietBoardReplyVO();
			vo.setDrContent(drContent);
			vo.setDrNum(drNum);
			service.replyUpdate(vo);
			return "success";
		}
		
		return "noAuth";
	}
	
	
	//댓글 삭제하기
	@PostMapping("/dietReplyDelete")
	public String  dietReplyDelete(@RequestBody Map<String, Object> map) {
		System.out.println(map);
		System.out.println(map.get("memberNum"));
		int memberNum = Integer.parseInt((String) map.get("memberNum"));
		int drNum = Integer.parseInt(((String) (map.get("drNum"))).substring(11));
		
		System.out.println("memberNum: " + memberNum);
		System.out.println("drNum: " + drNum);
		System.out.println(service.getContent(drNum).getMemberNum());
		
		if(service.getContent(drNum).getMemberNum() == memberNum || userservice.getContent(memberNum).getMemberManagerYN().equals("YES")) {
			service.replyDelete(drNum);
			return "success";
		}
		return "noAuth";
	}
	
	

	
	

		
		
		
	
	
}
