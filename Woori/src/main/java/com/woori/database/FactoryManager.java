package com.woori.database;

import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class FactoryManager {
	
	// private static을 붙여서 서버 실행 시 함께 생성되도록 설정해줘야 함
	private static SqlSessionFactory sqlSessionFactory;
	
	// static 안의 내용은 서버 실행 시 바로 실행 및 생성되는 것
	static {
		// 초기화 블럭 -> 생성자를 실행할 때 함께 실행됨
		// static ; 메모리에 가장 먼저 로드 됨 >> main과 함께 가장 먼저 / 전역변수로 사용가능
		// 서버가 실행되자마자 함께 시작됨
		
		try {
			String resource = "com/woori/database/config.xml";
			InputStream inputStream = Resources.getResourceAsStream(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	public static SqlSessionFactory getSqlSessionFactory() {
		return sqlSessionFactory;
	}

	public static void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
		FactoryManager.sqlSessionFactory = sqlSessionFactory;
	}
	
	
}
