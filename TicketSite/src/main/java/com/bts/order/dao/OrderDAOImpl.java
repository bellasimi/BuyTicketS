package com.bts.order.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.bts.order.vo.OrderVO;

@Repository("orderDAO")
public class OrderDAOImpl implements OrderDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public List<OrderVO> listMyOrderGoods(OrderVO orderVO) throws DataAccessException{
		List<OrderVO> orderGoodsList=new ArrayList<OrderVO>();
		orderGoodsList=(ArrayList)sqlSession.selectList("mapper.order.selectMyOrderList",orderVO);
		return orderGoodsList;
	}
	
	public void insertNewOrder(List<OrderVO> myOrderList) throws DataAccessException{
		int order_id=selectOrderID();
		for(int i=0; i<myOrderList.size();i++){
			OrderVO orderVO =(OrderVO)myOrderList.get(i);
			orderVO.setOrder_id(order_id);
			sqlSession.insert("mapper.order.insertNewOrder",orderVO);
		}
		
	}	
	
	public OrderVO findMyOrder(String order_id) throws DataAccessException{
		OrderVO orderVO=(OrderVO)sqlSession.selectOne("mapper.order.selectMyOrder",order_id);		
		return orderVO;
	}
	
	public void removeGoodsFromCart(OrderVO orderVO)throws DataAccessException{
		sqlSession.delete("mapper.order.deleteGoodsFromCart",orderVO);
	}
	
	public void removeGoodsFromCart(List<OrderVO> myOrderList)throws DataAccessException{
		for(int i=0; i<myOrderList.size();i++){
			OrderVO orderVO =(OrderVO)myOrderList.get(i);
			sqlSession.delete("mapper.order.deleteGoodsFromCart",orderVO);		
		}
	}	
	private int selectOrderID() throws DataAccessException{ //한번의 주문에 하나의 orderID부여된다 
		return sqlSession.selectOne("mapper.order.selectOrderID");
		
	}

	public void getPoint(List<OrderVO> myOrderList) throws DataAccessException{
		for(int i=0; i<myOrderList.size();i++){
			OrderVO orderVO =(OrderVO)myOrderList.get(i);
			sqlSession.update("mapper.order.getPoint",orderVO);
		}
		
	}

	public void usePoint(List<OrderVO> myOrderList) throws DataAccessException{
		OrderVO orderVO =(OrderVO)myOrderList.get(0);
		System.out.println("DAO쓴포인트값"+orderVO.getPoint_used());
		sqlSession.update("mapper.order.usePoint",orderVO);
	}
	
	
}

