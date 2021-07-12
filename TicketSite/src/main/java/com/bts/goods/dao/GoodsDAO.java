package com.bts.goods.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.bts.goods.vo.GoodsVO;
import com.bts.goods.vo.ImageFileVO;

public interface GoodsDAO {
	public List<GoodsVO> selectSortList(String goods_sort) throws DataAccessException;
	//나중에 mybatis에서 #{goods_sort}로 받기 때문에 변수명도 goods_sort가 돼야 함!!
	public List<GoodsVO> selectStatusList(String goods_status) throws DataAccessException;
	public List<GoodsVO> selectPlaceList(String goods_place) throws DataAccessException;
	public List<String> selectKeywordSearch(String keyword) throws DataAccessException;
	public GoodsVO selectGoodsDetail(String goods_id) throws DataAccessException;
	public List<ImageFileVO> selectGoodsDetailImage(String goods_id) throws DataAccessException;
	public List<GoodsVO> selectGoodsBySearchWord(String searchWord) throws DataAccessException;
	// ticket_goods에서 searchWord와 like한 goods_title을 가진 데이터들 select
	public void insertWishList(Map wish) throws DataAccessException;//위시리스트에 추가
	public List<GoodsVO> selectWishList(String member_id)throws DataAccessException;//위시리스트출력
	public List<GoodsVO> wishlastsale(String member_id)throws DataAccessException;//판매종료임박순
	public List<GoodsVO> wishcheap(String member_id)throws DataAccessException;//가격 오름차순
	public List<GoodsVO> wishdiscount(String member_id)throws DataAccessException;//할인율순
	//public List<GoodsVO> wishlastsale(String member_id)throws DataAccessException; //평점순
	public void deleteWishList(Map wish)throws DataAccessException;
	public void deleteWishListAll(String member_id) throws DataAccessException;
	public boolean existwish(Map wish)throws DataAccessException;
	public void deletecheckedwish(Map wish)throws DataAccessException;

}
