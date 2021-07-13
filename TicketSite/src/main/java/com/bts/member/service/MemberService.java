package com.bts.member.service;

import java.util.Map;

import com.bts.member.vo.MemberVO;

public interface MemberService {
	public MemberVO login(Map  loginMap) throws Exception;
	public void addMember(MemberVO memberVO) throws Exception;
	public String overlapped(String id) throws Exception;
	public MemberVO  psi(String id) throws Exception;
	public MemberVO  ist(Map hp) throws Exception;
	public MemberVO isn(String name) throws Exception;
	
}
