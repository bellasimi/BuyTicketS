package com.bts.mypage.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.bts.order.vo.OrderVO;

@Service
public class MyPageDummyService {

	public List<OrderVO> createDummyGoods() {
		
		List<OrderVO> data = new ArrayList<OrderVO>();
		
		OrderVO order1 = new OrderVO();
		order1.setOrder_seq_num(0);
		order1.setOrder_id(123);
		order1.setGoods_id(123);
		order1.setGoods_title("테스트 상품");
		order1.setOrder_goods_qty(7);
		order1.setPay_order_time("2021년 7월 10일");
		order1.setPoint_used(12);
		
		OrderVO order2 = new OrderVO();
		order1.setOrder_seq_num(0);
		order1.setOrder_id(123);
		order1.setGoods_id(123);
		order1.setGoods_title("테스트 상품");
		order1.setOrder_goods_qty(7);
		order1.setPay_order_time("2021년 7월 10일");
		order1.setPoint_used(22);
		
		
		OrderVO order3 = new OrderVO();
		order1.setOrder_seq_num(0);
		order1.setOrder_id(123);
		order1.setGoods_id(123);
		order1.setGoods_title("테스트 상품");
		order1.setOrder_goods_qty(7);
		order1.setPay_order_time("2021년 7월 10일");
		order1.setPoint_used(32);
		
	
		data.add(order1);
		data.add(order2);
		data.add(order3);
		
		return data;
	}
}
