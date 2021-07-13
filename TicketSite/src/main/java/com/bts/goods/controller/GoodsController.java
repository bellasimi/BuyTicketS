package com.bts.goods.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import net.sf.json.JSONObject;

public interface GoodsController  {
	public ModelAndView sort(@RequestParam("goods_sort")String goods_sort, HttpServletRequest request, HttpServletResponse response) throws Exception;
	//ticket_goods를 sort별 자연동물,박물관..List로 만들기, mav.addObject("SortList", SortList) veiws: goods/SortList.jsp
	public ModelAndView place(@RequestParam("goods_place")String goods_place,HttpServletRequest rq, HttpServletResponse rs) throws Exception;	
	//ticket_goods를 place별 자연동물,박물관..List로 만들기,	mv.addObject("PlaceList",PlaceList); veiws: goods/PlaceList.jsp
	public ModelAndView goodsDetail(@RequestParam("goods_id") String goods_id,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public @ResponseBody String keywordSearch(@RequestParam("keyword") String keyword,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView searchGoods(@RequestParam("searchWord") String searchWord,HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception;
	//ticket_goods중 goods_title과 유사한 데이터 List로 만들기, mav.addObject("goodsList", goodsList);  veiws:goods/searchGoods.jsp
}
