package com.bts.wish.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bts.common.base.BaseController;
import com.bts.goods.service.GoodsService;
import com.bts.member.vo.MemberVO;
import com.bts.wish.service.WishService;

@Controller("wishController")
@RequestMapping(value="/wish")
public class WishControllerImpl extends BaseController  {
	@Autowired
	private WishService wishService;

	@Autowired
	private MemberVO memberVO;

	public WishService getWishService() {
		return wishService;
	}

	public void setWishService(WishService wishService) {
		this.wishService = wishService;
	}
}
