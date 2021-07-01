package com.bookshop01.goods.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.bookshop01.goods.vo.GoodsVO;
import com.bookshop01.goods.vo.ImageFileVO;

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
}
