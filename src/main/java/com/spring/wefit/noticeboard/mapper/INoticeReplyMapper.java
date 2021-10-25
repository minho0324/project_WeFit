package com.spring.wefit.noticeboard.mapper;

import java.util.List;
import java.util.Map;

import com.spring.wefit.command.NoticeReplyVO;

public interface INoticeReplyMapper {
	
		//댓글 등록
		void regist(NoticeReplyVO vo); 
		
		//댓글 목록
		List<NoticeReplyVO> getList(Map<String, Object> datas);
		
		//댓글 개수
		int getTotal(int nbNum); 
		
		//비밀번호 확인
		int pwCheck(NoticeReplyVO vo); 
		
		//댓글 수정
		void update(NoticeReplyVO vo); 
		
		//댓글 삭제
		void delete(int nrNum);
		
		//댓글 상세정보
		NoticeReplyVO getContent(int nrNum);
	

}
