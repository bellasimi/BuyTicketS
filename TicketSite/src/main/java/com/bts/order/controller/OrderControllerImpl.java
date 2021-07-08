package com.bts.order.controller;

import java.sql.Date;
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
		 System.out.println("대체 언제 여기로 넘어오나 궁금 OrderController");
				 orderVO=(OrderVO)session.getAttribute("orderInfo"); //session에서 orderInfo를 가져온다 
				////////////////////////////////////orderinfo 세션에 넣어주는 곳은 어딜까 
				session.removeAttribute("action"); //action은 제거 
			 }else { //로그인되어있고 갈곳이 따로 없으면 orderVO 에 넣어줌 
				 orderVO=_orderVO;
				 System.out.println("else else");
			 }
		 }  //다 되면 결국 orderVO 에 저장된 형태로 남아서 
		
		System.out.println("");
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName); //view에 쏘아줌 
		System.out.println(viewName);
		
		List myOrderList=new ArrayList<OrderVO>();
		myOrderList.add(orderVO); 
		
		System.out.println("myOrderList"+myOrderList.get(0));

		MemberVO memberInfo=(MemberVO)session.getAttribute("memberInfo");
		
		session.setAttribute("myOrderList", myOrderList); //orderVO 넘어온건 myorderList로 넘겨주고 
		session.setAttribute("orderer", memberInfo);  //회원정보 주문자로 뷰페이지에 넘겨줌 
		return mav;
	}
	/*
	@RequestMapping(value="/orderAllCartGoods.do" ,method = RequestMethod.POST)
	public ModelAndView orderAllCartGoods( @RequestParam("cart_goods_qty")  String[] cart_goods_qty,
									@RequestParam("goods_ticket_date") String[] goods_ticket_date,
			                 HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		Map cartMap=(Map)session.getAttribute("cartMap");
		List myOrderList=new ArrayList<OrderVO>();
		
		List<GoodsVO> myGoodsList=(List<GoodsVO>)cartMap.get("myGoodsList");
		MemberVO memberVO=(MemberVO)session.getAttribute("memberInfo");
		
		for(int i=0; i<cart_goods_qty.length;i++){
			String[] cart_goods=cart_goods_qty[i].split(":");
			String[] goods_date = goods_ticket_date[i].split(":");
			for(int j = 0; j< myGoodsList.size();j++) {
				GoodsVO goodsVO = myGoodsList.get(j);
				int goods_id = goodsVO.getGoods_id();
				if(goods_id==Integer.parseInt(cart_goods[0])) {//īƮ�� ID�� ���� ���
					OrderVO _orderVO=new OrderVO();
					String goods_title=goodsVO.getGoods_title();
					int goods_sales_price=goodsVO.getGoods_sales_price();
					String goods_fileName=goodsVO.getGoods_fileName();
					int    goods_point =goodsVO.getGoods_point();
					//int goods_delivery_price =goodsVO.getGoods_delivery_price();
					_orderVO.setGoods_id(goods_id);
					_orderVO.setGoods_title(goods_title);
					_orderVO.setGoods_sales_price(goods_sales_price);
					_orderVO.setGoods_fileName(goods_fileName);
					_orderVO.setOrder_goods_qty(Integer.parseInt(cart_goods[1]));//
					_orderVO.setGoods_point(goods_point);
					_orderVO.setGoods_ticket_date(Date.valueOf(goods_date[1])); //무슨말인지 이해는 잘..
					//여기서 예약일도 넣어주는게 좋을듯 
					myOrderList.add(_orderVO);
					break;
				}//if
			}//j
		}//i
		System.out.println("전부결제");
		session.setAttribute("myOrderList", myOrderList);
		session.setAttribute("orderer", memberVO);
		return mav;
		
	}	*/
	
	@RequestMapping(value="/orderAllCartGoods.do" ,method = RequestMethod.POST)
	public ModelAndView orderAllCartGoods( @RequestParam("cart_goods_qty")  String[] cart_goods_qty,
									HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		Map cartMap=(Map)session.getAttribute("cartMap");
		List myOrderList=new ArrayList<OrderVO>();
		
		List<GoodsVO> myGoodsList=(List<GoodsVO>)cartMap.get("myGoodsList");
		MemberVO memberVO=(MemberVO)session.getAttribute("memberInfo");
		
		for(int i=0; i<cart_goods_qty.length;i++){
			String[] cart_goods=cart_goods_qty[i].split(":");

			for(int j = 0; j< myGoodsList.size();j++) {
				GoodsVO goodsVO = myGoodsList.get(j);
				int goods_id = goodsVO.getGoods_id();
				if(goods_id==Integer.parseInt(cart_goods[0])) {//īƮ�� ID�� ���� ���
					OrderVO _orderVO=new OrderVO();
					String goods_title=goodsVO.getGoods_title();
					int goods_sales_price=goodsVO.getGoods_sales_price();
					String goods_fileName=goodsVO.getGoods_fileName();
					int    goods_point =goodsVO.getGoods_point();
					//int goods_delivery_price =goodsVO.getGoods_delivery_price();
					_orderVO.setGoods_id(goods_id);
					_orderVO.setGoods_title(goods_title);
					_orderVO.setGoods_sales_price(goods_sales_price);
					_orderVO.setGoods_fileName(goods_fileName);
					_orderVO.setOrder_goods_qty(Integer.parseInt(cart_goods[1]));//
					_orderVO.setGoods_point(goods_point);
					//여기서 예약일도 넣어주는게 좋을듯 
					myOrderList.add(_orderVO);
					break;
				}//if
			}//j
		}//i
		System.out.println("전부결제");
		session.setAttribute("myOrderList", myOrderList);
		session.setAttribute("orderer", memberVO);
		return mav;
		
	}	
	
	
	//결제하기를 눌러야 디비에 저장이 된다 
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
					
			
			/*
			 * orderVO.setReceiver_name(receiverMap.get("receiver_name"));
			 * 
			 * orderVO.setReceiver_hp1(receiverMap.get("receiver_hp1"));
			 * orderVO.setReceiver_hp2(receiverMap.get("receiver_hp2"));
			 * orderVO.setReceiver_hp3(receiverMap.get("receiver_hp3"));
			 * orderVO.setReceiver_tel1(receiverMap.get("receiver_tel1"));
			 * orderVO.setReceiver_tel2(receiverMap.get("receiver_tel2"));
			 * orderVO.setReceiver_tel3(receiverMap.get("receiver_tel3"));
			 * orderVO.setDelivery_address(receiverMap.get("delivery_address"));
			 * orderVO.setDelivery_message(receiverMap.get("delivery_message"));
			 * orderVO.setDelivery_method(receiverMap.get("delivery_method"));
			 * orderVO.setGift_wrapping(receiverMap.get("gift_wrapping"));
			 */
			orderVO.setPay_method(receiverMap.get("pay_method"));
			orderVO.setCard_com_name(receiverMap.get("card_com_name"));
//			orderVO.setCard_pay_month(receiverMap.get("card_pay_month"));
			orderVO.setPay_orderer_hp_num(receiverMap.get("pay_orderer_hp_num"));	
			orderVO.setOrderer_hp(orderer_hp);	
			myOrderList.set(i, orderVO); //�� orderVO�� �ֹ��� ������ ������ �� �ٽ� myOrderList�� �����Ѵ�.
		}//end for
		
		System.out.println("최종결제버튼누르면");
		
	    orderService.addNewOrder(myOrderList);
		mav.addObject("myOrderInfo",receiverMap);//OrderVO�� �ֹ���� ��������  �ֹ��� ������ ǥ���Ѵ�.
		mav.addObject("myOrderList", myOrderList);
		return mav;
	}


	

}
