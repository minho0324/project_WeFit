package com.spring.wefit.diet.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.spring.wefit.command.DietBoardReplyVO;
import com.spring.wefit.commons.PageVO;

@Service
public interface IDietReplyService {

	//댓글 등록
	void replyRegist(DietBoardReplyVO vo); 
	
	//페이징 추가할때
	List<DietBoardReplyVO> getList(PageVO vo, int dbNum);
	
	//댓글 개수
	int getTotal(int bno); 
	
	//댓글 수정
	void replyUpdate(DietBoardReplyVO vo); 
	
	//댓글 삭제
	void replyDelete(int rno); 
	
	// 댓글 상세정보
	DietBoardReplyVO getContent(int frNum);
	
}





