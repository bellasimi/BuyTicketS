package com.bts.wish.service;

import java.util.List;
import java.util.Map;

import com.bts.goods.vo.GoodsVO;
import com.bts.wish.vo.WishVO;

public interface WishService {
	public boolean addWishList(Map wish)throws Exception;//goods_id String 이유가 뭐더라
	public List<GoodsVO> WishList(String member_id)throws Exception;//위시리스트
	public List<GoodsVO> wishlastsale(String member_id)throws Exception;//판매종료임박
	public List<GoodsVO> wishcheap(String member_id)throws Exception;//싼가격순
	public List<GoodsVO> wishdiscount(String member_id)throws Exception;//할인율순
	//public List<GoodsVO> WishList(String member_id)throws Exception; //평점순
	public boolean deleteWishList(Map wish)throws Exception;
	public boolean deleteWishListAll(String member_id)throws Exception;
	public boolean existwish(Map wish)throws Exception;
	public void deletecheckedwish(Map wish) throws Exception;
	public void addcheckwish(List<WishVO> checkwish) throws Exception;
	public boolean existcheckwish(List<WishVO> checkwish) throws Exception;
	public String showexist(List<WishVO> checkwish) throws Exception;
}
