package com.bts.goods.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.bts.goods.vo.GoodsVO;

public interface GoodsService {
	
	public  List<GoodsVO> SortList(String goods_sort) throws Exception; //nature,museum,themepark,history,attraction
	public List<GoodsVO> PlaceList(String goods_place);//seoul,ggi,gang,chung,jeolla,sang,jeju
	public Map<String,List<GoodsVO>> StatusList()throws Exception; //bestseller,bigsale,new,kids,freecancel
	public Map goodsDetail(String _goods_id) throws Exception;	
	public List<String> keywordSearch(String keyword) throws Exception;
	public List<GoodsVO> searchGoods(String searchWord) throws Exception;
	public boolean addWishList(Map wish)throws Exception;//goods_id String 이유가 뭐더라
	public List<GoodsVO> WishList(String member_id)throws Exception;
	public boolean deleteWishList(Map wish)throws Exception;
	public boolean deleteWishListAll(String member_id)throws Exception;
	public boolean existwish(Map wish)throws Exception;

}
