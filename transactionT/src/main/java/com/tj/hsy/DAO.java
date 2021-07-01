package com.tj.hsy;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.transaction.support.TransactionTemplate;

public class DAO {
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;

	JdbcTemplate template;
	@Autowired
	public void setTemplate(JdbcTemplate template) {
		this.template = template;
		Constant.template =this.template;
	}
	
	TransactionTemplate transaction;
	@Autowired
	public void setTransaction(TransactionTemplate transaction) {
		this.transaction = transaction;
	}
	
	public void withdraw(final DTO dt) {
		

		transaction.execute(new TransactionCallbackWithoutResult() {
			
			@Override
			protected void doInTransactionWithoutResult(TransactionStatus status) {
				// TODO Auto-generated method stub
				
	
		template.update(new PreparedStatementCreator() {
			
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				String sql ="insert into bank(name,input,withdraw,left) values(?,?,?,?)";
				psmt = con.prepareStatement(sql);
				psmt.setString(1, dt.getName());
				psmt.setInt(2, dt.getInput());
				psmt.setInt(3, dt.getWithdraw());
				psmt.setInt(4, dt.getLeft());
				
				
				return psmt;
			}
		}); // update insert함수
	
		}
		});//excute함수
	}//withdraw
	
	public ArrayList< DTO> list() {
		String sql ="select * from bank";
		return (ArrayList<DTO>) template.query(sql, new BeanPropertyRowMapper<DTO>(DTO.class));
		
	}//list
	

	
	
}//전체
