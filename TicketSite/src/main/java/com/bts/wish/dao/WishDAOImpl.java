package com.bts.wish.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.bts.goods.vo.GoodsVO;
import com.bts.wish.vo.WishVO;
@Repository("wishDAO")
public class WishDAOImpl implements WishDAO {
	@Autowired
	private SqlSession sqlSession;
	
	//검색된 내용 체크한 놈들 위시리스트로 
		@Override
		public void addcheckwish(List<WishVO> checkwish) {
			sqlSession.update("mapper.wish.addcheckwish", checkwish);
			
		}
	//체크한 놈들 위시리스트에 존재하는지 boolean

		@Override
		public boolean existcheckwish(List<WishVO> checkwish) {
			String result = sqlSession.selectOne("mapper.wish.existcheckwish",checkwish);
			return Boolean.parseBoolean(result);
		}
	//존재한다면 제목이 뭔지
		@Override
		public String showexist(List<WishVO> checkwish) throws DataAccessException {
			List<GoodsVO> exist =sqlSession.selectList("mapper.wish.showexist",checkwish);
			return  exist.get(0).getGoods_title();
		}

		@Override
		public void insertWishList(Map wish) throws DataAccessException{
			sqlSession.insert("mapper.wish.insertWishList", wish);
			
		}
		@Override
		public List<GoodsVO> selectWishList(String member_id) {
			List<GoodsVO> list = sqlSession.selectList("mapper.wish.selectWishList",member_id);
			return list;
		}

		@Override
		public void deleteWishList(Map wish) throws DataAccessException {
			sqlSession.delete("mapper.wish.deleteWishList", wish);
			
		}

		@Override
		public void deleteWishListAll(String member_id) throws DataAccessException {
			sqlSession.delete("mapper.wish.deleteWishListAll",member_id);
			
		}

		@Override
		public boolean existwish(Map wish) throws DataAccessException {
			String goods_id = sqlSession.selectOne("mapper.wish.existwish",wish);
			
			return Boolean.parseBoolean(goods_id);//결과물이 존재하는지 Boolean형식으로 parsing 있으면 true, 없으면 false
		}

		@Override
		public List<GoodsVO> wishlastsale(String member_id) throws DataAccessException {
			
			return sqlSession.selectList("mapper.wish.wishlastsale", member_id);
		}

		@Override
		public List<GoodsVO> wishcheap(String member_id) throws DataAccessException {
			return sqlSession.selectList("mapper.wish.wishcheap", member_id);
		}

		@Override
		public List<GoodsVO> wishdiscount(String member_id) throws DataAccessException {
			return sqlSession.selectList("mapper.wish.wishdiscount", member_id);
		}

		@Override
		public void deletecheckedwish(Map wish) throws DataAccessException {
		
			sqlSession.delete("mapper.wish.deletecheckedwish",wish);
		}
}
