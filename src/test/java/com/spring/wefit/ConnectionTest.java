package com.spring.wefit;

import java.util.UUID;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.spring.wefit.command.DietBoardVO;
import com.spring.wefit.command.UserVO;
import com.spring.wefit.dietboard.mapper.IDietBoardMapper;
import com.spring.wefit.test.ITestMapper;
import com.spring.wefit.user.mapper.IUserMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/config/db-config.xml")
@Log4j
@WebAppConfiguration
public class ConnectionTest {
	
	@Autowired
	
	private IUserMapper usermapper;
	
	private ITestMapper mapper;
	
	
	
	@Autowired
	private IDietBoardMapper dietMapper;
	
	@Test
	public void registTest() {
		for(int i=1; i<=1000; i++) {
			DietBoardVO vo = new DietBoardVO();
			vo.setMemberNum(i);
			vo.setDbTitle("테스트" + i);
			vo.setDbContent("테스트" + i);
			vo.setDbLookCount(i);
			vo.setDbImageCount(i);
			
			dietMapper.regist(vo);
		}
	}
	
	@Test
	public void test(){
		double d = (double) mapper.test();
		System.out.println(d);
	}
	@Test
	public void updateTest() {
		UserVO vo = new UserVO();
		for(int i=2;i<51;i=i+2) {
			
			vo = usermapper.getInfo("test"+i+"@test.com");
			if(vo != null) {
				usermapper.authUser(vo.getMemberNick(), vo.getMemberCode());			
				
			}
		}
	}
	
	@Test
	public void test2() {
		System.out.println(usermapper.emailCheck("test@emi.com"));
	}
	
	@Test
	public void joinTest() {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		UserVO vo = new UserVO();
		for(int i=51;i<101;i++) {
			//vo.setMEmail("test"+i+"@test.com");
			vo.setMemberNick("test"+i);
			vo.setMemberPasswd(encoder.encode(Integer.toString(i)));
			vo.setMemberPhone("010111111"+(i<10?"0":"")+i);
			vo.setMemberHumanYN("N");
			vo.setMemberEmailYN("Y");
			vo.setMemberCode(UUID.randomUUID().toString().split("-")[0]);
			System.out.println(vo.toString());
			usermapper.join(vo);
		}
	}
}
