package com.spring.wefit.placeboard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.wefit.command.CourseReportVO;
import com.spring.wefit.command.PlaceBoardVO;
import com.spring.wefit.commons.PageVO;
import com.spring.wefit.placeboard.mapper.IPlaceBoardMapper;


@Service
public class PlaceBoardService implements IPlaceBoardService{

	@Autowired
	private IPlaceBoardMapper mapper;

	//장소 글 등록
	@Override
	public void regist(PlaceBoardVO vo) {
		mapper.regist(vo);
	}

	//장소 글 목록
	@Override
	public List<PlaceBoardVO> getList(PageVO vo) {
		List<PlaceBoardVO> list = mapper.getList(vo);
		return list;
	}
	
	//장소 총 게시물 수
	@Override
	public int getTotal(PageVO vo) {
		return mapper.getTotal(vo);
	}
	
	//장소 글 상세보기
	@Override
	public PlaceBoardVO getContent(int pbNum) {
		return mapper.getContent(pbNum);
	}
	
	//장소 글 수정
	@Override
	public void update(PlaceBoardVO vo) {
		mapper.update(vo);
	}
	
	//장소 글 삭제
	@Override
	public void delete(int pbNum) {
		mapper.delete(pbNum);
	}

	//장소 조회수 처리
	@Override
	   public void upHit(int pbNum) {
	      mapper.upHit(pbNum);
	}

	
	
	//장소 좋아요수 처리
	@Override
	public void insertLike(PlaceBoardVO vo) {
		mapper.insertLike(vo);
	}

	//장소 좋아요수 체크
	@Override
	public int checkLike(PlaceBoardVO vo) {
		return mapper.checkLike(vo);
	}

	//장소 좋아요수 삭제
	@Override
	public void deleteLike(PlaceBoardVO vo) {
		mapper.deleteLike(vo);		
	}
	
	//장소 해당 글 좋아요 수 카운트
	@Override
	public int countLike(int pbNum) {
	   	return mapper.countLike(pbNum);
	}

	
	
	//장소게시판 신고 했는지 확인
	@Override
	public int checkReport(PlaceBoardVO vo) {
		return mapper.checkReport(vo);
	}

	//장소게시판 신고 처리
	@Override
	public void insertReport(PlaceBoardVO vo) {
		mapper.insertReport(vo);
	}

	@Override
	public void reportReset(int pbNum) {
		// TODO Auto-generated method stub
		mapper.reportReset(pbNum);
	}

}
