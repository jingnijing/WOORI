package com.woori.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.woori.database.FactoryManager;
import com.woori.entity.Tb_care;
import com.woori.entity.Tb_login;

public class CareDAO {
private SqlSessionFactory factory = FactoryManager.getSqlSessionFactory();
	
	public int newCare(Tb_care care) {
		SqlSession session = factory.openSession(true);
		int result = session.insert("newCare", care);
		session.close();
		return result;
	}
	
	public Tb_care myCare(int pet_idx) {
		SqlSession session = factory.openSession(true);
		Tb_care result = session.selectOne("care", pet_idx);
        session.close();
        return result;
	}
	
}
