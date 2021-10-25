package com.spring.wefit.noticeboard.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.spring.wefit.command.CourseBoardVO;
import com.spring.wefit.command.DietBoardVO;
import com.spring.wefit.command.NoticeBoardVO;
import com.spring.wefit.commons.PageVO;

public interface INoticeBoardService {
	

	
		//글 등록
		void regist(NoticeBoardVO vo);
		
		//총 게시물 수
		int getTotal(PageVO vo);
		
		//글 상세보기
		NoticeBoardVO getContent(int nbNum);
		
		//글 수정
		void update(NoticeBoardVO vo);

		//글 삭제
		void delete(int nbNum);
		
		//글 목록
		List<NoticeBoardVO> getList(PageVO vo);

		//조회수 수정
		void updateViewCount(int nbNum);
		
		//좋아요 여부
		int checkLovely(NoticeBoardVO vo);
		
		// 좋아요 처리
		void insertLovely(NoticeBoardVO vo);
		
		   
	   //좋아요 삭제
	   void deleteLike(NoticeBoardVO vo);
	   
	   //해당 글에서 사용자들에게 받은 좋아요 수
	   int countLike(int nbNum);
		
		//신고 여부
		int checkReport(NoticeBoardVO vo);
		
		//신고 처리
		void insertReport(NoticeBoardVO vo);
		
		// 신고초기화
		   void reportReset(int nbNum);

		

	
	
}

