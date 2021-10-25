package com.spring.wefit.free.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.wefit.command.FreeBoardVO;
import com.spring.wefit.commons.PageVO;
import com.spring.wefit.free.mapper.IFreeBoardMapper;

@Service
public class FreeBoardService implements IFreeBoardService {

	
	@Autowired
	private IFreeBoardMapper mapper;
	
	@Override
	public void regist(FreeBoardVO vo) {
		// TODO Auto-generated method stub
		mapper.regist(vo);
	}

	@Override
	public List<FreeBoardVO> getList(PageVO vo) {
		// TODO Auto-generated method stub
		return mapper.getList(vo);
	}

	@Override
	public FreeBoardVO getContent(int fbNum) {
		// TODO Auto-generated method stub
		return mapper.getContent(fbNum);
	}

	@Override
	public void update(FreeBoardVO vo) {
		// TODO Auto-generated method stub
		mapper.update(vo);
	}

	@Override
	public void delete(int fbNum) {
		// TODO Auto-generated method stub
		mapper.delete(fbNum);
	}

	@Override
	public int getTotal(PageVO vo) {
		// TODO Auto-generated method stub
		return mapper.getTotal(vo);
	}

	@Override
	public void updateViewCount(int fbNum) {
		// TODO Auto-generated method stub
		mapper.updateViewCount(fbNum);
	}

	@Override
	public int checkLovely(FreeBoardVO vo) {
		// TODO Auto-generated method stub
		return mapper.checkLovely(vo);
	}

	@Override
	public void insertLovely(FreeBoardVO vo) {
		// TODO Auto-generated method stub
		mapper.insertLovely(vo);
	}

	@Override
	public int checkReport(FreeBoardVO vo) {
		// TODO Auto-generated method stub
		return mapper.checkReport(vo);
	}

	@Override
	public void insertReport(FreeBoardVO vo) {
		// TODO Auto-generated method stub
		mapper.insertReport(vo);
	}

	@Override
	public void deleteLovely(FreeBoardVO vo) {
		// TODO Auto-generated method stub
		mapper.deleteLovely(vo);
	}

	@Override
	public int countLike(int fbNum) {
		// TODO Auto-generated method stub
		return mapper.countLike(fbNum);
	}

	@Override
	public void reportReset(int fbNum) {
		// TODO Auto-generated method stub
		mapper.reportReset(fbNum);
	}



	
	
}
