package com.bts.wish.vo;

public class WishVO {
	private String member_id;
	private String goods_id;
	public WishVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public WishVO(String member_id, String goods_id) {
		super();
		this.member_id = member_id;
		this.goods_id = goods_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getGoods_id() {
		return goods_id;
	}
	public void setGoods_id(String goods_id) {
		this.goods_id = goods_id;
	}
	
	
}
