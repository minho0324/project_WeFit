package com.spring.wefit.diet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.wefit.command.DietBoardVO;
import com.spring.wefit.commons.PageVO;
import com.spring.wefit.diet.mapper.IDietBoardMapper;

@Service
public class DietBoardService implements IDietBoardService {

	@Autowired
	private IDietBoardMapper mapper;
	
	@Override
	public void regist(DietBoardVO vo) {
		mapper.regist(vo);
	}

	@Override
	public List<DietBoardVO> getList(PageVO vo) {
		return mapper.getList(vo);
	}

	@Override
	
	public DietBoardVO getContent(int dbNum) {
		return mapper.getContent(dbNum);
	}

	@Override
	public void update(DietBoardVO vo) {
		mapper.update(vo);
	}

	@Override
	public void delete(int dbNum) {
		mapper.delete(dbNum);

	}

	@Override
	public int getTotal(PageVO vo) {
		return mapper.getTotal(vo);
	}
	
	@Override
	public int checkLovely(DietBoardVO vo) {
		return mapper.checkLovely(vo);
	}
	
	@Override
	public int checkReport(DietBoardVO vo) {
		return mapper.checkReport(vo);
	}
	
	@Override
	public void insertLovely(DietBoardVO vo) {
		mapper.insertLovely(vo);
		
	}
	
	@Override
	public void insertReport(DietBoardVO vo) {
		mapper.insertReport(vo);
		
	}
	
	@Override
	public void updateViewCount(int dbNum) {
		mapper.updateViewCount(dbNum);
		
	}
	
	@Override
	public int countLovely(int dbNum) {
		
		return mapper.countLovely(dbNum);
	}
	
	@Override
	public void deleteLike(DietBoardVO vo) {
		mapper.deleteLike(vo);
		
	}

	@Override
	public void reportReset(int dbNum) {
		// TODO Auto-generated method stub
		mapper.reportReset(dbNum);
	}
	
	@Override
	public int countReport(int dbNum) {
		return mapper.countReport(dbNum);
	}
	
	
	
	
	

}













