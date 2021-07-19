package com.bts.cart.controller;

import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

public interface CartController {
	public ModelAndView myCartMain(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	//장바구니에 상품 추가
	public @ResponseBody String addGoodsInCart(@RequestParam("goods_id") int goods_id,
					@RequestParam("goods_ticket_date") Date goods_ticket_date,
					@RequestParam("cart_goods_qty") int cart_goods_qty,
					HttpServletRequest request, HttpServletResponse response)  throws Exception;
	//카트 수량 조절
	public  @ResponseBody String modifyCartQty(@RequestParam("goods_id") int goods_id,@RequestParam("cart_goods_qty") int cart_goods_qty,
			                  HttpServletRequest request, HttpServletResponse response)  throws Exception;
	//카트에서 상품 삭제
	public ModelAndView removeCartGoods(@RequestParam("cart_id") int cart_id,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	
	

}
