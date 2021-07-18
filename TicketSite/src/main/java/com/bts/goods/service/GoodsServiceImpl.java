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
import com.bts.goods.vo.WishVO;
import com.bts.order.vo.OrderVO;

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
		goodsList=goodsDAO.selectStatusList("bigsale");
		goodsMap.put("bigsale",goodsList);
		goodsList=goodsDAO.selectStatusList("newsale");
		goodsMap.put("newsale",goodsList);
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
	
	//검색 후 체크된 놈들 위시리스트로 등록
	@Override
	public void addcheckwish(List<WishVO> checkwish) {
		
		goodsDAO.addcheckwish(checkwish);
	
	
	}
	//체크된 놈들 위시리스트에 존재하는 지 확인
	@Override
	public boolean existcheckwish(List<WishVO> checkwish) throws Exception {
		boolean result =goodsDAO.existcheckwish(checkwish);
		return result;
	}
	//존재하는놈 제목	
	@Override
	public String showexist(List<WishVO> checkwish) throws Exception {
		
		return goodsDAO.showexist(checkwish);
	}

	//키워드 자동완성 
	public List<String> keywordSearch(String keyword) throws Exception {
		List<String> list=goodsDAO.selectKeywordSearch(keyword);
		return list;
	}
	//위시리스트 추가
	@Override
	public boolean addWishList(Map wish) throws Exception {
		boolean result = true;
		goodsDAO.insertWishList(wish);
		return result;
	}
	//위시리스트 출력
	@Override
	public List<GoodsVO> WishList(String member_id) {
		List<GoodsVO> list= goodsDAO.selectWishList(member_id);
		return list;
	}
	//위시리스트 삭제
	@Override
	public boolean deleteWishList(Map wish) throws Exception {
		boolean result = true;//되니까 SERVICE가 되는거임 안되면 SQL 오류뜸
		goodsDAO.deleteWishList(wish);
		return result;
	}

	//위시리스트 전체 삭제

	@Override
	public boolean deleteWishListAll(String member_id) throws Exception {
		boolean result =true;
		goodsDAO.deleteWishListAll(member_id);
		return result;
	}

	@Override
	public boolean existwish(Map wish) throws Exception {

		return goodsDAO.existwish(wish); 
	}

	@Override
	public List<GoodsVO> wishlastsale(String member_id) throws Exception {
		
		return goodsDAO.wishlastsale(member_id);
	}

	@Override
	public List<GoodsVO> wishcheap(String member_id) throws Exception {

		return goodsDAO.wishcheap(member_id);
	}

	@Override
	public List<GoodsVO> wishdiscount(String member_id) throws Exception {

		return goodsDAO.wishdiscount(member_id);
	}

	@Override
	public void deletecheckedwish(Map wish) throws Exception {		
		goodsDAO.deletecheckedwish(wish);
		
	}

	@Override
	public List<OrderVO> selectreview(String goods_id) throws Exception {		
		return goodsDAO.selectreview(goods_id);
	}

	@Override
	public boolean existreview(String goods_id) throws Exception {
		
		return goodsDAO.existreview(goods_id);
	}

	@Override
	public void avgrate(Map review) {
		goodsDAO.avgsrate(review);
		
	}

	

}
