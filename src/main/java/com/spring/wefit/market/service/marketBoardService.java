package com.spring.wefit.market.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.wefit.command.CourseBoardVO;
import com.spring.wefit.command.MarketBoardVO;
import com.spring.wefit.commons.PageVO;
import com.spring.wefit.market.mapper.IMarketBoardMapper;

@Service
public class marketBoardService implements IMarketBoardService {
	
	@Autowired
	private IMarketBoardMapper mapper;

	@Override
	public void regist(MarketBoardVO vo) {
		mapper.regist(vo);

	}

	@Override
	public List<MarketBoardVO> getList(PageVO vo) {
		
		return mapper.getList(vo);
	}

	@Override
	public int getTotal(PageVO vo) {
		return mapper.getTotal(vo);
	}

	@Override
	public MarketBoardVO getContent(int mbNum) {
		return mapper.getContent(mbNum);
	}

	@Override
	public void update(MarketBoardVO vo) {
		mapper.update(vo);
	}

	@Override
	public void delete(int mbNum) {
		mapper.delete(mbNum);
	}

	@Override
	public void updateViewCount(int mbNum) {

		mapper.updateViewCount(mbNum);
	}

	@Override
	public int checkLovely(MarketBoardVO vo) {
		return mapper.checkLovely(vo);
	}

	@Override
	public void insertLovely(MarketBoardVO vo) {
		mapper.insertLovely(vo);
	}

	@Override
	public int checkReport(MarketBoardVO vo) {
		return mapper.checkReport(vo);
	}

	@Override
	public void insertReport(MarketBoardVO vo) {
		mapper.insertReport(vo);
	}

	@Override
	public void deleteLike(MarketBoardVO vo) {
		// TODO Auto-generated method stub
		mapper.deleteLike(vo);
	}

	@Override
	public int countLike(int mbNum) {
		// TODO Auto-generated method stub
		return mapper.countLike(mbNum);
	}

	@Override
	public void reportReset(int mbNum) {
		// TODO Auto-generated method stub
		mapper.reportReset(mbNum);
	}

}
