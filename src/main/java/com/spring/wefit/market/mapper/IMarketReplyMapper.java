package com.spring.wefit.market.mapper;

import java.util.List;
import java.util.Map;

import com.spring.wefit.command.MarketReplyVO;

public interface IMarketReplyMapper {
	
	//댓글 등록
	void replyRegist(MarketReplyVO vo);
	
	//댓글 목록
	List<MarketReplyVO> getList(Map<String, Object> datas);
	
	//댓글 수
	int getTotal(int mbNum);
	
	//댓글 수정
	void replyUpdate(MarketReplyVO vo);
	
	//댓글 삭제 
	void replyDelete(int mrNum);
	
	//글 불러오기
	MarketReplyVO getContent(int mrNum);

}
