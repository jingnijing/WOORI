package com.woori.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.woori.database.FactoryManager;
import com.woori.entity.Tb_login;

public class LoginDAO {

	private SqlSessionFactory factory = FactoryManager.getSqlSessionFactory();
	
	public Tb_login login(Tb_login tb_login) {
		SqlSession session = factory.openSession(true);
		Tb_login result = session.selectOne("login", tb_login);
		session.close();
		return result;
	}
	
	
	
	
	
}
