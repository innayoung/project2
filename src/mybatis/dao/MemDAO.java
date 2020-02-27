package mybatis.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import mybatis.service.FactoryService;
import mybatis.vo.MemVO;

public class MemDAO {
	
	//ID Check
	public static MemVO get_member(String id) {
		
		SqlSession ss = FactoryService.getFactory().openSession();
		
		MemVO mvo = ss.selectOne("mem.get_member", id);
		ss.close();
		
		return mvo;
	}
	
	//회원가입(회원 추가)
	public static boolean add_member(String id, String pw, String name, String email, String phone) {
		  
		  boolean chk = false;
		  
		  Map<String, String> map = new HashMap<String, String>(); 
		  map.put("id", id);
		  map.put("pw", pw); 
		  map.put("name", name); 
		  map.put("email", email);
		  map.put("phone", phone);
		 
		  SqlSession ss = FactoryService.getFactory().openSession();
		 
		  int cnt = ss.insert("mem.add_member", map);
		  
		  if(cnt > 0) {
			  chk = true;
			  ss.commit();
		  }
		  ss.close();
		
		  return chk;
	}

	//로그인
	public static MemVO login_member(String id, String pw) {
		MemVO vo = null;
		
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("pw", pw);
		
		SqlSession ss = FactoryService.getFactory().openSession();
		
		vo = ss.selectOne("mem.login_member", map);
		ss.close();
		
		return vo;
	}
	
/*
	//로그아웃 
	public static MemVO logout_member(String id) {
	  
		SqlSession ss = FactoryService.getFactory().openSession();
	 
		MemVO mvo = ss.selectOne("bbs.logout_member", id); ss.close();
	 
		return mvo; 
	}
 */
}
