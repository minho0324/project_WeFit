package com.spring.wefit.free.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.wefit.command.FreeReplyVO;
import com.spring.wefit.commons.PageVO;
import com.spring.wefit.free.mapper.IFreeReplyMapper;

@Service
public class FreeReplyService implements IFreeReplyService {

	@Autowired
	private IFreeReplyMapper mapper;

	@Override
	public void regist(FreeReplyVO vo) {
		// TODO Auto-generated method stub
		mapper.regist(vo);
	}

	@Override
	public List<FreeReplyVO> getList(PageVO vo, int fbNum) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("paging", vo);
		map.put("fbNum",fbNum);
		return mapper.getList(map);
	}

	@Override
	public void update(FreeReplyVO vo) {
		// TODO Auto-generated method stub
		mapper.update(vo);
	}

	@Override
	public void delete(int frNum) {
		// TODO Auto-generated method stub
		mapper.delete(frNum);
	}

	@Override
	public int getTotal(int fbNum) {
		// TODO Auto-generated method stub
		return mapper.getTotal(fbNum);
	}

	@Override
	public FreeReplyVO getContent(int frNum) {
		// TODO Auto-generated method stub
		return mapper.getContent(frNum);
	}
	
	

}
