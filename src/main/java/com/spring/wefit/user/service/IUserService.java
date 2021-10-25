package com.spring.wefit.user.service;

import java.util.Date;
import java.sql.Timestamp;


import org.apache.ibatis.annotations.Param;

import com.spring.wefit.command.UserVO;

public interface IUserService {

	
	// 회원번호로 회원정보 얻어오기
		UserVO getContent(int memberNum);
		
		// 이메일 중복 확인
		int emailCheck(String email);
		
		// 닉네임 중복 확인
		int nickCheck(String nick);
		
		//회원가입
		void join(UserVO vo);
		
		//회원정보 얻어오기
		UserVO getInfo(String email);
		
		//회원정보 수정하기
		void modify(UserVO vo);
		
		//회원탈퇴처리
		void withdrawal(String email);
		
		//회원삭제처리
		void delete(Date date);
		
		//회원복구처리
		void recovery(String email);
		
		//자동 로그인 쿠키값DB저장 처리
		void keepLogin(String sessionId, Date limitTime, String account);
		
		//세션 아이디를 통한 회원 정보 조회 기능
		UserVO getUserWithSessionId(String sessionId);
		
		// 가입 인증 이메일 전송
		void mailSendAuth(UserVO vo);
		
		// 비밀번호 변경 링크 이메일 전송
		void mailSendPasswdChange(UserVO vo);
		
		//링크 클릭시 인증하기
		public void authUser(String nick, String code);
		
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
