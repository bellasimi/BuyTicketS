package com.bts.order.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("orderVO")
public class OrderVO {
	private int order_seq_num;//
	private int order_id;//
	
	private String member_id;
	private int goods_id;
	
	private String orderer_name;
	private String orderer_hp;
	private String goods_title;
	private int order_goods_qty; //
	
	private int goods_sales_price;// 이거 가격 변수중에 뭐뭐 차이인지 알아야 함 
	private int total_goods_price;//
	private String final_total_price;
	
	
	private String goods_fileName;
	private String pay_method;	
	private String random_account;
	
	private String card_com_name;
	private String card_number;
	private String card_expired_m;
	private String card_expired_y;
	
	private String pay_orderer_hp_num;
	private String pay_order_time; 
	private Date goods_ticket_date;
	private int goods_point;
//여기까지가 db에 입력되는 값 
		
	//xml 에 goods_qty 있는데 왜있을까 ㅋㅋㅋㅋㅋㅋㅋ
	private int cart_goods_qty; //이거 쓰일지 모르겠다
	
	
//	private String card_pay_month; //할부 개월수 
	
	
	
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
	public Date getGoods_ticket_date() {
		return goods_ticket_date;
	}
	public void setGoods_ticket_date(Date goods_ticket_date) {
		this.goods_ticket_date = goods_ticket_date;
	}
	public int getGoods_point() {
		return goods_point;
	}
	public void setGoods_point(int goods_point) {
		this.goods_point = goods_point;
	}
	public int getTotal_goods_price() {
		return total_goods_price;
	}
	public void setTotal_goods_price(int total_goods_price) {
		this.total_goods_price = total_goods_price;
	}
	public int getCart_goods_qty() {
		return cart_goods_qty;
	}
	public void setCart_goods_qty(int cart_goods_qty) {
		this.cart_goods_qty = cart_goods_qty;
	}
	public String getFinal_total_price() {
		return final_total_price;
	}
	public void setFinal_total_price(String final_total_price) {
		this.final_total_price = final_total_price;
	}//
}

	

	
	