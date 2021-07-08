package com.bts.member.dao;

import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.bts.member.vo.MemberVO;

public interface MemberDAO {
	public MemberVO login(Map loginMap) throws DataAccessException;
	public void insertNewMember(MemberVO memberVO) throws DataAccessException;
	public String selectOverlappedID(String id) throws DataAccessException;
	public MemberVO psi(String id);
	public MemberVO ist(Map hp);
	public MemberVO isn(String name);
}
