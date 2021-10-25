package com.spring.wefit.free.service;

import java.util.List;

import com.spring.wefit.command.FreeReplyVO;
import com.spring.wefit.commons.PageVO;

public interface IFreeReplyService {
	//자유게시판  댓글 등록
	void regist(FreeReplyVO vo);
	
	//자유게시판 댓글 목록
	List<FreeReplyVO> getList(PageVO vo, int bno);
	
	//자유게시판 댓글 수정
	void update(FreeReplyVO vo);
	
	//자유게시판 댓글 삭제
	void delete (int frNum);
	
	//자유게시판 댓글 수
	int getTotal(int fbNum);
	
	//자유게시판 댓글 상세정보
	FreeReplyVO getContent(int frNum);
}
