package com.spring.wefit.placeboard.service;

import java.util.List;

import com.spring.wefit.command.PlaceReplyVO;
import com.spring.wefit.commons.PageVO;

public interface IPlaceReplyService {

	//장소게시판 댓글 등록
	void replyRegist(PlaceReplyVO vo); 
	
	//장소게시판 댓글 목록
	List<PlaceReplyVO> replyGetList(PageVO vo, int pbNum);
	
	//장소게시판 댓글 개수
	int replyGetTotal(int pbNum);

	//장소게시판 댓글 수정
	void replyUpdate(PlaceReplyVO vo); 
	
	//장소게시판 댓글 삭제
	void replyDelete(int prNum); 
	
	//장소게시판 댓글 상세
	PlaceReplyVO replyGetContent(int prNum);


}
