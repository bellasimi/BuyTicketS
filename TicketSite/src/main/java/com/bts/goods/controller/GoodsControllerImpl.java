package com.bts.goods.controller;

import java.io.Console;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bts.common.base.BaseController;
import com.bts.goods.service.GoodsService;
import com.bts.goods.vo.GoodsVO;
import com.bts.goods.vo.ImageFileVO;
import com.bts.goods.vo.WishVO;
import com.bts.member.vo.MemberVO;
import com.bts.order.vo.OrderVO;

import net.sf.json.JSONObject;

@Controller("goodsController")
@RequestMapping(value="/goods")
public class GoodsControllerImpl extends BaseController   implements GoodsController {
	@Autowired
	private GoodsService goodsService;

	@Autowired
	private MemberVO memberVO;
//이렇게 두면 db에 값 없을 때 페이지 안뜸.
//sort별로 분류 
	//자연동물,박물관, ... nature,museum,themepark,history,attraction
		@RequestMapping(value= "/sort.do" ,method={RequestMethod.POST,RequestMethod.GET})
		public ModelAndView sort(@RequestParam("goods_sort")String goods_sort, HttpServletRequest request, HttpServletResponse response) throws Exception{
			HttpSession session;
			ModelAndView mav=new ModelAndView();
			String viewName=(String)request.getAttribute("viewName");//goods/SortList.jsp
			mav.setViewName(viewName);
			
			session=request.getSession();
			session.setAttribute("side_menu", "user");
			List<GoodsVO> SortList =goodsService.SortList(goods_sort);
			String sort = SortList.get(0).getGoods_sort();// sort로 검색한 리스트 중 아무값에서나 getGoods_sort()하면 sort명만 추출가능
			mav.addObject("sort", sort);
			mav.addObject("SortList", SortList);
						
			return mav;
		
		}

	//정렬
		//가격 오름차순
		@RequestMapping(value="/slistcheap.do",method= {RequestMethod.POST, RequestMethod.GET})
		public ModelAndView slistcheap(@RequestParam("goods_sort")String goods_sort) throws Exception {
			ModelAndView mav = new ModelAndView();
			List<GoodsVO> SortList =goodsService.SortList(goods_sort);
			String sort = SortList.get(0).getGoods_sort();
			//for문에서 c:set 안되서 하는 짓임. 
			SortList = SortList.stream().sorted(Comparator.comparing(GoodsVO::getGoods_sales_price)).collect(Collectors.toList());
	
			mav.addObject("listmenu","list1");
			mav.addObject("sort", sort);
			mav.addObject("SortList", SortList);
			mav.setViewName("/goods/sort");
			return mav;
		}
		//할인율순
		@RequestMapping(value="/slistdiscount.do",method= {RequestMethod.POST, RequestMethod.GET})
		public ModelAndView slistdiscount(@RequestParam("goods_sort")String goods_sort) throws Exception {
			ModelAndView mav = new ModelAndView();
			List<GoodsVO> SortList =goodsService.SortList(goods_sort);
			
			String sort = SortList.get(0).getGoods_sort();
			//for문에서 c:set 안되서 하는 짓임. 
			SortList = SortList.stream().sorted(Comparator.comparing(GoodsVO::getGoods_discount).reversed()).collect(Collectors.toList());

			mav.addObject("listmenu","list2");
			mav.addObject("sort", sort);
			mav.addObject("SortList", SortList);
			mav.setViewName("/goods/sort");
			return mav;
		}
		//평점순
		@RequestMapping(value="/slistrate.do",method= {RequestMethod.POST, RequestMethod.GET})
		public ModelAndView slistrate(@RequestParam("goods_sort")String goods_sort) throws Exception {
			ModelAndView mav = new ModelAndView();
			List<GoodsVO> SortList =goodsService.SortList(goods_sort);
			
			String sort = SortList.get(0).getGoods_sort();
			//for문에서 c:set 안되서 하는 짓임. 
			SortList = SortList.stream().sorted(Comparator.comparing(GoodsVO::getGoods_rate_avg).reversed()).collect(Collectors.toList());
			
		
			mav.addObject("listmenu","list3");
			mav.addObject("sort", sort);
			mav.addObject("SortList", SortList);
			mav.setViewName("/goods/sort");
			return mav;
		}
//place별로 
		//서울,경기,강원도,충청도,전라도,경상도,제주도 
		//seoul,ggi,gang,chung,jeolla,sang,jeju
		@RequestMapping(value="/place.do", method= {RequestMethod.POST, RequestMethod.GET})
		public ModelAndView place(@RequestParam("goods_place")String goods_place,HttpServletRequest request, HttpServletResponse response) throws Exception {
			ModelAndView mav = new ModelAndView();
			String viewName = (String) request.getAttribute("viewName");//goods/PlaceList.jsp
			List<GoodsVO> PlaceList = goodsService.PlaceList(goods_place);
			String place = PlaceList.get(0).getGoods_place();// 지역이름으로 검색한 리스트 중 아무값에서나 getGoods_place()하면 지역이름만 추출가능
			//for문에서 c:set 안되서 하는 짓임. 
			mav.addObject("place",place);//지역이름
			mav.addObject("PlaceList",PlaceList);
			mav.setViewName(viewName);
			return mav;
		}
	//정렬
		//가격 오름차순
		@RequestMapping(value="/plistcheap.do",method= {RequestMethod.POST, RequestMethod.GET})
		public ModelAndView plistcheap(@RequestParam("goods_place")String goods_place) throws Exception {
			ModelAndView mav = new ModelAndView();
			List<GoodsVO> PlaceList = goodsService.PlaceList(goods_place);		
			String place = PlaceList.get(0).getGoods_place();// 지역이름으로 검색한 리스트 중 아무값에서나 getGoods_place()하면 지역이름만 추출가능
			//for문에서 c:set 안되서 하는 짓임. 
			PlaceList = PlaceList.stream().sorted(Comparator.comparing(GoodsVO::getGoods_sales_price)).collect(Collectors.toList());
	
			mav.addObject("place",place);//지역이름
			mav.addObject("listmenu","list1");
			mav.addObject("PlaceList",PlaceList);
			mav.setViewName("/goods/place");
			return mav;
		}
		//할인율순
		@RequestMapping(value="/plistdiscount.do",method= {RequestMethod.POST, RequestMethod.GET})
		public ModelAndView plistdiscount(@RequestParam("goods_place")String goods_place) throws Exception {
			ModelAndView mav = new ModelAndView();
			List<GoodsVO> PlaceList = goodsService.PlaceList(goods_place);
			
			String place = PlaceList.get(0).getGoods_place();// 지역이름으로 검색한 리스트 중 아무값에서나 getGoods_place()하면 지역이름만 추출가능
			//for문에서 c:set 안되서 하는 짓임. 
			PlaceList = PlaceList.stream().sorted(Comparator.comparing(GoodsVO::getGoods_discount).reversed()).collect(Collectors.toList());
			
			mav.addObject("place",place);//지역이름
			mav.addObject("listmenu","list2");
			mav.addObject("PlaceList",PlaceList);
			mav.setViewName("/goods/place");
			return mav;
		}
		//평점순
		@RequestMapping(value="/plistrate.do",method= {RequestMethod.POST, RequestMethod.GET})
		public ModelAndView plistrate(@RequestParam("goods_place")String goods_place) throws Exception {
			ModelAndView mav = new ModelAndView();
			List<GoodsVO> PlaceList = goodsService.PlaceList(goods_place);
			
			String place = PlaceList.get(0).getGoods_place();// 지역이름으로 검색한 리스트 중 아무값에서나 getGoods_place()하면 지역이름만 추출가능
			//for문에서 c:set 안되서 하는 짓임. 
			PlaceList = PlaceList.stream().sorted(Comparator.comparing(GoodsVO::getGoods_rate_avg).reversed()).collect(Collectors.toList());
			
			mav.addObject("place",place);//지역이름
			mav.addObject("listmenu","list3");
			mav.addObject("PlaceList",PlaceList);
			mav.setViewName("/goods/place");
			return mav;
		}
	
	//상품 상세페이지 
	@RequestMapping(value="/goodsDetail.do" ,method = RequestMethod.GET)
	public ModelAndView goodsDetail(@RequestParam("goods_id") String goods_id,
			                       HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName=(String)request.getAttribute("viewName");//goods/goodsDetail.jsp
		HttpSession session=request.getSession();
		Map goodsMap=goodsService.goodsDetail(goods_id);
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("goodsMap", goodsMap);
		List<ImageFileVO> imageList = (List<ImageFileVO>) goodsMap.get("imageList");
		System.out.println(imageList);
		GoodsVO goodsVO=(GoodsVO)goodsMap.get("goodsVO");
		mav.addObject("goods", goodsVO);
		addGoodsInQuick(goods_id,goodsVO,session); //이걸 모르겠네 아마 이게 커맨드 방식으로 goodsvo 보내주는 걸까?
		//리뷰존재 여부
			boolean existreview = goodsService.existreview(goods_id);
			
			if(existreview==false) {
				mav.addObject("existreview", existreview);
			}else {//존재하면
				
				mav.addObject("existreview", existreview);			
				//해당 상품리뷰
				List<OrderVO> review = goodsService.selectreview(goods_id);
				mav.addObject("reviewlist", review);
				mav.addObject("count",review.size()); //리뷰한 총 사람수
				
			}	
		
		return mav;
	}
	
	//예매일 제약조건 확인 
	@RequestMapping(value = "/reservation.do", method=RequestMethod.GET)
	public ModelAndView reservation(@RequestParam("goods_ticket_date") Date goods_ticket_date) {
		ModelAndView mav = new ModelAndView();
		return mav;
	
	}
	
//검색어로 찾기 -> 뷰페이지 존재 
	@RequestMapping(value="/searchGoods.do" ,method = RequestMethod.GET)
	public ModelAndView searchGoods(@RequestParam("searchWord") String searchWord,
			                       HttpServletRequest request, HttpServletResponse response,HttpSession session ) throws Exception{
		String viewName=(String)request.getAttribute("viewName"); //goods/searchGoods.jsp
		List<GoodsVO> goodsList=goodsService.searchGoods(searchWord);
		ModelAndView mav = new ModelAndView(viewName);
			
		mav.addObject("goodsList", goodsList);
		mav.addObject("searchWord",searchWord);
		return mav;
		
	}
//검색어로 찾기 정렬
	//판매종료임박순-  오름차순
	@RequestMapping(value="/searchlastsale.do",method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView searchlastsale(@RequestParam("searchWord")String searchWord,HttpServletResponse response, HttpServletRequest request) throws Exception {
		System.out.println("야호");
		ModelAndView mav = new ModelAndView();
		List<GoodsVO> goodsList = goodsService.searchGoods(searchWord);
		System.out.println(searchWord);
		goodsList = goodsList.stream().sorted(Comparator.comparing(GoodsVO::getGoods_lastsale_date)).collect(Collectors.toList());
		System.out.println(goodsList);
		mav.addObject("listmenu", "list1");
		mav.addObject("goodsList", goodsList);
		mav.addObject("searchWord",searchWord);
		mav.setViewName("/goods/searchGoods");
		return mav;
		
	}
	//가격 오름차순
	@RequestMapping(value="/searchcheap.do", method = {RequestMethod.GET})
	public ModelAndView searchprice(@RequestParam("searchWord")String searchWord,HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		List <GoodsVO> goodsList = goodsService.searchGoods(searchWord);
		goodsList = goodsList.stream().sorted(Comparator.comparing(GoodsVO::getGoods_sales_price)).collect(Collectors.toList());
		mav.addObject("listmenu","list2");
		mav.addObject("goodsList",goodsList);
		mav.addObject("searchWord",searchWord);
		mav.setViewName("/goods/searchGoods");
		return mav;
	}
	//할인율 내림차순
	@RequestMapping(value="/searchdiscount.do", method =RequestMethod.GET)
	public ModelAndView searchdiscount(@RequestParam("searchWord")String searchWord, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		List<GoodsVO> goodsList = goodsService.searchGoods(searchWord);
		goodsList = goodsList.stream().sorted(Comparator.comparing(GoodsVO::getGoods_discount).reversed()).collect(Collectors.toList());
		mav.addObject("goodsList",goodsList);
		mav.addObject("searchWord",searchWord);
		mav.addObject("listmenu","list3");
		mav.setViewName("/goods/searchGoods");
		
		return mav;
	}
	//평점평균 내림차순 
	@RequestMapping(value="/searchrate.do", method=RequestMethod.GET)
	public ModelAndView searchrate(@RequestParam("searchWord")String searchWord,HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		List<GoodsVO> goodsList = goodsService.searchGoods(searchWord);		
		  goodsList =goodsList.stream().sorted(Comparator.comparing(GoodsVO::getGoods_rate_avg). reversed()).collect(Collectors.toList());
		  mav.addObject("goodsList",goodsList); 
		  mav.addObject("searchWord",searchWord);		 
		  mav.addObject("listmenu","list4");
		  mav.setViewName("/goods/searchGoods");
		 
		return mav;
	}
//검색어로 찾은 것 위시리스트 체크
	@RequestMapping(value="/addcheckwish.do", method = RequestMethod.POST, produces ="application/text; charset=utf8")
	@ResponseBody public String addcheckwish(@RequestParam("idlist")List<String> idlist, Model model,HttpSession session, HttpServletRequest request,HttpServletResponse response) throws Exception {
		memberVO = (MemberVO) session.getAttribute("memberInfo");
		String member_id = memberVO.getMember_id();
		List<WishVO> checkwish = new ArrayList<WishVO>();
		
		for(int i=0;i<idlist.size();i++) {
			WishVO wish = new WishVO();//for문 안에 생성자를 만들어야 계속 비우고 새값 넣어짐
			wish.setGoods_id(idlist.get(i));
			//System.out.println("i번째 goods_id: "+idlist.get(i));
			//System.out.println("member_id: "+member_id);
			wish.setMember_id(member_id);
			//System.out.println("wishVO: "+wish.toString());
			checkwish.add(wish);//wish가 그 담에 비워지고 다시 채워져서 계속 새값 추가됨, for문에 생성자 없으면 마지막 값으로 전부 덮어씌워짐!!
			
		}

		//System.out.println("checkwish: "+checkwish.toString()); 
		
		boolean exist = goodsService.existcheckwish(checkwish);
		//System.out.println("값 존재함? "+exist);
		if(exist==false) {
			goodsService.addcheckwish(checkwish);			
			return "add_success";
		}else{			
			String goods_title =goodsService.showexist(checkwish);			
			return goods_title;
		}
		
		
	}
//키워드로 찾기 -> 뷰페이지가 없음 (타일즈 설정도 없음), 헤더에 존재, json으로 keyword:goods_title
	@RequestMapping(value="/keywordSearch.do",method = RequestMethod.GET,produces = "application/text; charset=utf8")
	public @ResponseBody String  keywordSearch(@RequestParam("keyword") String keyword,
			                                  HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		//System.out.println(keyword);
		if(keyword == null || keyword.equals(""))
		   return null ;
	
		keyword = keyword.toUpperCase();
		//System.out.println(keyword);
	    List<String> keywordList =goodsService.keywordSearch(keyword);
	    //System.out.println(keywordList);
	 //  JSONObject
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("keyword", keywordList);
		
	    String jsonInfo = jsonObject.toString();

	    return jsonInfo ;
	}

//위시리스트출력
	//method= {RequestMethod.POST,RequestMethod.GET}
	@RequestMapping(value="/WishList.do",method= {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView WishList(HttpServletRequest request, HttpServletResponse response) throws Exception {
	ModelAndView mav = new ModelAndView();
	HttpSession session = request.getSession();
	memberVO = (MemberVO) session.getAttribute("memberInfo");
	String member_id = memberVO.getMember_id();
	String viewName = (String) request.getAttribute("viewName");
	mav.setViewName(viewName);
	List<GoodsVO> list = goodsService.WishList(member_id); 
	mav.addObject("goodsList",list);
	return mav;
	}
	
	//위시리스트 정렬
		//판매 종료임박
		@RequestMapping(value="wishlastsale.do", method={RequestMethod.POST,RequestMethod.GET})
		public ModelAndView wishlastsale(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {
			ModelAndView mav =new ModelAndView();
			memberVO = (MemberVO) session.getAttribute("memberInfo");
			String member_id = memberVO.getMember_id();
			List<GoodsVO> list = goodsService.wishlastsale(member_id);
			mav.addObject("goodsList",list);
			mav.addObject("listmenu","list1");
			mav.setViewName("/goods/WishList");
			return mav;
		}
		//가격 오름차순
		@RequestMapping(value="wishcheap.do", method={RequestMethod.POST,RequestMethod.GET})
		public ModelAndView wishcheap(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {
			ModelAndView mav =new ModelAndView();
			memberVO = (MemberVO) session.getAttribute("memberInfo");
			String member_id = memberVO.getMember_id();
			List<GoodsVO> list = goodsService.wishcheap(member_id);
			mav.addObject("goodsList",list);
			mav.addObject("listmenu","list2");
			mav.setViewName("/goods/WishList");
			return mav;
		}
		//할인율순
		@RequestMapping(value="wishdiscount.do", method={RequestMethod.POST,RequestMethod.GET})
		public ModelAndView wishdiscount(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {
			ModelAndView mav =new ModelAndView();
			memberVO = (MemberVO) session.getAttribute("memberInfo");
			String member_id = memberVO.getMember_id();
			List<GoodsVO> list = goodsService.wishdiscount(member_id);
			mav.addObject("goodsList",list);
			mav.addObject("listmenu","list3");
			mav.setViewName("/goods/WishList");
			return mav;
		}
		//평점평균 내림차순 
		@RequestMapping(value="wishrate.do", method={RequestMethod.POST,RequestMethod.GET})
		public ModelAndView wishrate(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {
			ModelAndView mav = new ModelAndView();
			session = request.getSession();
			memberVO = (MemberVO) session.getAttribute("memberInfo");
			String member_id = memberVO.getMember_id();			
			List<GoodsVO> list = goodsService.WishList(member_id); 
			list = list.stream().sorted(Comparator.comparing(GoodsVO::getGoods_rate_avg).reversed()).collect(Collectors.toList());
			mav.addObject("goodsList",list);
			mav.addObject("listmenu","list4");
			mav.setViewName("/goods/WishList");
			return mav;
		}
		

//위시리스트에 추가 
	@RequestMapping(value="/addwish.do", method= {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody public  String addwish(@RequestParam("goods_id")int goods_id,HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		memberVO=(MemberVO) session.getAttribute("memberInfo");
		String member_id = memberVO.getMember_id();
	
		
		Map wish = new HashMap();
		wish.put("goods_id",goods_id);
		wish.put("member_id", member_id);
		
		boolean exist = goodsService.existwish(wish);
	
		if(exist==true) {
			return "isAlreadyExisted";
		}
		else {
		goodsService.addWishList(wish);
		return "null";
		}
		/*
		 * ModelAndView mav = new ModelAndView(); //mav.setViewName("goods/wishList");
		 * String viewName = (String) request.getAttribute("viewName");
		 * mav.setViewName(viewName);
		 */
		/*
		 * mav.addObject("goods_id",goods_id2); List<GoodsVO> list =
		 * goodsService.WishList(); mav.addObject("goodsList",list); return mav;
		 */
		/*
		 * if(result==true) { return "add_success"; } else return "add_fail";
		 */
	}
//위시리스트에서 각각삭제
	@RequestMapping(value="deletewish.do", method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView deletewish(@RequestParam("goods_id")String goods_id,HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		memberVO = (MemberVO) session.getAttribute("memberInfo");
		String member_id = memberVO.getMember_id();
		Map wish = new HashMap();
		wish.put("goods_id", goods_id);
		wish.put("member_id", member_id);
		boolean result = goodsService.deleteWishList(wish);

		mav.setViewName("redirect:/goods/WishList.do");
		return mav;
		
	}
	
//위시리스트 전체 삭제
	@RequestMapping(value="deletewishall.do", method={RequestMethod.POST,RequestMethod.GET})
	public  ModelAndView deletewishall(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		memberVO = (MemberVO) session.getAttribute("memberInfo");
		String member_id = memberVO.getMember_id();
		boolean result = goodsService.deleteWishListAll(member_id);
		mav.setViewName("redirect:/goods/WishList.do");
		return mav;
		
	}	
	private void addGoodsInQuick(String goods_id,GoodsVO goodsVO,HttpSession session){
		boolean already_existed=false;
		List<GoodsVO> quickGoodsList; //
		quickGoodsList=(ArrayList<GoodsVO>)session.getAttribute("quickGoodsList");
		
		if(quickGoodsList!=null){
			if(quickGoodsList.size() < 4){ //
				for(int i=0; i<quickGoodsList.size();i++){
					GoodsVO _goodsBean=(GoodsVO)quickGoodsList.get(i);
					if(goods_id.equals(_goodsBean.getGoods_id())){
						already_existed=true;
						break;
					}
				}
				if(already_existed==false){
					quickGoodsList.add(goodsVO);
				}
			}
			
		}else{
			quickGoodsList =new ArrayList<GoodsVO>();
			quickGoodsList.add(goodsVO);
			
		}
		session.setAttribute("quickGoodsList",quickGoodsList);
		session.setAttribute("quickGoodsListNum", quickGoodsList.size());
	}
//위시리스트 체크된 부분만 삭제
	@RequestMapping(value="/deletecheckedwish.do", method= {RequestMethod.POST}, produces = "application/text; charset=utf8")
	@ResponseBody public String deletecheckedwish(@RequestParam("idlist")List<String> idlist,HttpSession session,HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		memberVO = (MemberVO) session.getAttribute("memberInfo");
		String member_id =memberVO.getMember_id();
		Map wish = new HashMap();
		wish.put("member_id",member_id);
		wish.put("idlist",idlist);
		System.out.println(wish);
		goodsService.deletecheckedwish(wish);
		String result="삭제완료!";
		return result;
		
	}
	
	//키워드: goods_status 값: 해당 goodsVO 인 MAP 구현 함수 
	//현재 사용하고 있지 않음 -> 이기능을 admingoodsControl의 매핑주소:/admin/goods/adminGoodsMain.do  adminGoodsMain() 함수가 구현하고 있음 
	@RequestMapping(value="/goodsList.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView adminGoodsMain(@RequestParam Map<String, String> dateMap,
			                           HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		session=request.getSession();
		session.setAttribute("side_menu", "admin_mode"); 
		
		String fixedSearchPeriod = dateMap.get("fixedSearchPeriod");
		String section = dateMap.get("section");
		String pageNum = dateMap.get("pageNum");
		String beginDate=null,endDate=null;
		
		String [] tempDate=calcSearchPeriod(fixedSearchPeriod).split(",");
		beginDate=tempDate[0];
		endDate=tempDate[1];
		dateMap.put("beginDate", beginDate);
		dateMap.put("endDate", endDate);
		
		Map<String,Object> condMap=new HashMap<String,Object>();
		if(section== null) {
			section = "1";
		}
		condMap.put("section",section);
		if(pageNum== null) {
			pageNum = "1";
		}
		condMap.put("pageNum",pageNum);
		condMap.put("beginDate",beginDate);
		condMap.put("endDate", endDate);
		Map<String, List<GoodsVO>> GoodsList = goodsService.StatusList();
		mav.addObject("newGoodsList", GoodsList);
		
		String beginDate1[]=beginDate.split("-");
		String endDate2[]=endDate.split("-");
		mav.addObject("beginYear",beginDate1[0]);
		mav.addObject("beginMonth",beginDate1[1]);
		mav.addObject("beginDay",beginDate1[2]);
		mav.addObject("endYear",endDate2[0]);
		mav.addObject("endMonth",endDate2[1]);
		mav.addObject("endDay",endDate2[2]);
		
		mav.addObject("section", section);
		mav.addObject("pageNum", pageNum);
		return mav;
		
	}

// 평균 평점 insert
	@RequestMapping(value="/avgrate.do" ,method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody public String avgrate(@RequestParam("goods_rate_avg") int goods_rate_avg,
			@RequestParam("goods_id") String goods_id,HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map review = new HashMap();
		System.out.println("리뷰값");
		review.put("goods_id", goods_id);
		review.put("goods_rate_avg", goods_rate_avg);
		System.out.println(review);
		System.out.println("나오나");
		goodsService.avgrate(review);
		System.out.println("입력?");
		
		return "완료";
		
	}

}
