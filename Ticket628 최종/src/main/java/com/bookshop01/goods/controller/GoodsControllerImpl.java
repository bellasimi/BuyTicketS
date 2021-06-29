package com.bookshop01.goods.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop01.common.base.BaseController;
import com.bookshop01.goods.service.GoodsService;
import com.bookshop01.goods.vo.GoodsVO;

import net.sf.json.JSONObject;

@Controller("goodsController")
@RequestMapping(value="/goods")
public class GoodsControllerImpl extends BaseController   implements GoodsController {
	@Autowired
	private GoodsService goodsService;
	//이거 매핑,뷰, sql 하나로 가능하지 않나? mapping 에 필요 값만 @requestparam해서 받아오면 될거같은데.

	//sort별로 분류 박물관, 어트랙션, 전망대....
	//자연동물/전망대
	@RequestMapping(value= "/nature.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView nature(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session;
		ModelAndView mav=new ModelAndView();
		String viewName=(String)request.getAttribute("viewName");//goods/sort/nature.jsp
		mav.setViewName(viewName);
		
		session=request.getSession();
		session.setAttribute("side_menu", "user");
		Map<String,List<GoodsVO>> goodsMap=goodsService.SortList();
		mav.addObject("Map", goodsMap);
		/*수정
		Map<String,List<GoodsVO>> SortMap =goodsService.SortList(); 키워드: sort, 값: 해당 키워드의 goods리스트 
		mav.addObject("SortMap", SortMap);
		
		 */
		return mav;
	}
	//박물관/전시
	@RequestMapping(value= "/museum.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView museum(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session;
		ModelAndView mav=new ModelAndView();
		String viewName=(String)request.getAttribute("viewName");//goods/sort/museum.jsp
		mav.setViewName(viewName);
		
		session=request.getSession();
		session.setAttribute("side_menu", "user");
		Map<String,List<GoodsVO>> goodsMap=goodsService.SortList();
		mav.addObject("Map", goodsMap);
		/*수정
		Map<String,List<GoodsVO>> SortMap =goodsService.SortList(); 키워드: sort, 값: 해당 키워드의 goods리스트 
		mav.addObject("SortMap", SortMap);
		
		 */
		return mav;
	}
	//테마파크
	@RequestMapping(value= "/themepark.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView themepark(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session;
		ModelAndView mav=new ModelAndView();
		String viewName=(String)request.getAttribute("viewName");//goods/sort/themepark.jsp
		mav.setViewName(viewName);
		
		session=request.getSession();
		session.setAttribute("side_menu", "user");
		Map<String,List<GoodsVO>> goodsMap=goodsService.SortList();
		mav.addObject("Map", goodsMap);
		/*수정
		Map<String,List<GoodsVO>> SortMap =goodsService.SortList(); 키워드: sort, 값: 해당 키워드의 goods리스트 
		mav.addObject("SortMap", SortMap);
		
		 */
		return mav;
	}
	//역사문화명소
	@RequestMapping(value= "/history.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView history(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session;
		ModelAndView mav=new ModelAndView();
		String viewName=(String)request.getAttribute("viewName");//goods/sort/history.jsp
		mav.setViewName(viewName);
		
		session=request.getSession();
		session.setAttribute("side_menu", "user");
		Map<String,List<GoodsVO>> goodsMap=goodsService.SortList();
		mav.addObject("Map", goodsMap);
		/*수정
		Map<String,List<GoodsVO>> SortMap =goodsService.SortList(); 키워드: sort, 값: 해당 키워드의 goods리스트 
		mav.addObject("SortMap", SortMap);
		
		 */
		return mav;
	}
	//어트랙션패스/기타대회
	@RequestMapping(value= "/attraction.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView attraction(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session;
		ModelAndView mav=new ModelAndView();
		String viewName=(String)request.getAttribute("viewName");//goods/sort/attraction.jsp
		mav.setViewName(viewName);
		
		session=request.getSession();
		session.setAttribute("side_menu", "user");
		Map<String,List<GoodsVO>> goodsMap=goodsService.SortList();
		mav.addObject("Map", goodsMap);
		
		/*수정
		Map<String,List<GoodsVO>> SortMap =goodsService.SortList(); 키워드: sort, 값: 해당 키워드의 goods리스트 
		mav.addObject("SortMap", SortMap);
		
		 */
		return mav;
	}
	
//place별로  이거 작동 안하는 거 같은데?? 
	
	//서울 seoul
	@RequestMapping(value="/seoul.do", method= {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView seoul(HttpServletRequest rq,HttpServletResponse rs) throws Exception
	{	ModelAndView mv = new ModelAndView();
		HttpSession session = rq.getSession();
		String viewName = (String) rq.getAttribute("viewName");//goods/place/seoul.jsp
		Map<String,List<GoodsVO>> goodsMap = goodsService.PlaceList();
		mv.addObject("Map",goodsMap);
		mv.setViewName(viewName);
		
		/*수정
		Map<String,List<GoodsVO>> PlaceMap =goodsService.PlaceList(); 키워드: place, 값: 해당 키워드의 goods리스트 
		mav.addObject("PlaceMap", PlaceMap);
		
		 */
		return mv;
	
	}
	//경기도  gyeonggi-do
	@RequestMapping(value="/ggi.do", method= {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView gyeonggi(HttpServletRequest rq, HttpServletResponse rs) throws Exception {
		ModelAndView mv = new ModelAndView();
		String viewName = (String) rq.getAttribute("viewName");//goods/place/ggi.jsp
		Map<String,List<GoodsVO>> goodsMap = goodsService.PlaceList();
		mv.addObject("Map",goodsMap);
		mv.setViewName(viewName);
		/*수정
		Map<String,List<GoodsVO>> PlaceMap =goodsService.PlaceList(); 키워드: place, 값: 해당 키워드의 goods리스트 
		mav.addObject("PlaceMap", PlaceMap);
		
		 */
		return mv;
	}
	//강원도 gangwon
	@RequestMapping(value="/gang.do", method= {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView gangwon(HttpServletRequest rq, HttpServletResponse rs) throws Exception {
		ModelAndView mv = new ModelAndView();
		String viewName = (String) rq.getAttribute("viewName");//goods/place/gang.jsp
		Map<String,List<GoodsVO>> goodsMap = goodsService.PlaceList();
		mv.addObject("Map",goodsMap);
		mv.setViewName(viewName);
		/*수정
		Map<String,List<GoodsVO>> PlaceMap =goodsService.PlaceList(); 키워드: place, 값: 해당 키워드의 goods리스트 
		mav.addObject("PlaceMap", PlaceMap);
		
		 */
		return mv;
	}
	//충청도 chungcheong
	@RequestMapping(value="/chung.do", method= {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView chungcheong(HttpServletRequest rq, HttpServletResponse rs) throws Exception {
		ModelAndView mv = new ModelAndView();
		String viewName = (String) rq.getAttribute("viewName");//goods/place/chung.jsp
		Map<String,List<GoodsVO>> goodsMap = goodsService.PlaceList();
		mv.addObject("Map",goodsMap);
		mv.setViewName(viewName);
		/*수정
		Map<String,List<GoodsVO>> PlaceMap =goodsService.PlaceList(); 키워드: place, 값: 해당 키워드의 goods리스트 
		mav.addObject("PlaceMap", PlaceMap);
		
		 */
		return mv;
	}
	//전라도 Jeolla
	@RequestMapping(value="/jeolla.do", method= {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView Jeolla(HttpServletRequest rq, HttpServletResponse rs) throws Exception {
		ModelAndView mv = new ModelAndView();
		String viewName = (String) rq.getAttribute("viewName");//goods/place/jeolla.jsp
		Map<String,List<GoodsVO>> goodsMap = goodsService.PlaceList();
		mv.addObject("Map",goodsMap);
		mv.setViewName(viewName);
		/*수정
		Map<String,List<GoodsVO>> PlaceMap =goodsService.PlaceList(); 키워드: place, 값: 해당 키워드의 goods리스트 
		mav.addObject("PlaceMap", PlaceMap);
		
		 */
		return mv;
	}
	//경상도 gyeongsang
	@RequestMapping(value="/sang.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView  gyeongsang(HttpServletRequest rq,HttpServletResponse rs) throws Exception {
		ModelAndView mv = new ModelAndView();
		String viewName = (String) rq.getAttribute("viewName");//goods/place/sang.jsp
		Map<String,List<GoodsVO>> goodsMap = goodsService.PlaceList();
		mv.addObject("Map",goodsMap);
		mv.setViewName(viewName);
		/*수정
		Map<String,List<GoodsVO>> PlaceMap =goodsService.PlaceList(); 키워드: place, 값: 해당 키워드의 goods리스트 
		mav.addObject("PlaceMap", PlaceMap);
		
		 */
		return mv;
	}
	//제주도 jeju
	@RequestMapping(value="/jeju.do",method= {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView jeju(HttpServletResponse rs,HttpServletRequest rq) throws Exception {
		ModelAndView mv = new ModelAndView();
		String viewName = (String) rq.getAttribute("viewName");//goods/place/jeju.jsp
		Map<String,List<GoodsVO>> goodsMap = goodsService.PlaceList();
		mv.addObject("Map",goodsMap);
		mv.setViewName(viewName);
		/*수정
		Map<String,List<GoodsVO>> PlaceMap =goodsService.PlaceList(); 키워드: place, 값: 해당 키워드의 goods리스트 
		mav.addObject("PlaceMap", PlaceMap);
		
		 */
		return mv;
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
		GoodsVO goodsVO=(GoodsVO)goodsMap.get("goodsVO");
		mav.addObject("goods", goodsVO);
		addGoodsInQuick(goods_id,goodsVO,session); //이걸 모르겠네 아마 이게 커맨드 방식으로 goodsvo 보내주는 걸까?
		return mav;
	}
	//검색어로 찾기 -> 뷰페이지 존재 
	@RequestMapping(value="/searchGoods.do" ,method = RequestMethod.GET)
	public ModelAndView searchGoods(@RequestParam("searchWord") String searchWord,
			                       HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName=(String)request.getAttribute("viewName"); //goods/searchGoods.jsp
		List<GoodsVO> goodsList=goodsService.searchGoods(searchWord);
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("goodsList", goodsList);
		return mav;
		
	}

	//키워드로 찾기 -> 뷰페이지가 없음 (타일즈 설정도 없음)
	@RequestMapping(value="/keywordSearch.do",method = RequestMethod.GET,produces = "application/text; charset=utf8")
	public @ResponseBody String  keywordSearch(@RequestParam("keyword") String keyword,
			                                  HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		//System.out.println(keyword);
		if(keyword == null || keyword.equals(""))
		   return null ;
	
		keyword = keyword.toUpperCase();
	    List<String> keywordList =goodsService.keywordSearch(keyword);
	    
	 //  JSONObject
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("keyword", keywordList);
		 		
	    String jsonInfo = jsonObject.toString();
	   // System.out.println(jsonInfo);
	    return jsonInfo ;
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
	
}
