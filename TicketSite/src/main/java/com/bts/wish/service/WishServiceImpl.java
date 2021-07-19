package com.bts.wish.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.bts.goods.vo.GoodsVO;
import com.bts.wish.dao.WishDAO;
import com.bts.wish.vo.WishVO;

@Service("wishService")
@Transactional(propagation=Propagation.REQUIRED)
public class WishServiceImpl implements WishService {
	@Autowired
	private WishDAO wishDAO;
	//검색 후 체크된 놈들 위시리스트로 등록
		@Override
		public void addcheckwish(List<WishVO> checkwish) {
			
			wishDAO.addcheckwish(checkwish);
		
		
		}
		//체크된 놈들 위시리스트에 존재하는 지 확인
		@Override
		public boolean existcheckwish(List<WishVO> checkwish) throws Exception {
			boolean result =wishDAO.existcheckwish(checkwish);
			return result;
		}
		//존재하는놈 제목	
		@Override
		public String showexist(List<WishVO> checkwish) throws Exception {
			
			return wishDAO.showexist(checkwish);
		}
		//위시리스트 추가
		@Override
		public boolean addWishList(Map wish) throws Exception {
			boolean result = true;
			wishDAO.insertWishList(wish);
			return result;
		}
		//위시리스트 출력
		@Override
		public List<GoodsVO> WishList(String member_id) {
			List<GoodsVO> list= wishDAO.selectWishList(member_id);
			return list;
		}
		//위시리스트 삭제
		@Override
		public boolean deleteWishList(Map wish) throws Exception {
			boolean result = true;//되니까 SERVICE가 되는거임 안되면 SQL 오류뜸
			wishDAO.deleteWishList(wish);
			return result;
		}

		//위시리스트 전체 삭제

		@Override
		public boolean deleteWishListAll(String member_id) throws Exception {
			boolean result =true;
			wishDAO.deleteWishListAll(member_id);
			return result;
		}

		@Override
		public boolean existwish(Map wish) throws Exception {

			return wishDAO.existwish(wish); 
		}

		@Override
		public List<GoodsVO> wishlastsale(String member_id) throws Exception {
			
			return wishDAO.wishlastsale(member_id);
		}

		@Override
		public List<GoodsVO> wishcheap(String member_id) throws Exception {

			return wishDAO.wishcheap(member_id);
		}

		@Override
		public List<GoodsVO> wishdiscount(String member_id) throws Exception {

			return wishDAO.wishdiscount(member_id);
		}

		@Override
		public void deletecheckedwish(Map wish) throws Exception {		
			wishDAO.deletecheckedwish(wish);
			
		}

}
