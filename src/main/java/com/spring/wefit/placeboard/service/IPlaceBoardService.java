package com.spring.wefit.placeboard.service;

import java.util.List;

import com.spring.wefit.command.CourseReportVO;
import com.spring.wefit.command.PlaceBoardVO;
import com.spring.wefit.commons.PageVO;

public interface IPlaceBoardService {

	//장소 글 등록
	void regist(PlaceBoardVO vo);

	//장소 글 목록
	List<PlaceBoardVO> getList(PageVO vo);
	
	//장소 총 게시물 수
	int getTotal(PageVO vo);

	//장소 글 상세보기
	PlaceBoardVO getContent(int pbNum);

	//장소 글 수정
	void update(PlaceBoardVO vo);

	//장소 글 삭제
	void delete(int pbNum);
		
	//장소 조회수 처리
	void upHit(int pbNum);
		
	
	
	//장소 좋아요수 처리
	void insertLike(PlaceBoardVO vo);
	
	//장소 좋아요수 체크
	int checkLike(PlaceBoardVO vo);
		
	//장소 좋아요수 삭제
	void deleteLike(PlaceBoardVO vo);
		   
	//장소 해당 글 좋아요 수 카운트
	int countLike(int pbNum);
	
	
			
	//자유게시판 신고 했는지 확인
	int checkReport(PlaceBoardVO vo);
			
	//자유게시판 신고 처리
	void insertReport(PlaceBoardVO vo);
	
	// 신고초기화
	   void reportReset(int pbNum);

}
