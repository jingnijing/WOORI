package com.woori.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.woori.database.FactoryManager;
import com.woori.entity.Tb_care;
import com.woori.entity.Tb_login;
import com.woori.entity.Tb_pet;

public class CareDAO {
private SqlSessionFactory factory = FactoryManager.getSqlSessionFactory();
	
	public int newCare(Tb_care care) {
		SqlSession session = factory.openSession(true);
		int row = session.insert("newCare", care);
		session.close();
		return row;
	}
	
	public Tb_care myCare(int idx) {
		SqlSession session = factory.openSession(true);
		Tb_care result = session.selectOne("petCare", idx);
        session.close();
        return result;
	}
	
	public int deleteCare(int idx) {
		SqlSession session = factory.openSession(true);
		int row = session.delete("deleteCare", idx);
        session.close();
        return row;
	}
	
}
