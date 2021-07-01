package com.bookshop01.goods.vo;

import java.sql.Date;
import java.util.ArrayList;

public class GoodsVO {
	
	private int goods_id; 			//ticket_seq 일련번호 
	private String goods_sort;		//분류 박물관.. 
	private String goods_title; 	//제목
	private String goods_publisher;	//주최측
	private int  goods_price;		//정가
	private int  goods_sales_price;	//할인가
	private int  goods_discount;	//할인율 0.1,.. 
	private int  goods_point;//포인트
	private Date goods_expired_date;//티켓 만기일자
	private int goods_delivery_price; 			//배송비 ; 현재 보류 null
	private Date goods_delivery_date; //배송일 ; 현재 보류 null
	private String goods_status;	//베스트셀러,..
	private String goods_place;		//서울,경기,제주...
	private String goods_description;//상세설명
	private String goods_terms;		//이용약관
	private String goods_usage;		//티켓 사용방법
	private String goods_location;  //위치
	private Date   goods_lastsale_date;//판매종료일 
	private String goods_fileName; //아마 이미지 파일 제목을 여기 넣는거 같은데.. ?
	public GoodsVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getGoods_id() {
		return goods_id;
	}
	public void setGoods_id(int goods_id) {
		this.goods_id = goods_id;
	}
	public String getGoods_sort() {
		return goods_sort;
	}
	public void setGoods_sort(String goods_sort) {
		this.goods_sort = goods_sort;
	}
	public String getGoods_title() {
		return goods_title;
	}
	public void setGoods_title(String goods_title) {
		this.goods_title = goods_title;
	}
	public String getGoods_publisher() {
		return goods_publisher;
	}
	public void setGoods_publisher(String goods_publisher) {
		this.goods_publisher = goods_publisher;
	}
	public int getGoods_price() {
		return goods_price;
	}
	public void setGoods_price(int goods_price) {
		this.goods_price = goods_price;
	}
	public int getGoods_sales_price() {
		return goods_sales_price;
	}
	public void setGoods_sales_price(int goods_sales_price) {
		this.goods_sales_price = goods_sales_price;
	}
	public int getGoods_discount() {
		return goods_discount;
	}
	public void setGoods_discount(int goods_discount) {
		this.goods_discount = goods_discount;
	}
	public int getGoods_point() {
		return goods_point;
	}
	public void setGoods_point(int goods_point) {
		this.goods_point = goods_point;
	}
	public Date getGoods_expired_date() {
		return goods_expired_date;
	}
	public void setGoods_expired_date(Date goods_expired_date) {
		this.goods_expired_date = goods_expired_date;
	}
	public int getGoods_delivery_price() {
		return goods_delivery_price;
	}
	public void setGoods_delivery_price(int goods_delivery_price) {
		this.goods_delivery_price = goods_delivery_price;
	}
	public Date getGoods_delivery_date() {
		return goods_delivery_date;
	}
	public void setGoods_delivery_date(Date goods_delivery_date) {
		this.goods_delivery_date = goods_delivery_date;
	}
	public String getGoods_status() {
		return goods_status;
	}
	public void setGoods_status(String goods_status) {
		this.goods_status = goods_status;
	}
	public String getGoods_place() {
		return goods_place;
	}
	public void setGoods_place(String goods_place) {
		this.goods_place = goods_place;
	}
	public String getGoods_description() {
		return goods_description;
	}
	public void setGoods_description(String goods_description) {
		this.goods_description = goods_description;
	}
	public String getGoods_terms() {
		return goods_terms;
	}
	public void setGoods_terms(String goods_terms) {
		this.goods_terms = goods_terms;
	}
	public String getGoods_usage() {
		return goods_usage;
	}
	public void setGoods_usage(String goods_usage) {
		this.goods_usage = goods_usage;
	}
	public String getGoods_location() {
		return goods_location;
	}
	public void setGoods_location(String goods_location) {
		this.goods_location = goods_location;
	}
	public Date getGoods_lastsale_date() {
		return goods_lastsale_date;
	}
	public void setGoods_lastsale_date(Date goods_lastsale_date) {
		this.goods_lastsale_date = goods_lastsale_date;
	}
	public String getGoods_fileName() {
		return goods_fileName;
	}
	public void setGoods_fileName(String goods_fileName) {
		this.goods_fileName = goods_fileName;
	}
	
	
	
	/*
	
	private int goods_id;
	private String goods_title;
	private String goods_writer;//
	private int    goods_price;//
	private String goods_publisher;//
	private String goods_sort;//
	private int    goods_sales_price;//
	private int    goods_point;
	private Date    goods_published_date;
	private int    goods_total_page;
	private String goods_isbn;
	private String goods_delivery_price;
	private Date goods_delivery_date;
	private String goods_fileName;
	private String goods_status;//
	private String goods_writer_intro;//
	private String goods_contents_order;//
	private String goods_intro;//
	private String goods_publisher_comment;//
	private String goods_recommendation;//
	private Date   goods_credate;//
	

	public GoodsVO() {
	}

	



	public int getGoods_id() {
		return goods_id;
	}





	public void setGoods_id(int goods_id) {
		this.goods_id = goods_id;
	}





	public String getGoods_title() {
		return goods_title;
	}



	public void setGoods_title(String goods_title) {
		this.goods_title = goods_title;
	}



	public String getGoods_writer() {
		return goods_writer;
	}



	public void setGoods_writer(String goods_writer) {
		this.goods_writer = goods_writer;
	}



	public int getGoods_price() {
		return goods_price;
	}



	public void setGoods_price(int goods_price) {
		this.goods_price = goods_price;
	}



	public String getGoods_publisher() {
		return goods_publisher;
	}



	public void setGoods_publisher(String goods_publisher) {
		this.goods_publisher = goods_publisher;
	}

	public String getGoods_sort() {
		return goods_sort;
	}

	public void setGoods_sort(String goods_sort) {
		this.goods_sort = goods_sort;
	}
	public int getGoods_sales_price() {
		return goods_sales_price;
	}

	public void setGoods_sales_price(int goods_sales_price) {
		this.goods_sales_price = goods_sales_price;
	}

	public int getGoods_point() {
		return goods_point;
	}



	public void setGoods_point(int goods_point) {
		this.goods_point = goods_point;
	}


	public int getGoods_total_page() {
		return goods_total_page;
	}

	public void setGoods_total_page(int goods_total_page) {
		this.goods_total_page = goods_total_page;
	}

	public String getGoods_isbn() {
		return goods_isbn;
	}



	public void setGoods_isbn(String goods_isbn) {
		this.goods_isbn = goods_isbn;
	}






	public String getGoods_delivery_price() {
		return goods_delivery_price;
	}



	public void setGoods_delivery_price(String goods_delivery_price) {
		this.goods_delivery_price = goods_delivery_price;
	}


	public Date getGoods_published_date() {
		return goods_published_date;
	}

	public void setGoods_published_date(Date goods_published_date) {
		this.goods_published_date = goods_published_date;
	}


	public Date getGoods_delivery_date() {
		return goods_delivery_date;
	}



	public void setGoods_delivery_date(Date goods_delivery_date) {
		this.goods_delivery_date = goods_delivery_date;
	}





	public String getGoods_fileName() {
		return goods_fileName;
	}



	public void setGoods_fileName(String goods_fileName) {
		this.goods_fileName = goods_fileName;
	}



	
	public String getGoods_status() {
		return goods_status;
	}





	public void setGoods_status(String goods_status) {
		this.goods_status = goods_status;
	}





	public String getGoods_writer_intro() {
		return goods_writer_intro;
	}

	public void setGoods_writer_intro(String goods_writer_intro) {
		this.goods_writer_intro = goods_writer_intro;
	}
	public String getGoods_contents_order() {
		return goods_contents_order;
	}
	public void setGoods_contents_order(String goods_contents_order) {
		this.goods_contents_order = goods_contents_order;
	}
	public String getGoods_intro() {
		return goods_intro;
	}
	public void setGoods_intro(String goods_intro) {
		this.goods_intro = goods_intro;
	}

	public String getGoods_publisher_comment() {
		return goods_publisher_comment;
	}

	public void setGoods_publisher_comment(String goods_publisher_comment) {
		this.goods_publisher_comment = goods_publisher_comment;
	}

	public String getGoods_recommendation() {
		return goods_recommendation;
	}

	public void setGoods_recommendation(String goods_recommendation) {
		this.goods_recommendation = goods_recommendation;
	}

	public Date getGoods_credate() {
		return goods_credate;
	}

	public void setGoods_credate(Date goods_credate) {
		this.goods_credate = goods_credate;
	}
	
*/
}
