package com.bts.member.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.bts.member.dao.MemberDAO;
import com.bts.member.vo.MemberVO;

@Service("memberService")
@Transactional(propagation=Propagation.REQUIRED)
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public MemberVO login(Map  loginMap) throws Exception{
		return memberDAO.login(loginMap);
	}
	
	@Override
	public void addMember(MemberVO memberVO) throws Exception{
		memberDAO.insertNewMember(memberVO);
	}
	
	@Override
	public String overlapped(String id) throws Exception{
		return memberDAO.selectOverlappedID(id);
	}

	@Override
	public MemberVO psi(String id) throws Exception {
	
		return memberDAO.psi(id);
	}

	@Override
	public MemberVO ist(Map hp) throws Exception {
		return memberDAO.ist(hp);
	}

	@Override
	public MemberVO isn(String name) throws Exception {
		
		return memberDAO.isn(name);
	}
	
}
