package com.spring.wefit.free.service;

import java.util.List;

import com.spring.wefit.command.FreeBoardVO;
import com.spring.wefit.commons.PageVO;

public interface IFreeBoardService {
	
	
	//자유게시판  글 등록
	void regist(FreeBoardVO vo);
	
	//자유게시판 글 목록
	List<FreeBoardVO> getList(PageVO vo);
	
	//자유게시판 글 상세보기
	FreeBoardVO getContent(int fbNum);
	
	//자유게시판 글 수정
	void update(FreeBoardVO vo);
	
	//자유게시판 글 삭제
	void delete (int fbNum);
	
	//자유게시판 총 게시물 수
	int getTotal(PageVO vo);
	
	//자유게시판 조회수 수정
	void updateViewCount(int fbNum);
	
	//자유게시판 좋아요 했는지 확인
	int checkLovely(FreeBoardVO vo);
	
	//자유게시판 좋아요 추가
	void insertLovely(FreeBoardVO vo);
	
	//자유게시판 좋아요 삭제
	void deleteLovely(FreeBoardVO vo);
	
	//자유게시판 좋아요 개수
	int countLike(int fbNum);
	
	//자유게시판 신고 했는지 확인
	int checkReport(FreeBoardVO vo);
	
	//자유게시판 신고 처리
	void insertReport(FreeBoardVO vo);
	
	// 신고초기화
	   void reportReset(int fbNum);
}
