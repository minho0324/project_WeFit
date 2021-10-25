package com.spring.wefit.diet.mapper;

import java.util.List;
import java.util.Map;

import com.spring.wefit.command.DietBoardReplyVO;

public interface IDietReplyMapper {
	
	//댓글 등록
	void replyRegist(DietBoardReplyVO vo);
	
	//댓글 목록 요청
	List<DietBoardReplyVO> getList(Map<String, Object> datas);
	
	//댓글 총 개수 (페이징)
	int getTotal(int dbNum);
	
	//댓글 수정
	void replyUpdate(DietBoardReplyVO vo);
	
	//댓글 삭제
	void replyDelete(int drNum);
	
	//식단 게시판 댓글 상세정보
	DietBoardReplyVO getContent(int drNum);
	
	
}







