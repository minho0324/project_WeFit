package com.spring.wefit;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.spring.wefit.command.marketBoardVO;
import com.spring.wefit.market.mapper.IMarketBoardMapper;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/file:src/main/webapp/WEB-INF/config/db-config.xml")
public class marketBoardMapperTest {
	
	@Autowired
	private IMarketBoardMapper mapper;
	
	@Test
	public void registTest() {
		for(int i=1; i<30; i++) {
			marketBoardVO vo = new marketBoardVO();
			vo.setMbNum(i);
			vo.setMemberNum(i);
			vo.setMbType("�׽�Ʈ" +i);
			vo.setMbContent("�׽�Ʈ" + i);
			vo.setMbAddrBasic("test"+ i);
			vo.setMbAddrDetail("test");
			
			mapper.regist(vo);
			
		}
	}
	
	@Test
	public void testModify() {
		
	}

}
