package com.spring.wefit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.spring.wefit.command.NoticeReplyVO;
import com.spring.wefit.commons.PageVO;
import com.spring.wefit.noticeboard.service.NoticeReplyService;
import com.spring.wefit.user.service.IUserService;

@RestController
@RequestMapping("/noticeReply")
public class NoticeReplyController {
	
	@Autowired
	private NoticeReplyService service;
	@Autowired
	private IUserService userservice;
	
	//댓글 등록
	@PostMapping("/noticeReplyRegist")
	public String noticeReplyRegist(@RequestBody NoticeReplyVO vo) {
		System.out.println(vo.toString());
		service.regist(vo);
		return "success";
	}
			
			//댓글 목록
			@GetMapping("/noticeReplyList/{nbNum}/{pageNum}")
			public Map<String, Object> noticeReplyList(@PathVariable int nbNum, @PathVariable int pageNum){
				PageVO vo = new PageVO();
				vo.setPageNum(pageNum);
				vo.setCountPerPage(10);
				
					List<NoticeReplyVO> list = service.getList(vo, nbNum); 
					int total = service.getTotal(nbNum); // 댓글 개수
				Map<String, Object> map = new HashMap<>();
				map.put("list",list);
				map.put("total",total);
				
				
				
				
				return map;
			}
			
			//댓글 수정
			@PostMapping("/noticeReplyModify")
			public String noticeReplyModify(@RequestBody Map<String, Object> map) {
				System.out.println(map.get("memberNum").getClass().getName());
				System.out.println(map.get("nrContent").getClass().getName());
				System.out.println(map.get("nrNum").getClass().getName());
				int memberNum = (int) map.get("memberNum");
				String nrContent = (String) map.get("nrContent");
				int nrNum = Integer.parseInt(((String) map.get("nrNum")).substring(11));
				
				if(service.getContent(nrNum).getMemberNum() == memberNum) {
					NoticeReplyVO vo = new NoticeReplyVO();
					vo.setNrContent(nrContent);
					vo.setNrNum(nrNum);
					service.update(vo);
					return "success";
				}
				
				return "noAuth";
			}
			
			//댓글 삭제
			@PostMapping("/noticeReplyDelete")
			@ResponseBody
			public String noticeReplyDelete(@RequestBody Map<String, Object> map) {
				
				int memberNum = (int) map.get("memberNum");
				int nrNum = Integer.parseInt(((String) map.get("nrNum")).substring(11));
				
				if(service.getContent(nrNum).getMemberNum() == memberNum || userservice.getContent(memberNum).getMemberManagerYN().equals("YES")) {
					service.delete(nrNum);
					return "success";
				}
				
				return "noAuth";
			}
	

}
