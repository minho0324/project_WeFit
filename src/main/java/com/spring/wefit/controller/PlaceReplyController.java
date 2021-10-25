package com.spring.wefit.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.spring.wefit.command.PlaceReplyVO;
import com.spring.wefit.placeboard.service.IPlaceReplyService;
import com.spring.wefit.user.service.IUserService;
import com.spring.wefit.commons.PageVO;



@RestController
@RequestMapping("/placeReply")
public class PlaceReplyController {
	
	
	@Autowired
	private IPlaceReplyService replyService;
	@Autowired
	private IUserService userservice;
	
	//장소게시판 댓글 등록
	@PostMapping("/replyRegist")
	@ResponseBody
	public String replyRegist(@RequestBody PlaceReplyVO vo) {
		System.out.println("화면으로부터 전달된 데이터: " + vo);
		replyService.replyRegist(vo);
		return "success";
	}

	//장소게시판 댓글 목록
	@GetMapping("/placeReplyList/{pbNum}/{pageNum}")
	@ResponseBody
	public Map<String, Object> placeReplyList(@PathVariable int pbNum, @PathVariable int pageNum, Model model){
		PageVO vo = new PageVO();
		vo.setPageNum(pageNum);
		vo.setCountPerPage(10);
			
			List<PlaceReplyVO> list = replyService.replyGetList(vo, pbNum); 
			int total = replyService.replyGetTotal(pbNum); // 댓글 개수
		Map<String, Object> map = new HashMap<>();
		map.put("list",list);
		map.put("total",total);
		return map;
	}
		
	//장소게시판 댓글 수정
	@PostMapping("/placeReplyModify")
	@ResponseBody
	public String placeReplyModify(@RequestBody Map<String, Object> map) {
		System.out.println(map.get("memberNum").getClass().getName());
		System.out.println(map.get("prContent").getClass().getName());
		System.out.println(map.get("prNum").getClass().getName());
		int memberNum = (int) map.get("memberNum");
		String prContent = (String) map.get("prContent");
		int prNum = Integer.parseInt(((String) map.get("prNum")).substring(11));
			
		if(replyService.replyGetContent(prNum).getMemberNum() == memberNum) {
			PlaceReplyVO vo = new PlaceReplyVO();
			vo.setPrContent(prContent);
			vo.setPrNum(prNum);
			replyService.replyUpdate(vo);
			return "success";
		}
			
		return "noAuth";
	}
		
	//장소게시판 댓글 삭제
	@PostMapping("/placeReplyDelete")
	@ResponseBody
	public String placeReplyDelete(@RequestBody Map<String, Object> map) {
			
		int memberNum = (int) map.get("memberNum");
		int prNum = Integer.parseInt(((String) map.get("prNum")).substring(11));
			
		if(replyService.replyGetContent(prNum).getMemberNum() == memberNum || userservice.getContent(memberNum).getMemberManagerYN().equals("YES")) {
			replyService.replyDelete(prNum);
			return "success";
		}
			
		return "noAuth";
	}

		

	

	
	

			
	}
		
		
		
	
	
	
	


