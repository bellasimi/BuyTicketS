package com.tj.hsy;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	DAO da = new DAO();
	@Autowired
	public void setDa(DAO da) {
		this.da = da;
	}
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}//시간
	@RequestMapping("/form")
	public String form() {
		 return "withdraw";
	}//form
	@RequestMapping("/withdraw")
	public String withdraw(@ModelAttribute("d") DTO dto) {

		dto.setLeft(dto.getInput()-dto.getWithdraw());
		da.withdraw(dto);
		return "result";
	}//withdraw
	@RequestMapping("/bankout")
	public String bankout(DTO dto,Model model) {
		ArrayList<DTO> al = da.list();
		model.addAttribute("list",al);
		return "bankout";
	}//bankout
}//전체
