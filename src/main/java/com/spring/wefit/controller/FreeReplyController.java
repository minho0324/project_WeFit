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

import com.spring.wefit.command.FreeReplyVO;
import com.spring.wefit.commons.PageVO;
import com.spring.wefit.free.service.IFreeReplyService;
import com.spring.wefit.user.service.IUserService;

@RestController
@RequestMapping("/freeReply")
public class FreeReplyController {

	@Autowired
	private IFreeReplyService replyService;
	@Autowired
	private IUserService userservice;
	
	//자유게시판  댓글 등록
		@PostMapping("/freeReplyRegist")
		public String freeReplyRegist(@RequestBody FreeReplyVO vo) {
			System.out.println(vo.toString());
			replyService.regist(vo);
			return "success";
		}
		//자유게시판 댓글 목록
		@GetMapping("/freeReplyList/{fbNum}/{pageNum}")
		public Map<String, Object> freeReplyList(@PathVariable int fbNum, @PathVariable int pageNum){
			PageVO vo = new PageVO();
			vo.setPageNum(pageNum);
			vo.setCountPerPage(10);
			
			List<FreeReplyVO> list = replyService.getList(vo, fbNum); 
				int total = replyService.getTotal(fbNum); // 댓글 개수
			Map<String, Object> map = new HashMap<>();
			map.put("list",list);
			map.put("total",total);
			
			
			
			
			return map;
		}
		
		//자유게시판 댓글 수정
		@PostMapping("/freeReplyModify")
		public String freeReplyModify(@RequestBody Map<String, Object> map) {
			System.out.println(map.get("memberNum").getClass().getName());
			System.out.println(map.get("frContent").getClass().getName());
			System.out.println(map.get("frNum").getClass().getName());
			int memberNum = (int) map.get("memberNum");
			String frContent = (String) map.get("frContent");
			int frNum = Integer.parseInt(((String) map.get("frNum")).substring(11));
			
			if(replyService.getContent(frNum).getMemberNum() == memberNum) {
				FreeReplyVO vo = new FreeReplyVO();
				vo.setFrContent(frContent);
				vo.setFrNum(frNum);
				replyService.update(vo);
				return "success";
			}
			
			return "noAuth";
		}
		
		//자유게시판 댓글 삭제
		@PostMapping("/freeReplyDelete")
		public String freeReplyDelete(@RequestBody Map<String, Object> map) {
			
			int memberNum = (int) map.get("memberNum");
			int frNum = Integer.parseInt(((String) map.get("frNum")).substring(11));
			
			if(replyService.getContent(frNum).getMemberNum() == memberNum || userservice.getContent(memberNum).getMemberManagerYN().equals("YES")) {
				replyService.delete(frNum);
				return "success";
			}
			
			return "noAuth";
		}
}
