package com.bts.member.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.bts.member.vo.MemberVO;

@Repository("memberDAO")
public class MemberDAOImpl  implements MemberDAO{
	@Autowired
	private SqlSession sqlSession;	
	
	@Override
	public MemberVO login(Map loginMap) throws DataAccessException{
		MemberVO member=(MemberVO)sqlSession.selectOne("mapper.member.login",loginMap);
	   return member;
	}
	
	@Override
	public void insertNewMember(MemberVO memberVO) throws DataAccessException{
		sqlSession.insert("mapper.member.insertNewMember",memberVO);
	}

	@Override
	public String selectOverlappedID(String id) throws DataAccessException {
		String result =  sqlSession.selectOne("mapper.member.selectOverlappedID",id);
		return result;
	}

	@Override
	public MemberVO psi(String id) {
		MemberVO result =  sqlSession.selectOne("mapper.member.psi",id);
		return result;
	}

	@Override
	public MemberVO ist(Map hp) {
		MemberVO result = sqlSession.selectOne("mapper.member.ist",hp);
		return result;
	}

	@Override
	public MemberVO isn(String name) {
		MemberVO result = sqlSession.selectOne("mapper.member.isn",name);
		return result;
	}
	
	
}
