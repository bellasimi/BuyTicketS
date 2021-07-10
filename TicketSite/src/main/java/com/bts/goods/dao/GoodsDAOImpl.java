package com.bts.goods.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.bts.goods.vo.GoodsVO;
import com.bts.goods.vo.ImageFileVO;

@Repository("goodsDAO")
public class GoodsDAOImpl  implements GoodsDAO{
	@Autowired
	private SqlSession sqlSession;
	

//sort별 리스트 출력( 박물관,어트랙션...)

	@Override
	public List<GoodsVO> selectSortList(String goods_sort) throws DataAccessException {
		List<GoodsVO> list =sqlSession.selectList("mapper.goods.selectSortList",goods_sort);
		return list;
	}

//status별 리스트 출력(베스트셀러,..)
	@Override
	public List<GoodsVO> selectStatusList(String goods_status) throws DataAccessException {
		List<GoodsVO> list =sqlSession.selectList("mapper.goods.selectStatusList",goods_status);
		return list;
	}

//place별 리스트 출력(서울,경기,제주...)	
	@Override
	public List<GoodsVO> selectPlaceList(String goods_place) throws DataAccessException {
		List<GoodsVO> list =sqlSession.selectList("mapper.goods.selectPlaceList",goods_place);
		return list;
	}
//제목으로 검색
	@Override
	public ArrayList selectGoodsBySearchWord(String searchWord) throws DataAccessException{
		ArrayList list=(ArrayList)sqlSession.selectList("mapper.goods.selectGoodsBySearchWord",searchWord);
		 return list;
	}
//goods_id가 일치하는 데이터 goodsVO형태로 출력 	
	@Override
	public GoodsVO selectGoodsDetail(String goods_id) throws DataAccessException{
		GoodsVO goodsVO=(GoodsVO)sqlSession.selectOne("mapper.goods.selectGoodsDetail",goods_id);
		return goodsVO;
	}
	
	@Override
	public List<ImageFileVO> selectGoodsDetailImage(String goods_id) throws DataAccessException{
		List<ImageFileVO> imageList=(ArrayList)sqlSession.selectList("mapper.goods.selectGoodsDetailImage",goods_id);
		return imageList;
	}
//키워드 자동완성
	@Override
	public List<String> selectKeywordSearch(String keyword) throws DataAccessException {
	   List<String> list=(ArrayList)sqlSession.selectList("mapper.goods.selectKeywordSearch",keyword);
	   return list;
	}
	
	@Override
	public void insertWishList(Map wish) throws DataAccessException{
		sqlSession.insert("mapper.goods.insertWishList", wish);
		
	}
	@Override
	public List<GoodsVO> selectWishList(String member_id) {
		List<GoodsVO> list = sqlSession.selectList("mapper.goods.selectWishList",member_id);
		return list;
	}

	@Override
	public void deleteWishList(Map wish) throws DataAccessException {
		sqlSession.delete("mapper.goods.deleteWishList", wish);
		
	}

	@Override
	public void deleteWishListAll(String member_id) throws DataAccessException {
		sqlSession.delete("mapper.goods.deleteWishListAll",member_id);
		
	}

	@Override
	public boolean existwish(Map wish) throws DataAccessException {
		String goods_id = sqlSession.selectOne("mapper.goods.existwish",wish);
		
		return Boolean.parseBoolean(goods_id);//결과물이 존재하는지 Boolean형식으로 parsing 있으면 true, 없으면 false
	}

	@Override
	public List<GoodsVO> wishlastsale(String member_id) throws DataAccessException {
		
		return sqlSession.selectList("mapper.goods.wishlastsale", member_id);
	}

	@Override
	public List<GoodsVO> wishcheap(String member_id) throws DataAccessException {
		return sqlSession.selectList("mapper.goods.wishcheap", member_id);
	}

	@Override
	public List<GoodsVO> wishdiscount(String member_id) throws DataAccessException {
		return sqlSession.selectList("mapper.goods.wishdiscount", member_id);
	}

	
}
