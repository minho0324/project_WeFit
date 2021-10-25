package com.spring.wefit.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.spring.wefit.command.CourseBoardVO;
import com.spring.wefit.command.DietBoardVO;
import com.spring.wefit.command.FreeBoardVO;
import com.spring.wefit.command.MarketBoardVO;
import com.spring.wefit.command.NoticeBoardVO;
import com.spring.wefit.command.PlaceBoardVO;
import com.spring.wefit.commons.PageVO;
import com.spring.wefit.course.service.ICourseBoardService;
import com.spring.wefit.diet.service.IDietBoardService;
import com.spring.wefit.free.service.IFreeBoardService;
import com.spring.wefit.market.service.IMarketBoardService;
import com.spring.wefit.noticeboard.service.INoticeBoardService;
import com.spring.wefit.placeboard.service.IPlaceBoardService;
import com.spring.wefit.user.service.IUserService;



/**
 * Handles requests for the application home page.
 */


@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private IUserService userservice;

	@Autowired
	private ICourseBoardService courseservice;
	
	@Autowired 
	private IDietBoardService dietservice;
	
	@Autowired
	private IFreeBoardService freeservice;
	
	@Autowired 
	private IMarketBoardService marketservice;
	
	@Autowired
	private INoticeBoardService noticeservice;
	
	@Autowired 
	private IPlaceBoardService placeservice;	
	
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@GetMapping("/")
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		userservice.sleepUser(date);
		userservice.delete(date);
		
		
		PageVO vo = new PageVO();
		vo.setPageNum(1);
		vo.setCategory("");
		vo.setCountPerPage(4);
		List<DietBoardVO> dietlist = dietservice.getList(vo);
		List<MarketBoardVO> marketlist = marketservice.getList(vo);
		List<CourseBoardVO> courselist = courseservice.getList(vo);
		
		vo.setCountPerPage(5);
		List<FreeBoardVO> freelist = freeservice.getList(vo);
		
		vo.setCountPerPage(9);
		List<NoticeBoardVO> noticelist = noticeservice.getList(vo);
		
		model.addAttribute("dietlist", dietlist);
		model.addAttribute("courselist", courselist);
		model.addAttribute("freelist", freelist);
		model.addAttribute("marketlist", marketlist);
		model.addAttribute("noticelist", noticelist);
		
		return "home";
	}
	
}

