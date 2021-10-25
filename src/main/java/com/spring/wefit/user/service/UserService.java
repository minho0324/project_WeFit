package com.spring.wefit.user.service;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.spring.wefit.command.UserVO;
import com.spring.wefit.user.mapper.IUserMapper;

@Service
public class UserService implements IUserService {

	@Autowired
	private IUserMapper mapper;
	
	@Autowired
	private JavaMailSender mailSender;


	
	@Override
	public int emailCheck(String email) {
		// TODO Auto-generated method stub
		System.out.println(email);
		return mapper.emailCheck(email);
	}

	@Override
	public int nickCheck(String nick) {
		// TODO Auto-generated method stub
		
		return mapper.nickCheck(nick);
	}

	@Override
	public void join(UserVO vo) {
		// TODO Auto-generated method stub
		System.out.println(vo.getMemberPasswd());
		// 회원 비밀번호 암호화 인코딩
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		System.out.println("암호화 하기 전: "+vo.getMemberPasswd());
		//비밀번호를 암호화해서 user객체에 다시 저장하기
		String securePw = encoder.encode(vo.getMemberPasswd());
		System.out.println("암호화 한 후: "+securePw);
		vo.setMemberPasswd(securePw);
		
		// 이메일 인증 랜덤코드값
		UUID uuid = UUID.randomUUID();
		String[] uuids = uuid.toString().split("-");
		vo.setMemberCode(uuids[0]);
		
		
		System.out.println(vo.toString());
		mapper.join(vo);
		
	}

	@Override
	public UserVO getInfo(String email) {
		// TODO Auto-generated method stub
		return mapper.getInfo(email);
	}

	@Override
	public void modify(UserVO vo) {
		// TODO Auto-generated method stub
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		System.out.println("암호화 하기 전: "+vo.getMemberPasswd());
		//비밀번호를 암호화해서 user객체에 다시 저장하기
		String securePw = encoder.encode(vo.getMemberPasswd());
		System.out.println("암호화 한 후: "+securePw);
		vo.setMemberPasswd(securePw);
		mapper.modify(vo);
	}

	@Override
	public void withdrawal(String email) {
		// TODO Auto-generated method stub
		mapper.withdrawal(email);
	}

	@Override
	public void delete(Date date) {
		// TODO Auto-generated method stub
		// 댓글 삭제
		mapper.deletecoursereply(date);
		mapper.deletedietreply(date);
		mapper.deletefreereply(date);
		mapper.deletemarketreply(date);
		mapper.deletenoticereply(date);
		mapper.deleteplacereply(date);
		
		// 좋아요 삭제
		mapper.deletecourselikely(date);
		mapper.deletedietlikely(date);
		mapper.deletefreelikely(date);
		mapper.deletemarketlikely(date);
		mapper.deletenoticelikely(date);
		mapper.deleteplacelikely(date);
		
		
		// 신고 삭제
		mapper.deletecoursereport(date);
		mapper.deletedietreport(date);
		mapper.deletefreereport(date);
		mapper.deletemarketreport(date);
		mapper.deletenoticereport(date);
		mapper.deleteplacereport(date);
		
		// 게시글 삭제
		mapper.deletecourseboard(date);
		mapper.deletedietboard(date);
		mapper.deletefreeboard(date);
		mapper.deletemarketboard(date);
		mapper.deletenoticeboard(date);
		mapper.deleteplaceboard(date);
		
		//유저삭제 맨 마지막
		mapper.deleteuser(date);
	}

	@Override
	public void recovery(String email) {
		// TODO Auto-generated method stub
		mapper.recovery(email);
	}

	@Override
	public void keepLogin(String sessionId, Date limitTime, String email) {
		// TODO Auto-generated method stub
		
		Map<String, Object> map = new HashMap<>();
		map.put("sessionId", (String) sessionId);
		map.put("autoLoginLimit", (Date) limitTime);
		map.put("memberEmail", (String) email);
		map.forEach((key, value) -> {
			System.out.println(key + " : " + value);
		});

		mapper.keepLogin(map);

	}

	@Override
	public UserVO getUserWithSessionId(String sessionId) {
		// TODO Auto-generated method stub
		return mapper.getUserWithSessionId(sessionId);
	}
	
	// 가입인증 이메일 발송
	@Override
	public void mailSendAuth(UserVO vo) {
		
		
		MimeMessage mail = mailSender.createMimeMessage();
		String htmlStr = "<h2>안녕하세요 WeFit입니다!</h2><br><br>" 
				+ "<h3>" + vo.getMemberNick() + "님</h3>" + "<p>인증하기 버튼을 누르시면 로그인을 하실 수 있습니다 : " 
				+ "<a href='http://localhost/wefit"
				+ "/user/auth/"+vo.getMemberNick() +"/"+vo.getMemberCode()+"'>인증하기</a></p>"
				+ "(혹시 잘못 전달된 메일이라면 이 이메일을 무시하셔도 됩니다)";
		try {
			mail.setSubject("[본인인증] WeFit 인증메일입니다", "utf-8");
			mail.setText(htmlStr, "utf-8", "html");
			mail.addRecipient(RecipientType.TO, new InternetAddress(vo.getMemberEmail()));
			mailSender.send(mail); 
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void authUser(String nick, String code) {
		System.out.println("서비스 요청: 인증서비스");
		System.out.println(nick);
		System.out.println(code);
		mapper.authUser(nick, code);
		
		// 이메일 랜덤코드값
		UUID uuid = UUID.randomUUID();
		String[] uuids = uuid.toString().split("-");
		
		mapper.codeChange(nick, uuids[0]);
	}

	@Override
	public void geoRegist(UserVO vo) {
		// TODO Auto-generated method stub
		mapper.geoRegist(vo);
	}
	
	//닉네임이랑 코드 확인
	public int codeCheck(UserVO vo) {
		return mapper.codeCheck(vo);
	}

	@Override
	public int isManager(String email) {
		// TODO Auto-generated method stub
		return mapper.isManager(email);
	}

	@Override
	public void mailSendPasswdChange(UserVO vo) {
		// TODO Auto-generated method stub
		MimeMessage mail = mailSender.createMimeMessage();
		String htmlStr = "<h2>안녕하세요 WeFit입니다!</h2><br><br>" 
				+ "<h3>" + vo.getMemberNick() + "님</h3>" + "<p>비밀번호변경 버튼을 누르시면 비밀번호 변경페이지로 안내합니다.: " 
				+ "<a href='http://localhost/wefit"
				+ "/user/passwdChange/"+vo.getMemberNick() +"/"+vo.getMemberCode()+"'>비밀번호 변경하기</a></p>"
				+ "(혹시 잘못 전달된 메일이라면 이 이메일을 무시하셔도 됩니다)";
		try {
			mail.setSubject("[비밀번호변경] WeFit 비밀번호변경 메일입니다", "utf-8");
			mail.setText(htmlStr, "utf-8", "html");
			mail.addRecipient(RecipientType.TO, new InternetAddress(vo.getMemberEmail()));
			mailSender.send(mail); 
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void passwdChange(UserVO vo) {
		// TODO Auto-generated method stub
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		System.out.println("암호화 하기 전: "+vo.getMemberPasswd());
		//비밀번호를 암호화해서 user객체에 다시 저장하기
		String securePw = encoder.encode(vo.getMemberPasswd());
		System.out.println("암호화 한 후: "+securePw);
		vo.setMemberPasswd(securePw);
		mapper.passwdChange(vo);
		// 랜덤코드값
		UUID uuid = UUID.randomUUID();
		String[] uuids = uuid.toString().split("-");
		
		mapper.codeChange(vo.getMemberNick(), uuids[0]);
	}
	
	public void sleepUser(Date date) {
		mapper.sleepUser(date);
	}

	@Override
	public UserVO getContent(int memberNum) {
		// TODO Auto-generated method stub
		return mapper.getContent(memberNum);
	}
	

}
