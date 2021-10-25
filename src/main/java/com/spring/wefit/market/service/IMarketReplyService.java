package com.spring.wefit.market.service;

import java.util.List;

import com.spring.wefit.command.MarketReplyVO;
import com.spring.wefit.commons.PageVO;

public interface IMarketReplyService {
	
	//댓글 등록
	void replyRegist(MarketReplyVO vo);
	
	//댓글 목록
	List<MarketReplyVO> getList(PageVO vo, int mbNum);
	
	//댓글 수
	int getTotal(int mbNum);
	
	//댓글 수정
	void replyUpdate(MarketReplyVO vo);
	
	//댓글 삭제 
	void replyDelete(int mrNum);
	
	MarketReplyVO getContent(int mrNum);


}
