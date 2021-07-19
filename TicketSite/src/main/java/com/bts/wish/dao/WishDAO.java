package com.bts.wish.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.bts.goods.vo.GoodsVO;
import com.bts.wish.vo.WishVO;

public interface WishDAO {
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
	public void addcheckwish(List<WishVO> checkwish)throws DataAccessException;
	public boolean existcheckwish(List<WishVO> checkwish)throws DataAccessException;
	public String showexist(List<WishVO> checkwish)throws DataAccessException;
}
