package com.bts.goods.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.bts.goods.dao.GoodsDAO;
import com.bts.goods.vo.GoodsVO;
import com.bts.goods.vo.ImageFileVO;

@Service("goodsService")
@Transactional(propagation=Propagation.REQUIRED)
public class GoodsServiceImpl implements GoodsService{
	@Autowired
	private GoodsDAO goodsDAO;
	

//SORT 자연동물, 박물관... nature,museum,themepark,history,attraction
	@Override
	public List<GoodsVO> SortList(String goods_sort) throws Exception {
		List<GoodsVO> SortList = goodsDAO.selectSortList(goods_sort);
		return SortList;
	}
// PLACE 서울 경기 제주.. seoul,ggi, gang,chung,jeolla, sang,jeju

	@Override
	public List<GoodsVO> PlaceList(String goods_place) {
		List<GoodsVO> PlaceList = goodsDAO.selectPlaceList(goods_place);
		return PlaceList;
	}
// Status 베스트셀러,..  
	
	public Map<String,List<GoodsVO>> StatusList() throws Exception {
		Map<String,List<GoodsVO>> goodsMap=new HashMap<String,List<GoodsVO>>();
		List<GoodsVO> goodsList=goodsDAO.selectStatusList("bestseller");
		goodsMap.put("bestseller",goodsList);
		return goodsMap;
	}
	//상세페이지
	public Map goodsDetail(String _goods_id) throws Exception {
		Map goodsMap=new HashMap();
		GoodsVO goodsVO = goodsDAO.selectGoodsDetail(_goods_id);
		goodsMap.put("goodsVO", goodsVO);
		List<ImageFileVO> imageList =goodsDAO.selectGoodsDetailImage(_goods_id);
		goodsMap.put("imageList", imageList);
		return goodsMap;
	}
	//제목으로 검색
	public List<GoodsVO> searchGoods(String searchWord) throws Exception{
		List goodsList=goodsDAO.selectGoodsBySearchWord(searchWord);
		return goodsList;
	}
	//키워드 자동완성 
	public List<String> keywordSearch(String keyword) throws Exception {
		List<String> list=goodsDAO.selectKeywordSearch(keyword);
		return list;
	}

	

	
}
