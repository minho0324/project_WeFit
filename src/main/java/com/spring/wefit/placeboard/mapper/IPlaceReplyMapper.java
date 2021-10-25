package com.spring.wefit.placeboard.mapper;

import java.util.List;
import java.util.Map;

import com.spring.wefit.command.PlaceReplyVO;
public interface IPlaceReplyMapper {

	//장소게시판 댓글 등록
	void placeReplyRegist(PlaceReplyVO vo); 
	
	//장소게시판 댓글 목록
	List<PlaceReplyVO> replyGetList(Map<String, Object> datas);
	
	//장소게시판 댓글 개수
	int replyGetTotal(int pbNum); 
	
	//장소게시판 댓글 수정
	void replyUpdate(PlaceReplyVO vo); 
	
	//장소게시판 댓글 삭제
	void replyDelete(int prNum); 
	
	//장소게시판 댓글 상세정보
	PlaceReplyVO replyGetContent(int prNum);
	

}
