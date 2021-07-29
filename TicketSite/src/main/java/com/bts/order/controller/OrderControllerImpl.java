package com.bts.order.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bts.common.base.BaseController;
import com.bts.goods.vo.GoodsVO;
import com.bts.member.vo.MemberVO;
import com.bts.order.service.OrderService;
import com.bts.order.vo.OrderVO;

@Controller("orderController")
@RequestMapping(value="/order")
public class OrderControllerImpl extends BaseController implements OrderController {
	@Autowired
	private OrderService orderService;
	@Autowired
	private OrderVO orderVO;
	
	//개별 주문하기 버튼누르면 or 굿즈디테일에서 주문하기 버튼 누르면 실행됨 
	@RequestMapping(value="/orderEachGoods.do" ,method = RequestMethod.POST) 
	public ModelAndView orderEachGoods(@ModelAttribute("orderVO") OrderVO _orderVO,
			                       HttpServletRequest request, HttpServletResponse response)  throws Exception{
		
		System.out.println("개별주문컨트롤러");
		System.out.println("id"+_orderVO.getGoods_id());
		System.out.println(_orderVO.getGoods_fileName());
		System.out.println(_orderVO.getGoods_title());
		System.out.println("날짜"+_orderVO.getGoods_ticket_date());
		System.out.println("가격"+_orderVO.getGoods_sales_price());
		System.out.println("수량"+_orderVO.getOrder_goods_qty());
		System.out.println("포인트"+_orderVO.getGoods_point());
		
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		session=request.getSession();
		
		Boolean isLogOn=(Boolean)session.getAttribute("isLogOn"); //로그인 상태인지 확인 
		String action=(String)session.getAttribute("action");
		if(isLogOn==null || isLogOn==false){ //로그인 상태가 아니면 
			session.setAttribute("orderInfo", _orderVO); 
			session.setAttribute("action", "/order/orderEachGoods.do");
			return new ModelAndView("redirect:/member/loginForm.do"); //로그인폼으로 넘어가게 해둔다 
		}else{
			 if(action!=null && action.equals("/order/orderEachGoods.do")){ //별도의 이어질곳이 없거나 orderEachGoods로 이어지게 되어있으면 
				 orderVO=(OrderVO)session.getAttribute("orderInfo"); //session에서 orderInfo를 가져온다 
				session.removeAttribute("action"); 
			 }else { 
				 orderVO=_orderVO;
			 }
		 }  
		
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName); //view에 쏘아줌 
				
		List myOrderList=new ArrayList<OrderVO>();
		myOrderList.add(orderVO); 
		
		MemberVO memberInfo=(MemberVO)session.getAttribute("memberInfo");
		
		session.setAttribute("myOrderList", myOrderList); //orderVO 넘어온건 myorderList로 세션에 넘겨주고 
		session.setAttribute("orderer", memberInfo);  //회원정보 세션에 넘겨줌 
		return mav;
	}
	
	
	@RequestMapping(value="/orderAllCartGoods.do" ,method = RequestMethod.POST)
	public ModelAndView orderAllCartGoods( @RequestParam("cart_goods_qty")  String[] cart_goods_qty,
									HttpServletRequest request, HttpServletResponse response)  throws Exception{
		
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		Map cartMap=(Map)session.getAttribute("cartMap");
		List myOrderList=new ArrayList<OrderVO>();
		
		//cartMap안의 goodsList꺼냄 / 멤버정보는 세션에서 값가져옴 
		List<GoodsVO> myGoodsList=(List<GoodsVO>)cartMap.get("myGoodsList"); 
		MemberVO memberVO=(MemberVO)session.getAttribute("memberInfo");

		//상품개수를 알아낼 수 있는게 cart_goods_qty.length 
		for(int i=0; i<cart_goods_qty.length;i++){ //주문 상품개수만큼 반복 
			String[] cart_goods=cart_goods_qty[i].split(":");  //cart_id: qty 형태로 넘어온거라서 앞의 카트id를 분리함
			
			for(int j = 0; j< myGoodsList.size();j++) { //카트에 있던 상품목록 크기만큼 반복 
				GoodsVO goodsVO = myGoodsList.get(j); 
				int goods_id = goodsVO.getGoods_id();//굿즈목록에서 상품ID만 빼옴 
				if(goods_id==Integer.parseInt(cart_goods[0])) {  //cart_good로 넘어온 id값이랑 goodsid랑 같을 때만 
					OrderVO _orderVO=new OrderVO();  
					String goods_title=goodsVO.getGoods_title();
					int goods_sales_price=goodsVO.getGoods_sales_price(); //날짜는 똑같이 배열로 넘겨야 할듯ㅠ 
					String goods_fileName=goodsVO.getGoods_fileName();
					int    goods_point =goodsVO.getGoods_point();
		
					_orderVO.setGoods_id(goods_id);
					_orderVO.setGoods_title(goods_title);
					_orderVO.setGoods_sales_price(goods_sales_price);
					_orderVO.setGoods_fileName(goods_fileName);
					_orderVO.setOrder_goods_qty(Integer.parseInt(cart_goods[1]));// 넘어온거에서 cart_qty값을 넣어준다 
					_orderVO.setGoods_point(goods_point);
					_orderVO.setGoods_ticket_date(cart_goods[2]);
					
					myOrderList.add(_orderVO);   //위에서 만든 orderList에 넣어준다 , 
					break;  //같은거 찾으면 바로 계산하고 for문 하나 나가서 다음 상품 처리, myOrderList에 하나씩 쌓이게됨 
				}//if
			}//j  
		}//i
		session.setAttribute("myOrderList", myOrderList); //session으로 넘겨줌 
		session.setAttribute("orderer", memberVO); //주문자 정보는 세션에 있는 회원정보 
		return mav;
	}
	
		
	@RequestMapping(value="/payToOrderGoods.do" ,method = RequestMethod.POST)
		public ModelAndView payToOrderGoods(@RequestParam Map<String, String> receiverMap,
				                       HttpServletRequest request, HttpServletResponse response)  throws Exception{
			String viewName=(String)request.getAttribute("viewName");
			ModelAndView mav = new ModelAndView(viewName);
			
			HttpSession session=request.getSession();
			MemberVO memberVO=(MemberVO)session.getAttribute("orderer");
			String member_id=memberVO.getMember_id();
			String orderer_name=memberVO.getMember_name();
			String orderer_hp = memberVO.getHp1()+"-"+memberVO.getHp2()+"-"+memberVO.getHp3();
			List<OrderVO> myOrderList=(List<OrderVO>)session.getAttribute("myOrderList");
			
			for(int i=0; i<myOrderList.size();i++){
				OrderVO orderVO=(OrderVO)myOrderList.get(i); 
				orderVO.setMember_id(member_id);
				orderVO.setOrderer_name(orderer_name);
				orderVO.setOrderer_hp(orderer_hp);
							
				orderVO.setPay_method(receiverMap.get("pay_method").trim());
				orderVO.setRandom_account(receiverMap.get("random_account"));
				orderVO.setCard_com_name(receiverMap.get("card_com_name"));
				orderVO.setCard_number(receiverMap.get("card_number"));
				orderVO.setCard_expired_m(receiverMap.get("card_expired_m"));
				orderVO.setCard_expired_y(receiverMap.get("card_expired_y"));
				
				orderVO.setPay_hp_num(receiverMap.get("pay_hp_num"));
				orderVO.setPay_hp_com(receiverMap.get("pay_hp_com"));
				orderVO.setOrder_total_price(Integer.parseInt(receiverMap.get("order_total_price")));
				orderVO.setPoint_used(Integer.parseInt(receiverMap.get("point_used")));
	
				//System.out.println(receiverMap.get("pay_method"));
				//System.out.println(receiverMap.get("random_account"));
				//System.out.println(receiverMap.get("card_com_name"));
				//System.out.println(receiverMap.get("card_number"));
				//System.out.println(receiverMap.get("card_expired_m"));
				//System.out.println(receiverMap.get("card_expired_y"));
				//System.out.println(receiverMap.get("pay_hp_num"));
				//System.out.println(receiverMap.get("pay_hp_com"));
				//System.out.println(receiverMap.get("order_total_price"));
				//System.out.println("point_used"+receiverMap.get("point_used"));
				//System.out.println("포인트"+orderVO.getGoods_point());
				
				myOrderList.set(i, orderVO); //myOrderList에 저장해준다  
			}//end for
			
			System.out.println("최종결제버튼누르면");
			
		    orderService.addNewOrder(myOrderList);
			mav.addObject("myOrderInfo",receiverMap);//OrderVO주문관련 정보를은 주문인포로 따로또 보내줌 
			mav.addObject("myOrderList", myOrderList);
			return mav;
		}
		

}
