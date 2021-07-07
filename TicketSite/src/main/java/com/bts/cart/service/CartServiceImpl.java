package com.bts.cart.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.bts.cart.dao.CartDAO;
import com.bts.cart.vo.CartVO;
import com.bts.goods.vo.GoodsVO;

@Service("cartService")
@Transactional(propagation=Propagation.REQUIRED)////////트랜잭션 이거 어떤 의미로 되어있는지 확인좀 
public class CartServiceImpl  implements CartService{
	@Autowired
	private CartDAO cartDAO;
	
	public Map<String ,List> myCartList(CartVO cartVO) throws Exception{
		Map<String,List> cartMap=new HashMap<String,List>();
		List<CartVO> myCartList=cartDAO.selectCartList(cartVO);
		if(myCartList.size()==0){ //장바구니 번호 가지고 
			return null;
		}
		List<GoodsVO> myGoodsList=cartDAO.selectGoodsList(myCartList);
		cartMap.put("myCartList", myCartList);
		//cartlist는 string, list로 된 맵에 list로 들어간다 
		cartMap.put("myGoodsList",myGoodsList);
		return cartMap;
	}
	
	//장바구니에 추가할때 쓰는거 2개 
	public boolean findCartGoods(CartVO cartVO) throws Exception{
		 return cartDAO.selectCountInCart(cartVO);
	}	
	public void addGoodsInCart(CartVO cartVO) throws Exception{
		cartDAO.insertGoodsInCart(cartVO);
	}
	
	
	
	//장바구니 창에서 수량 개별 수정할때 
	public boolean modifyCartQty(CartVO cartVO) throws Exception{
		boolean result=true; //이러면 무조건 true 반환아닌가 나중에 바꿀까 
		cartDAO.updateCartGoodsQty(cartVO);
		return result;
	}
	
	//장바구니에서 한개물품 삭제 
	public void removeCartGoods(int cart_id) throws Exception{
		cartDAO.deleteCartGoods(cart_id);
	}
	
}
