package com.spring.wefit.course.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.wefit.command.CourseBoardVO;
import com.spring.wefit.command.CourseReportVO;
import com.spring.wefit.commons.PageVO;

public interface ICourseBoardMapper {
   
   //글 등록
   void regist(CourseBoardVO vo);
   
   //글 목록
   List<CourseBoardVO> getList(PageVO vo);
   
   //총 게시물 수
   int getTotal(PageVO vo);
   
   //상세보기
   CourseBoardVO getContent(int cbNum);
   
   //수정
   void update(CourseBoardVO vo);
   
   //삭제   
   void delete(int cbNum);
   
   //조회수를 올려주는 메서드
   void upHit(int cbNum);
     
   //해당 글의 총 댓글수를 테이블에 넣어줌. //(매개변수가 두개라서 서비스,매퍼쪽에 @param 붙여야한다.!!)
   void updateCrCount(@Param("cbNum") int cbNum, @Param("crCount") int crCount);
   
  
   
   //좋아요 처리
   void insertLike(CourseBoardVO vo);
   
   //좋아요했는지 확인
   int checkLike(CourseBoardVO vo);
   
   //좋아요 삭제
   void deleteLike(CourseBoardVO vo);
   
   //해당 글에서 사용자들에게 받은 좋아요 수
   int countLike(int cbNum);
   
   
   
   //신고 처리
   void insertReport(CourseReportVO vo);
   
   //신고했는지 확인
   int checkReport(CourseReportVO vo);
   
   // 신고초기화
   void reportReset(int cbNum);
	
	

}