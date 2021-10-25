package com.spring.wefit.noticeboard.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.spring.wefit.command.NoticeReplyVO;
import com.spring.wefit.commons.PageVO;

@Service
public interface INoticeReplyService {

	//공지 댓 등록
	void regist(NoticeReplyVO vo);
	
	//공지 댓 리스트
	List<NoticeReplyVO> getList(PageVO vo, int nbNum);
	
	//공지 댓 수정
	void update(NoticeReplyVO vo);
	
	//공지 댓 삭제
	void delete(int nrNum);
	
	//공지 댓 수
	int getTotal(int nbNum);
	
	//공지 댓 상세
	NoticeReplyVO getContent(int nrNum);
		
	
	
	
}