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
		return mav;
	}

	@Override
	@RequestMapping(value="/addGoodsInCart.do" ,method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public  @ResponseBody String addGoodsInCart(@RequestParam("goods_id") int goods_id, 
								@RequestParam("goods_ticket_date") Date goods_ticket_date,
								@RequestParam("cart_goods_qty") int cart_goods_qty,
			                    HttpServletRequest request, HttpServletResponse response)  throws Exception{
		System.out.println("카트컨트롤러 접근");
		System.out.println(goods_ticket_date);
		HttpSession session=request.getSession();
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		//세션영역의 정보 이용 id 가져온다  
		String member_id=memberVO.getMember_id();
	
		cartVO.setMember_id(member_id); //장바구니에 회원id, 상품id 저장 
		cartVO.setGoods_id(goods_id);
		cartVO.setGoods_ticket_date(goods_ticket_date); //수량, 예약일 추가 
		cartVO.setCart_goods_qty(cart_goods_qty);
		cartVO.setMember_id(member_id);
		System.out.println(member_id+goods_id+"날짜"+goods_ticket_date+"수량"+cart_goods_qty);
		boolean isAreadyExisted=cartService.findCartGoods(cartVO); //장바구니에 이미 상품이 존재하는지 확인 
		System.out.println("isAreadyExisted:"+isAreadyExisted);
		if(isAreadyExisted==true){
			return "already_existed";      
		}else{ //장바구니에 없으면 추가시킨다 
			cartService.addGoodsInCart(cartVO);
			return "add_success";
		}
	}
	
	//장바구니 창에서 수량 개별 수정할때 ajax로 넘어오는 
	@RequestMapping(value="/modifyCartQty.do" ,method = RequestMethod.POST)
	public @ResponseBody String  modifyCartQty(@RequestParam("goods_id") int goods_id,
			                                   @RequestParam("cart_goods_qty") int cart_goods_qty,
			                                    HttpServletRequest request, HttpServletResponse response)  throws Exception{
		System.out.println("cart 수정");
		HttpSession session=request.getSession();
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		String member_id=memberVO.getMember_id();
		// session 자리에 있는 아이디 정보 가져옴 
		cartVO.setGoods_id(goods_id); 
		cartVO.setMember_id(member_id);
		cartVO.setCart_goods_qty(cart_goods_qty);
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
