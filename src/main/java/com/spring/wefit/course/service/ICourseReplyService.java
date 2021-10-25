package com.spring.wefit.course.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.wefit.command.CourseBoardVO;
import com.spring.wefit.command.CourseReplyVO;
import com.spring.wefit.commons.PageVO;

public interface ICourseReplyService {
	
	//댓글 등록
	void regist(CourseReplyVO vo);
	
	//목록 요청
	List<CourseReplyVO> getList(@Param("vo") PageVO vo, @Param("cbNum") int cbNum);
	
	//댓글 개수
	int getTotal(int cbNum);

	//댓글 수정
	void update(CourseReplyVO vo);
	
	//댓글 삭제
	void delete(int crNum);	
	
	//댓글 수정, 삭제 권한 체크
	int memberCheck(CourseReplyVO vo);
	
	// 댓글상세정보
	CourseReplyVO getContent(int crNum);

	//댓글 바이트 출력
	int getCrByte(int crNum);
}
