package com.bts.cart.controller;


import java.sql.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import com.bts.cart.service.CartService;
import com.bts.cart.vo.CartVO;
import com.bts.common.base.BaseController;

import com.bts.member.vo.MemberVO;

@Controller("cartController")
@RequestMapping(value="/cart")
public class CartControllerImpl extends BaseController implements CartController{
	@Autowired
	private CartService cartService;
	@Autowired
	private CartVO cartVO;
	@Autowired
	private MemberVO memberVO;
	
	//다른 애들은 mapping이랑 컨트롤러 함수명이랑 일치함 일치시켜서 돌아가나 확인할것 
	
	@RequestMapping(value="/myCartList.do" ,method = RequestMethod.GET)
	public ModelAndView myCartMain(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		System.out.println("카트컨트롤러");
		
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		MemberVO memberVO=(MemberVO)session.getAttribute("memberInfo");
		//로그인 상태니까 session에 값이 있는 상태. 그걸 가져온다 
		String member_id=memberVO.getMember_id();
		//로그인된 아이디로 장바구니 정보가져오기 위해 아이디 설정해준다 
		cartVO.setMember_id(member_id);
		Map<String ,List> cartMap=cartService.myCartList(cartVO);
		//여기서 cartlist랑 goodslist랑 같이 넘어옴 
		session.setAttribute("cartMap", cartMap); 
		////////////////세션 자리에 cartMap 설정해줌   -> 왜 객체로 안넘기는지 밑의 방식과 차이가 뭔지 
		//mav.addObject("cartMap", cartMap);
		return mav;
	}
	
	//goodsdetail에서 장바구니 버튼 누르면 이어지는거 하나의상품을 장바구니에 추가
	//ajax 로 goods_id랑 goods_ticket_date 넘어옴 
	//sql 의 DATE 를 가져왔는데 이게 나중에 혹시 오류나나 확인할것 
	@Override
	@RequestMapping(value="/addGoodsInCart.do" ,method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public  @ResponseBody String addGoodsInCart(@RequestParam("goods_id") int goods_id, 
								@RequestParam("ticket_goods") Date ticket_goods,
								@RequestParam("ticket_cart") int ticket_cart,
			                    HttpServletRequest request, HttpServletResponse response)  throws Exception{
		//수량 배열로 받지않아도 되겠지 하나씩 저장되니까??????
		System.out.println("카트컨트롤러 접근");
		HttpSession session=request.getSession();
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		//세션영역의 정보 이용 id 가져온다  
		String member_id=memberVO.getMember_id();
	
		cartVO.setMember_id(member_id); //장바구니에 회원id, 상품id 저장 
		cartVO.setGoods_id(goods_id);
		cartVO.setGoods_ticket_date(ticket_goods); //수량, 예약일 추가 
		cartVO.setCart_goods_qty(ticket_cart);
		cartVO.setMember_id(member_id);
		System.out.println(member_id+goods_id+"날짜"+ticket_goods+"수량"+ticket_cart);
		boolean isAreadyExisted=cartService.findCartGoods(cartVO); //장바구니에 이미 상품이 존재하는지 확인 
		System.out.println("isAreadyExisted:"+isAreadyExisted);
		if(isAreadyExisted==true){
			return "already_existed";       ///String 넘긴다 goodsdetail.jsp에서 경고메시지 띄워줌 
			//ata.trim()=='already_existed' 이런식으로 처리됨 자바스크립트에서 
		}else{ //장바구니에 없으면 추가시킨다 
			cartService.addGoodsInCart(cartVO);
			return "add_success";
		}
	}
	
	//장바구니 창에서 수량 개별 수정할때 ajax로 넘어오는 
	@RequestMapping(value="/modifyCartQty.do" ,method = RequestMethod.POST)
	public @ResponseBody String  modifyCartQty(@RequestParam("goods_id") int goods_id,
			                                   @RequestParam("ticket_cart") int ticket_cart,
			                                    HttpServletRequest request, HttpServletResponse response)  throws Exception{
		System.out.println("cart 수정");
		HttpSession session=request.getSession();
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		String member_id=memberVO.getMember_id();
		// session 자리에 있는 아이디 정보 가져옴 
		cartVO.setGoods_id(goods_id); 
		cartVO.setMember_id(member_id);
		cartVO.setCart_goods_qty(ticket_cart);
		boolean result=cartService.modifyCartQty(cartVO);
		
		if(result==true){
		   return "modify_success";
		}else{
			  return "modify_failed";	
		}
		
	}
	
	
	
	//장바구니 창에서 상품 하나 삭제 
	@RequestMapping(value="/removeCartGoods.do" ,method = RequestMethod.POST)
	public ModelAndView removeCartGoods(@RequestParam("cart_id") int cart_id,
			                          HttpServletRequest request, HttpServletResponse response)  throws Exception{
		ModelAndView mav=new ModelAndView();
		cartService.removeCartGoods(cart_id);
		mav.setViewName("redirect:/cart/myCartList.do"); //다시 연결되게 하려면 이거 사용하면되나봄 
		return mav;
	}

	

}
