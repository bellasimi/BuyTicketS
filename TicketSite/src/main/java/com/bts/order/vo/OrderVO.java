package com.bts.order.vo;

import java.io.Serializable;
import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("orderVO")
public class OrderVO implements Serializable{  
	private int order_seq_num;// 주문*상품에 부여되는 번호 
	private int order_id;// 하나의 주문세트에 부여되는 번호
	
	private String member_id;
	private int goods_id;
	
	private String orderer_name; //어차피 member정보에 있는 이름 그대로 쓸
	private String orderer_hp; //마찬가지로 member정보에 있는 번호그대로 
	private String goods_title; //상품명
	private int order_goods_qty; // 주문수량
	
	private int goods_sales_price;// 이거 가격 변수중에 뭐뭐 차이인지 알아야 함 
		
	private String goods_fileName; 
	private String pay_method;	//결제방법
	private String random_account;  //무통장입금 계좌번호
	
	private String card_com_name; //카드회사명
	private String card_number;  //카드번호
	private String card_expired_m; //카드유효기간(월)
	private String card_expired_y; //카드유효기간(년)
	
	private String pay_orderer_hp_num; //폰결제 시 번호
	private String pay_order_time;  //주문날짜
	private String goods_ticket_date; //티켓예약일
	private int goods_point; //한상품당 적립되는 금액
	
	//이 밑에 있는 것들이 주문 한번당 생성되는 값들... 
	private int point_used; //차감된 포인트 
	private int order_total_price;// 총 주문금액  
	
	
//여기까지가 db에 입력되는 값 
		
	//xml 에 goods_qty 있는데 왜있을까 ㅋㅋㅋㅋㅋㅋㅋ
	private int cart_goods_qty; //이거 쓰일지 모르겠다 안쓸것같음 

	public int getOrder_seq_num() {
		return order_seq_num;
	}

	public void setOrder_seq_num(int order_seq_num) {
		this.order_seq_num = order_seq_num;
	}

	public int getOrder_id() {
		return order_id;
	}

	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public int getGoods_id() {
		return goods_id;
	}

	public void setGoods_id(int goods_id) {
		this.goods_id = goods_id;
	}

	public String getOrderer_name() {
		return orderer_name;
	}

	public void setOrderer_name(String orderer_name) {
		this.orderer_name = orderer_name;
	}

	public String getOrderer_hp() {
		return orderer_hp;
	}

	public void setOrderer_hp(String orderer_hp) {
		this.orderer_hp = orderer_hp;
	}

	public String getGoods_title() {
		return goods_title;
	}

	public void setGoods_title(String goods_title) {
		this.goods_title = goods_title;
	}

	public int getOrder_goods_qty() {
		return order_goods_qty;
	}

	public void setOrder_goods_qty(int order_goods_qty) {
		this.order_goods_qty = order_goods_qty;
	}

	public int getGoods_sales_price() {
		return goods_sales_price;
	}

	public void setGoods_sales_price(int goods_sales_price) {
		this.goods_sales_price = goods_sales_price;
	}

	public int getOrder_total_price() {
		return order_total_price;
	}

	public void setOrder_total_price(int order_total_price) {
		this.order_total_price = order_total_price;
	}


	public String getGoods_fileName() {
		return goods_fileName;
	}

	public void setGoods_fileName(String goods_fileName) {
		this.goods_fileName = goods_fileName;
	}

	public String getPay_method() {
		return pay_method;
	}

	public void setPay_method(String pay_method) {
		this.pay_method = pay_method;
	}

	public String getRandom_account() {
		return random_account;
	}

	public void setRandom_account(String random_account) {
		this.random_account = random_account;
	}

	public String getCard_com_name() {
		return card_com_name;
	}

	public void setCard_com_name(String card_com_name) {
		this.card_com_name = card_com_name;
	}

	public String getCard_number() {
		return card_number;
	}

	public void setCard_number(String card_number) {
		this.card_number = card_number;
	}

	public String getCard_expired_m() {
		return card_expired_m;
	}

	public void setCard_expired_m(String card_expired_m) {
		this.card_expired_m = card_expired_m;
	}

	public String getCard_expired_y() {
		return card_expired_y;
	}

	public void setCard_expired_y(String card_expired_y) {
		this.card_expired_y = card_expired_y;
	}

	public String getPay_orderer_hp_num() {
		return pay_orderer_hp_num;
	}

	public void setPay_orderer_hp_num(String pay_orderer_hp_num) {
		this.pay_orderer_hp_num = pay_orderer_hp_num;
	}

	public String getPay_order_time() {
		return pay_order_time;
	}

	public void setPay_order_time(String pay_order_time) {
		this.pay_order_time = pay_order_time;
	}

/*	public Date getGoods_ticket_date() {
		return goods_ticket_date;
	}

	public void setGoods_ticket_date(Date goods_ticket_date) {
		this.goods_ticket_date = goods_ticket_date;
	}*/
	
	

	public int getGoods_point() {
		return goods_point;
	}

	public String getGoods_ticket_date() {
		return goods_ticket_date;
	}

	public void setGoods_ticket_date(String goods_ticket_date) {
		this.goods_ticket_date = goods_ticket_date;
	}

	public int getPoint_used() {
		return point_used;
	}

	public void setPoint_used(int point_used) {
		this.point_used = point_used;
	}

	public void setGoods_point(int goods_point) {
		this.goods_point = goods_point;
	}



	public int getCart_goods_qty() {
		return cart_goods_qty;
	}

	public void setCart_goods_qty(int cart_goods_qty) {
		this.cart_goods_qty = cart_goods_qty;
	}
	
	
//	private String card_pay_month; //할부 개월수 
	
	

}

	

	
	