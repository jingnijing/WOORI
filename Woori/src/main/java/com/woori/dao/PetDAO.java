package com.woori.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.woori.database.FactoryManager;
import com.woori.entity.Tb_login;
import com.woori.entity.Tb_pet;

public class PetDAO {

private SqlSessionFactory factory = FactoryManager.getSqlSessionFactory();
	
	public Tb_pet my_pet(Tb_login user) {
		SqlSession session = factory.openSession(true);
		Tb_pet result = session.selectOne("my_pet", user.getLogin_email());
		session.close();
		return result;
	}
	
	public int new_pet(Tb_pet pet) {
		SqlSession session = factory.openSession(true);
		int result = session.insert("join",pet);
		session.close();
		return result;
	}
	
	public int update_pet(Tb_pet pet) {
		SqlSession session = factory.openSession(true);
        int result = session.update("update",pet);
        session.close();
        return result;
	}
	
	
}
