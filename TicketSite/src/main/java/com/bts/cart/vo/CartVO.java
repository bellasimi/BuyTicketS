package com.bts.cart.vo;

import java.io.Serializable;
import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("cartVO")
public class CartVO implements Serializable{
	private int cart_id;//
	private int goods_id;//
	private String member_id;//
	private int cart_goods_qty;//
	private Date goods_ticket_date; //db에도 필드 있음
	private String creDate;//
	
	
	public int getCart_id() {
		return cart_id;
	}
	public void setCart_id(int cart_id) {
		this.cart_id = cart_id;
	}
	
	
	public int getGoods_id() {
		return goods_id;
	}
	public void setGoods_id(int goods_id) {
		this.goods_id = goods_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	
	
	public int getCart_goods_qty() {
		return cart_goods_qty;
	}
	public void setCart_goods_qty(int cart_goods_qty) {
		this.cart_goods_qty = cart_goods_qty;
	}
	public String getCreDate() {
		return creDate;
	}
	public void setCreDate(String creDate) {
		this.creDate = creDate;
	}
	public Date getGoods_ticket_date() {
		return goods_ticket_date;
	}
	public void setGoods_ticket_date(Date goods_ticket_date) {
		this.goods_ticket_date = goods_ticket_date;
	}
	
	
	
	/*
	public String getGoods_ticket_date() {
		return goods_ticket_date;
	}
	public void setGoods_ticket_date(String goods_ticket_date) {
		this.goods_ticket_date = goods_ticket_date;
	}
	*/
	
	

}
