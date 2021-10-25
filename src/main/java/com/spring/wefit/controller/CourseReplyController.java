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

import com.spring.wefit.command.CourseReplyVO;
import com.spring.wefit.command.UserVO;
import com.spring.wefit.commons.PageVO;
import com.spring.wefit.course.service.ICourseBoardService;
import com.spring.wefit.course.service.ICourseReplyService;
import com.spring.wefit.user.service.IUserService;

@RestController
@RequestMapping("/courseReply")
public class CourseReplyController {
	
	@Autowired
	private ICourseReplyService service;
	@Autowired
	private ICourseBoardService service2;
	@Autowired
	private IUserService userservice;
	
	@PostMapping("/regist")
	public String replyRegist(@RequestBody CourseReplyVO vo) {
		
		System.out.println(vo);
		service.regist(vo);
		
		System.out.println("댓글 등록이 완료되었습니다.: " + vo);
		return "registSuccess";
	
	}
	
	@GetMapping("/{cbNum}/{pageNum}") //pathVariable 뭔지 생각안남..
	public Map<String, Object> replyList(@PathVariable int cbNum, @PathVariable int pageNum) {
		
		//페이징 처리
		PageVO vo = new PageVO();
		vo.setPageNum(pageNum);
		vo.setCountPerPage(10);
		
		
		List<CourseReplyVO> list = service.getList(vo, cbNum);	
		int total = service.getTotal(cbNum); //해당 글의 총 댓글 개수!! (CourseReply 테이블에서 조회함)		
		//service2.updateCrCount(cbNum, total); //CourseBoard테이블 update시키기.(= CourseBoard테이블에 해당 글의 댓글개수(crCount 컬럼) 저장함)--> CourseBoard 테이블에 crCount컬럼 지움. 그러고 mapper에서 getList할 때 SELECT COUNT(*) FROM CourseReply...이런식으로 해서 댓글개수 가져옴)
		
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("total", total);
		
		System.out.println(map);
		
		return map;
	}
	
	
	@PostMapping("/modify")
	public String replyModify(@RequestBody CourseReplyVO vo) {
		
		service.update(vo);		
		return "modifySuccess";
	
	}
	
	

	@PostMapping("/delete")
	public String replyDelete(@RequestBody CourseReplyVO vo) {
		System.out.println(vo.toString());
		System.out.println(userservice.getContent(vo.getMemberNum()).toString());
		if(service.memberCheck(vo) == 1 || userservice.getContent(vo.getMemberNum()).getMemberManagerYN().equals("YES")) {
			service.delete(vo.getCrNum());
			return "deleteSuccess";
		} else {
			return "noAuth";
		}
		
	}
	
	@GetMapping("/replyByte/{crNum}")
	public Map<String, Object> replyByte(@PathVariable int crNum) {
		
		int crContentByte = service.getCrByte(crNum);
		Map<String, Object> map = new HashMap<>();
		map.put("crContentByte", crContentByte);
		
		System.out.println("해당 댓글 번호: " + crNum);
		System.out.println("해당 댓글의 바이트: " + crContentByte);
		
		return map;
	
	}
	
	

}
