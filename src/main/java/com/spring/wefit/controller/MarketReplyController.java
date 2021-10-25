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
import org.springframework.web.bind.annotation.RestController;

import com.spring.wefit.command.MarketReplyVO;
import com.spring.wefit.commons.PageVO;
import com.spring.wefit.market.service.IMarketReplyService;
import com.spring.wefit.user.service.IUserService;

@RestController
@RequestMapping("/marketReply")
public class MarketReplyController {

	@Autowired
	private IMarketReplyService service;
	@Autowired
	private IUserService userservice;
	
	// 댓글 등록
	@PostMapping("/regist")
	public String regist(@RequestBody MarketReplyVO vo) {
		service.replyRegist(vo);

		return "regSuccess";
	}

	@GetMapping("/marketReplyList/{mbNum}/{pageNum}")
	public Map<String, Object> marketReplyList(@PathVariable int mbNum, @PathVariable int pageNum) {
		PageVO vo = new PageVO();
		vo.setPageNum(pageNum);
		vo.setCountPerPage(10);

		List<MarketReplyVO> list = service.getList(vo, mbNum);
		int total = service.getTotal(mbNum); // 댓글 개수
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("total", total);

		return map;
	}

	@PostMapping("/modify")
	public String marketReplyModify(@RequestBody Map<String, Object> map) {
		System.out.println(map.get("memberNum").getClass().getName());
		System.out.println(map.get("mrContent").getClass().getName());
		System.out.println(map.get("mrNum").getClass().getName());
		int memberNum = (int) map.get("memberNum");
		String mrContent = (String) map.get("mrContent");
		int mrNum = Integer.parseInt(((String) map.get("mrNum")).substring(11));

		if (service.getContent(mrNum).getMemberNum() == memberNum) {
			MarketReplyVO vo = new MarketReplyVO();
			vo.setMrContent(mrContent);
			vo.setMrNum(mrNum);
			service.replyUpdate(vo);
			return "success";
		}

		return "noAuth";
	}

	@PostMapping("/delete")
	public String MarketReplyDelete(@RequestBody Map<String, Object> map) {

		System.out.println(map.get("mrNum").getClass().getName());
		int memberNum = (int) map.get("memberNum");
		int mrNum = Integer.parseInt(((String) map.get("mrNum")).substring(11));

		if (service.getContent(mrNum).getMemberNum() == memberNum || userservice.getContent(memberNum).getMemberManagerYN().equals("YES")) {
			service.replyDelete(mrNum);
			return "success";
		}

		return "noAuth";
	}
	
	
	
}
