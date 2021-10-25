package com.spring.wefit.noticeboard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.wefit.command.CourseBoardVO;
import com.spring.wefit.command.NoticeBoardVO;
import com.spring.wefit.commons.PageVO;
import com.spring.wefit.noticeboard.mapper.INoticeBoardMapper;

@Service
public class NoticeBoardService implements INoticeBoardService {

	
	@Autowired
	private INoticeBoardMapper mapper;
	
	@Override
	public void regist(NoticeBoardVO vo) {
		mapper.regist(vo);

	}

	@Override
	public List<NoticeBoardVO> getList(PageVO vo) {
		
		return mapper.getList(vo);
	}

	@Override
	public int getTotal(PageVO vo) {
		
		return mapper.getTotal(vo);
	}

	@Override
	public NoticeBoardVO getContent(int nbNum) {
		return mapper.getContent(nbNum);
	}

	@Override
	public void update(NoticeBoardVO vo) {
		mapper.update(vo);

	}


	@Override
	public void delete(int nbNum) {
		mapper.delete(nbNum);
		
	}

	

	@Override
	public void updateViewCount(int nbNum) {
		mapper.updateViewCount(nbNum);
		
	}

	

	@Override
	public void insertLovely(NoticeBoardVO vo) {
		mapper.insertLovely(vo);
		
	}

	@Override
	public int checkReport(NoticeBoardVO vo) {
		return mapper.checkReport(vo);
	}

	@Override
	public void insertReport(NoticeBoardVO vo) {
		mapper.insertReport(vo);
	}

	@Override
	public int checkLovely(NoticeBoardVO vo) {
		return mapper.checkLovely(vo);
	}

	@Override
	public void deleteLike(NoticeBoardVO vo) {
		// TODO Auto-generated method stub
		mapper.deleteLike(vo);
	}

	@Override
	public int countLike(int nbNum) {
		// TODO Auto-generated method stub
		return mapper.countLike(nbNum);
	}

	@Override
	public void reportReset(int nbNum) {
		// TODO Auto-generated method stub
		mapper.reportReset(nbNum);
	}

	
}
