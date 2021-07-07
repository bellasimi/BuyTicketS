package com.bts.admin.member.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bts.goods.vo.GoodsVO;
import com.bts.member.vo.MemberVO;
import com.bts.order.vo.OrderVO;

public interface AdminMemberService 
{
	public ArrayList<MemberVO> listMember(HashMap condMap) throws Exception;
	public MemberVO memberDetail(String member_id) throws Exception;
	public void  modifyMemberInfo(HashMap memberMap) throws Exception;
}
