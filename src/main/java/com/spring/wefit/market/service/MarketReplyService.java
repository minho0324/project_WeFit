package com.spring.wefit.market.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.wefit.command.MarketReplyVO;
import com.spring.wefit.commons.PageVO;
import com.spring.wefit.market.mapper.IMarketReplyMapper;

@Service
public class MarketReplyService implements IMarketReplyService {

	@Autowired
	private IMarketReplyMapper mapper;
	
	@Override
	public void replyRegist(MarketReplyVO vo) {
		mapper.replyRegist(vo);
	}

	@Override
	public List<MarketReplyVO> getList(PageVO vo, int mbNum) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("paging", vo);
		map.put("mbNum", mbNum);
		
		return mapper.getList(map);
	}

	@Override
	public int getTotal(int mbNum) {
		return mapper.getTotal(mbNum);
	}

	@Override
	public void replyUpdate(MarketReplyVO vo) {
		mapper.replyUpdate(vo);
	}

	@Override
	public void replyDelete(int mbNum) {
		mapper.replyDelete(mbNum);

	}

	@Override
	public MarketReplyVO getContent(int mrNum) {
		return mapper.getContent(mrNum);
	}

}
