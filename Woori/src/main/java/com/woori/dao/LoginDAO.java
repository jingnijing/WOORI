package com.woori.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.woori.database.FactoryManager;
import com.woori.entity.Tb_login;

public class LoginDAO {

	private SqlSessionFactory factory = FactoryManager.getSqlSessionFactory();
	
	public Tb_login login(Tb_login login) {
		SqlSession session = factory.openSession(true);
		Tb_login result = session.selectOne("login", login);
		session.close();
		return result;
	}
	
	public int join(Tb_login login) {
		SqlSession session = factory.openSession(true);
		int result = session.insert("insert",login);
		session.close();
		return result;
	}
	
	
	
	
	
}
