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
		 System.out.println("대체 언제 여기로 넘어오나 궁금 OrderController");
				 orderVO=(OrderVO)session.getAttribute("orderInfo"); //session에서 orderInfo를 가져온다 
				////////////////////////////////////orderinfo 세션에 넣어주는 곳은 어딜까 
				session.removeAttribute("action"); //action은 제거 
			 }else { //로그인되어있고 갈곳이 따로 없으면 orderVO 에 넣어줌 
				 orderVO=_orderVO;
				 System.out.println("else else"); //여기로 넘어옴 
			 }
		 }  //다 되면 결국 orderVO 에 저장된 형태로 남아서 
		
		System.out.println("");
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName); //view에 쏘아줌 
		System.out.println(viewName); ///order/orderEachGoods
		
		List myOrderList=new ArrayList<OrderVO>();
		myOrderList.add(orderVO); 
		
		System.out.println("myOrderList"+myOrderList.get(0));

		MemberVO memberInfo=(MemberVO)session.getAttribute("memberInfo");
		
		session.setAttribute("myOrderList", myOrderList); //orderVO 넘어온건 myorderList로 세션에 넘겨주고 
		session.setAttribute("orderer", memberInfo);  //회원정보 세션에 넘겨줌 
		return mav;
	}
	
	
	//카트에서 주문창으로 넘어오는 부분 - sql 처리 안거친다 세션에 값보내주는 역할만ㅇㅇ
	@RequestMapping(value="/orderAllCartGoods.do" ,method = RequestMethod.POST)
	public ModelAndView orderAllCartGoods( @RequestParam("cart_goods_qty")  String[] cart_goods_qty,
									HttpServletRequest request, HttpServletResponse response)  throws Exception{
		//수량은 배열로 받는다, 아마도 point?는 모르겠고(goodsVO에 있을거라) ticket_date를 받아와야할듯 
		//Date 배열이 통하려나....ㅠㅠ
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		Map cartMap=(Map)session.getAttribute("cartMap"); //세션에 카트가 있다 그거 가져옴 카트맵에는 goods리스트랑 cartlist있음
		//왜 카트리스트는 가져오면 안될까? cart_qty 때매? 그거만 바꿔주면 되려나 ticket_date받아오려면? 아니면 이거도 배열로 받아야 하나 
		List myOrderList=new ArrayList<OrderVO>();
		
		//cartMap안의 goodsList꺼냄 / 멤버정보는 세션에서 값가져옴 
		List<GoodsVO> myGoodsList=(List<GoodsVO>)cartMap.get("myGoodsList"); 
		MemberVO memberVO=(MemberVO)session.getAttribute("memberInfo");
		//SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");//String ->date로 변환하기위함인데 안쓸듯 
		//상품개수를 알아낼 수 있는게 cart_goods_qty.length 
		for(int i=0; i<cart_goods_qty.length;i++){ //주문 상품개수만큼 반복 
			String[] cart_goods=cart_goods_qty[i].split(":");  //cart_id: qty 형태로 넘어온거라서 앞의 카트id를 분리함
			
			System.out.println("cart_goods"+"i"+cart_goods[i]);
			
			System.out.println("cart_goods_qty.length"+cart_goods_qty.length);
			
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

		
					//여기서 예약일도 넣어주는게 좋을듯 
					myOrderList.add(_orderVO);   //위에서 만든 orderList에 넣어준다 , 
					break;  //같은거 찾으면 바로 계산하고 for문 하나 나가서 다음 상품 처리, myOrderList에 하나씩 쌓이게됨 
				}//if
			}//j
		}//i
		System.out.println("전부결제");
		session.setAttribute("myOrderList", myOrderList); //session으로 넘겨줌 
		session.setAttribute("orderer", memberVO); //주문자 정보는 세션에 있는 회원정보 
		return mav;
		
	}	
	
	
	/* 이건 ticket_date를 Date로 설정했을때 지우기 전에 해설은 옮겨놔야할듯 ㅋㅋㅋㅋㅋ
	@RequestMapping(value="/orderAllCartGoods.do" ,method = RequestMethod.POST)
	public ModelAndView orderAllCartGoods( @RequestParam("cart_goods_qty")  String[] cart_goods_qty,
									HttpServletRequest request, HttpServletResponse response)  throws Exception{
		//수량은 배열로 받는다, 아마도 point?는 모르겠고(goodsVO에 있을거라) ticket_date를 받아와야할듯 
		//Date 배열이 통하려나....ㅠㅠ
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		Map cartMap=(Map)session.getAttribute("cartMap"); //세션에 카트가 있다 그거 가져옴 카트맵에는 goods리스트랑 cartlist있음
		//왜 카트리스트는 가져오면 안될까? cart_qty 때매? 그거만 바꿔주면 되려나 ticket_date받아오려면? 아니면 이거도 배열로 받아야 하나 
		List myOrderList=new ArrayList<OrderVO>();
		
		//cartMap안의 goodsList꺼냄 / 멤버정보는 세션에서 값가져옴 
		List<GoodsVO> myGoodsList=(List<GoodsVO>)cartMap.get("myGoodsList"); 
		MemberVO memberVO=(MemberVO)session.getAttribute("memberInfo");
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");//String ->date로 변환하기위함 
		//상품개수를 알아낼 수 있는게 cart_goods_qty.length 
		for(int i=0; i<cart_goods_qty.length;i++){ //주문 상품개수만큼 반복 
			String[] cart_goods=cart_goods_qty[i].split(":");  //cart_id: qty 형태로 넘어온거라서 앞의 카트id를 분리함
			
			System.out.println("cart_goods"+"i"+cart_goods[i]);
			//Date ticket_date = (Date) transFormat.parse(goods_ticket_date[i]);
			
			for(int j = 0; j< myGoodsList.size();j++) { //카트에 있던 상품목록 크기만큼 반복 
				GoodsVO goodsVO = myGoodsList.get(j); 
				int goods_id = goodsVO.getGoods_id();//굿즈목록에서 상품ID만 빼옴 
				if(goods_id==Integer.parseInt(cart_goods[0])) {  //cart_good로 넘어온 id값이랑 goodsid랑 같을 때만 
					OrderVO _orderVO=new OrderVO();  
					String goods_title=goodsVO.getGoods_title();
					int goods_sales_price=goodsVO.getGoods_sales_price(); //날짜는 똑같이 배열로 넘겨야 할듯ㅠ 
					String goods_fileName=goodsVO.getGoods_fileName();
					int    goods_point =goodsVO.getGoods_point();
					//int goods_delivery_price =goodsVO.getGoods_delivery_price();
					_orderVO.setGoods_id(goods_id);
					_orderVO.setGoods_title(goods_title);
					_orderVO.setGoods_sales_price(goods_sales_price);
					_orderVO.setGoods_fileName(goods_fileName);
					_orderVO.setOrder_goods_qty(Integer.parseInt(cart_goods[1]));// 넘어온거에서 cart_qty값을 넣어준다 
					_orderVO.setGoods_point(goods_point);
					_orderVO.setGoods_ticket_date((Date)transFormat.parse(cart_goods[2]));
					//string 형태로 받아온거 날짜로 변환해서 넘겨준다 
					
					//_orderVO.setGoods_ticket_date(ticket_date);
					//여기서 예약일도 넣어주는게 좋을듯 
					myOrderList.add(_orderVO);   //위에서 만든 orderList에 넣어준다 , 
					break;  //같은거 찾으면 바로 계산하고 for문 하나 나가서 다음 상품 처리, myOrderList에 하나씩 쌓이게됨 
				}//if
			}//j
		}//i
		System.out.println("전부결제");
		session.setAttribute("myOrderList", myOrderList); //session으로 넘겨줌 
		session.setAttribute("orderer", memberVO); //주문자 정보는 세션에 있는 회원정보 
		return mav;
		
	}	*/
	
	//결제하기를 눌러야 디비에 저장이 된다  //receiverMap이 아니라 orderMap으로 바꿔줘봐야겠다 //receiverMap이 문서안에서만 통요됨
	//일단 receiverMap 이름바꾸지말고 코드 완성시켜놓고 payMap 으로 바꾸기 
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
				//goods_id, goods_title,order_goods_qty,goods_sales_price,
				//goods_fileName,goods_ticket_date,goods_point가 들어가있는 주문리스트가 하나씩 저장된다 
				orderVO.setMember_id(member_id);
				orderVO.setOrderer_name(orderer_name);
				orderVO.setOrderer_hp(orderer_hp);
				
				orderVO.setPay_method(receiverMap.get("pay_method"));
				orderVO.setRandom_account(receiverMap.get("random_account"));
				orderVO.setCard_com_name(receiverMap.get("card_com_name"));
				orderVO.setCard_number(receiverMap.get("card_number"));
				orderVO.setCard_expired_m(receiverMap.get("card_expired_m"));
				orderVO.setCard_expired_y(receiverMap.get("card_expired_y"));
				
				orderVO.setPay_hp_num(receiverMap.get("pay_hp_num"));
				orderVO.setPay_hp_com(receiverMap.get("pay_hp_com"));
				orderVO.setOrder_total_price(Integer.parseInt(receiverMap.get("order_total_price")));
				orderVO.setPoint_used(Integer.parseInt(receiverMap.get("point_used")));
				//모든정보 orderVO에 모아준다음에 
				
				System.out.println(receiverMap.get("card_expired_y"));
				System.out.println(receiverMap.get("pay_hp_com"));
				myOrderList.set(i, orderVO); //myOrderList에 저장해준다  
			}//end for
			
			System.out.println("최종결제버튼누르면");
			
		    orderService.addNewOrder(myOrderList);
			mav.addObject("myOrderInfo",receiverMap);//OrderVO주문관련 정보를은 주문인포로 따로또 보내줌 
			mav.addObject("myOrderList", myOrderList);
			return mav;
		}
		
	//결제하기를 눌러야 디비에 저장이 된다  //receiverMap이 아니라 orderMap으로 바꿔줘봐야겠다 아니면 payMap 
	/*
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
					
			
			
			 * orderVO.setReceiver_name(receiverMap.get("receiver_name"));
			 * 
			 * orderVO.setReceiver_hp1(receiverMap.get("receiver_hp1"));
			 * orderVO.setReceiver_hp2(receiverMap.get("receiver_hp2"));
			 * orderVO.setReceiver_hp3(receiverMap.get("receiver_hp3"));
			 * orderVO.setReceiver_tel1(receiverMap.get("receiver_tel1"));
			 * orderVO.setReceiver_tel2(receiverMap.get("receiver_tel2"));
			 * orderVO.setReceiver_tel3(receiverMap.get("receiver_tel3"));
			 * orderVO.setDelivery_address(receiverMap.get("delivery_address"));
			  orderVO.setDelivery_message(receiverMap.get("delivery_message"));
			  orderVO.setDelivery_method(receiverMap.get("delivery_method"));
			  orderVO.setGift_wrapping(receiverMap.get("gift_wrapping"));
			 
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

	*/
	

}
