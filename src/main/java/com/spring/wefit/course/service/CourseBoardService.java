package com.spring.wefit.course.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.wefit.command.CourseBoardVO;
import com.spring.wefit.command.CourseReportVO;
import com.spring.wefit.commons.PageVO;
import com.spring.wefit.course.mapper.ICourseBoardMapper;

@Service
public class CourseBoardService implements ICourseBoardService {
   
   @Autowired
   private ICourseBoardMapper mapper;

   @Override
   public void regist(CourseBoardVO vo) {      
      mapper.regist(vo);      
   }

   @Override
   public List<CourseBoardVO> getList(PageVO vo) {
      List<CourseBoardVO> list = mapper.getList(vo);
      return list;
   }

   @Override
   public int getTotal(PageVO vo) {      
      return mapper.getTotal(vo);
   }

   @Override
   public CourseBoardVO getContent(int cbNum) {
      return mapper.getContent(cbNum);
   }

   @Override
   public void update(CourseBoardVO vo) {
      mapper.update(vo);   
   }

   @Override
   public void delete(int cbNum) {
      mapper.delete(cbNum);      
   }

   @Override
   public void upHit(int cbNum) {
      mapper.upHit(cbNum);
   }
   
   @Override
   public void updateCrCount(@Param("cbNum") int cbNum, @Param("crCount") int crCount) {  	
   	  mapper.updateCrCount(cbNum, crCount);
   }
   
   

   
   @Override
   public void insertLike(CourseBoardVO vo) {
	   mapper.insertLike(vo);		
   }

   @Override
   public int checkLike(CourseBoardVO vo) {
	   return mapper.checkLike(vo);
   }

   @Override
   public void deleteLike(CourseBoardVO vo) {
	   mapper.deleteLike(vo);		
   }
   
   @Override
   public int countLike(int cbNum) {
   	   return mapper.countLike(cbNum);
   }
   
	
   @Override
   public void insertReport(CourseReportVO vo) {
	   mapper.insertReport(vo);	
   }
	
   @Override
   public int checkReport(CourseReportVO vo) {
	   return mapper.checkReport(vo);
   }

@Override
public void reportReset(int cbNum) {
	// TODO Auto-generated method stub
	mapper.reportReset(cbNum);
}

   
   
}