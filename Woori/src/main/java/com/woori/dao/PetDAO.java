package com.woori.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.woori.database.FactoryManager;
import com.woori.entity.Tb_login;
import com.woori.entity.Tb_pet;

public class PetDAO {

private SqlSessionFactory factory = FactoryManager.getSqlSessionFactory();
	
	
	public int new_pet(Tb_pet pet) {
		SqlSession session = factory.openSession(true);
		int result = session.insert("newPet",pet);
		session.close();
		return result;
	}
	
	public List<Tb_pet> my_pet(Tb_login login) {
		SqlSession session = factory.openSession(true);
        List<Tb_pet> list = session.selectList("myPet",login);
        session.close();
        return list;
	}
	
	public Tb_pet myOnePet(Tb_pet pet) {
		SqlSession session = factory.openSession(true);
        Tb_pet p = session.selectOne("myOnePet",pet);
        session.close();
        return p;
	}
	
	public int deletePet(Tb_pet pet) {
		SqlSession session = factory.openSession(true);
        int row = session.delete("deletePet",pet);
        session.close();
        return row;
	}
	
	public int updatePet(Tb_pet pet) {
		SqlSession session = factory.openSession(true);
		int result = session.update("updatePet",pet);
		session.close();
		return result;
	}
	
}
