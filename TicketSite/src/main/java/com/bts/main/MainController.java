package com.bts.main;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.bts.common.base.BaseController;
import com.bts.goods.service.GoodsService;
import com.bts.goods.vo.GoodsVO;

@Controller("mainController")
@EnableAspectJAutoProxy
public class MainController extends BaseController {
	@Autowired
	private GoodsService goodsService;
//메인페이지
	@RequestMapping(value= "/main/main.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session;
		ModelAndView mav=new ModelAndView();
		String viewName=(String)request.getAttribute("viewName");
		mav.setViewName(viewName);
		
		session=request.getSession();
		session.setAttribute("side_menu", "user");
		Map<String,List<GoodsVO>> goodsMap=goodsService.StatusList();//bestseller,bigsale,new
		System.out.println(goodsMap);
		mav.addObject("goodsMap", goodsMap);
		return mav;
	}
//찾아오시는 길
	@RequestMapping(value= "/main/address.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView addr(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session;
		ModelAndView mav=new ModelAndView();
		String viewName=(String)request.getAttribute("viewName");
		mav.setViewName(viewName);
		
		session=request.getSession();
		session.setAttribute("side_menu", "user");
		Map<String,List<GoodsVO>> goodsMap=goodsService.StatusList();
		mav.addObject("goodsMap", goodsMap);
		return mav;
	}
//화사소개 "/main/about.do" 
	@RequestMapping(value= "/main/about.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView mainabout(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session;
		ModelAndView mav=new ModelAndView();
		String viewName=(String)request.getAttribute("viewName");
		mav.setViewName(viewName);
		
		
		return mav;
	}
//이용약관 
	@RequestMapping(value= "/main/terms.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView mainterms(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session;
		ModelAndView mav=new ModelAndView();
		String viewName=(String)request.getAttribute("viewName");
		mav.setViewName(viewName);
		
		
		return mav;
	}
	
//이용약관 
	@RequestMapping(value= "/main/privacy.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView mainprivacy(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session;
		ModelAndView mav=new ModelAndView();
		String viewName=(String)request.getAttribute("viewName");
		mav.setViewName(viewName);
			
		
		return mav;
	}	

//이용약관 	
@RequestMapping(value= "/main/customer.do" ,method={RequestMethod.POST,RequestMethod.GET})
public ModelAndView maincustomer(HttpServletRequest request, HttpServletResponse response) throws Exception{
	HttpSession session;
	ModelAndView mav=new ModelAndView();
	String viewName=(String)request.getAttribute("viewName");
	mav.setViewName(viewName);
		
	session=request.getSession();
	session.setAttribute("side_menu", "user");
	Map<String,List<GoodsVO>> goodsMap=goodsService.StatusList();
	System.out.println(goodsMap);
	mav.addObject("goodsMap", goodsMap);
	return mav;
 }
	
}
