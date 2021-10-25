package com.spring.wefit.noticeboard.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.wefit.command.NoticeReplyVO;
import com.spring.wefit.commons.PageVO;
import com.spring.wefit.noticeboard.mapper.INoticeReplyMapper;

@Service
public class NoticeReplyService implements INoticeReplyService {
	
	@Autowired
	private INoticeReplyMapper mapper;

	@Override
	public void regist(NoticeReplyVO vo) {
	
		mapper.regist(vo);
	}

	@Override
	public List<NoticeReplyVO> getList(PageVO vo, int nbNum) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("paging", vo);
		map.put("nbNum",nbNum);
		return mapper.getList(map);
	}

	@Override
	public void update(NoticeReplyVO vo) {
		mapper.update(vo);
	}

	@Override
	public void delete(int nrNum) {
		
		mapper.delete(nrNum);
	}

	@Override
	public int getTotal(int nbNum) {
		
		return mapper.getTotal(nbNum);
	}

	@Override
	public NoticeReplyVO getContent(int nrNum) {
		
		return mapper.getContent(nrNum);
	}
	


}
