package com.spring.wefit.user.mapper;

import java.sql.Timestamp;
import java.util.Date;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.spring.wefit.command.UserVO;

public interface IUserMapper {
	
	// 이메일 중복 확인
	int emailCheck(String email);
	
	// 닉네임 중복 확인
	int nickCheck(String nick);
	
	//회원가입
	void join(UserVO vo);
	
	// 회원번호로 회원정보 얻어오기
	UserVO getContent(int memberNum);
	
	//회원정보 얻어오기
	UserVO getInfo(String email);
	
	//회원정보 수정하기
	void modify(UserVO vo);
	
	//회원탈퇴처리
	void withdrawal(String email);
	
	//회원삭제처리
	///////////////////게시글 및 댓글 및 좋아요 및 신고 삭제//////////////////////////
	void deletecourseboard(Date date);
	void deletecourselikely(Date date);
	void deletecoursereply(Date date);
	void deletecoursereport(Date date);

	void deletedietboard(Date date);
	void deletedietlikely(Date date);
	void deletedietreply(Date date);
	void deletedietreport(Date date);
	
	void deletefreeboard(Date date);
	void deletefreelikely(Date date);
	void deletefreereply(Date date);
	void deletefreereport(Date date);
	
	void deletemarketboard(Date date);
	void deletemarketlikely(Date date);
	void deletemarketreply(Date date);
	void deletemarketreport(Date date);
	
	void deletenoticeboard(Date date);
	void deletenoticelikely(Date date);
	void deletenoticereply(Date date);
	void deletenoticereport(Date date);
	
	void deleteplaceboard(Date date);
	void deleteplacelikely(Date date);
	void deleteplacereply(Date date);
	void deleteplacereport(Date date);
	
	
	////////////////////////////////////////////////////////////////////
	void deleteuser(Date date);
	
	
	//회원복구처리
	void recovery(String email);
	
	//자동 로그인 쿠키값DB저장 처리
	void keepLogin(Map<String, Object> datas);
	
	//세션 아이디를 통한 회원 정보 조회 기능
	UserVO getUserWithSessionId(String sessionId);
	
	//인증 처리
	void authUser(@Param("nick")String nick, @Param("code")String code);
	
	//인증 처리 후  인증값 변경
	void codeChange(@Param("nick")String nick, @Param("code")String code);
	
	//유저 위치 정보 등록하기
	void geoRegist(UserVO vo);
	
	//닉네임이랑 코드 확인
	int codeCheck(UserVO vo);
	
	//관리자 여부 체크
	int isManager(String email);
	
	//비밀번호 변경
	void passwdChange(UserVO vo);
	
	
	//휴면계정 처리
	void sleepUser(Date date);
}
