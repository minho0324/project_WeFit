package com.spring.wefit.placeboard.service;




import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.wefit.command.PlaceReplyVO;
import com.spring.wefit.placeboard.mapper.IPlaceReplyMapper;
import com.spring.wefit.commons.PageVO;

@Service 
public class PlaceReplyService implements IPlaceReplyService {
	
	@Autowired
	private IPlaceReplyMapper mapper;
	
	
	//장소게시판 댓글 등록
	@Override
	public void replyRegist(PlaceReplyVO vo) {
		mapper.placeReplyRegist(vo);
	}
	
	//장소게시판 댓글 목록
	@Override
	public List<PlaceReplyVO> replyGetList(PageVO vo, int pbNum) {
		Map<String, Object> datas = new HashMap<>();
		datas.put("paging", vo);
		datas.put("pbNum", pbNum);
	
		return mapper.replyGetList(datas);
	}
	
	//장소게시판 댓글 개수
	@Override
	public int replyGetTotal(int pbNum) {
		return mapper.replyGetTotal(pbNum);
	}
	
	//장소게시판 댓글 수정
	@Override
	public void replyUpdate(PlaceReplyVO vo) {
		mapper.replyUpdate(vo);
	}

	//장소게시판 댓글 삭제
	@Override
	public void replyDelete(int prNum) {
		mapper.replyDelete(prNum);
	}

	//장소게시판 댓글 상세
	@Override
	public PlaceReplyVO replyGetContent(int prNum) {
		return mapper.replyGetContent(prNum);
	}

	

}
