package mybatis.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;


import mybatis.service.FactoryService;
import mybatis.vo.BbsVO;

public class BbsDAO2 {
	
		
	// 게시글 불러오기
	public static BbsVO get_bbs(String b_idx) {
		SqlSession ss = 
			FactoryService.getFactory().openSession();
		
		BbsVO vo = ss.selectOne("bbs2.get_bbs", b_idx);
		ss.close();
		
		return vo;
	}
	
	// view 은경 조회수 증가 기능 
	public static void add_hit(String b_idx) {
		SqlSession ss =
			FactoryService.getFactory().openSession();
		
		int cnt = ss.update("bbs2.add_hit", b_idx);
		if(cnt > 0)
			ss.commit();
		else
			ss.rollback();
		
		ss.close();
	}
	

	
	// 게시글 추가
	public static boolean write_bbs(String title, String writer,
			String content, String fname, String oname, 
			String ip) {
		
		boolean value = false;
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("title", title);
		map.put("writer", writer);
		map.put("content", content);
		map.put("fname", fname);
		map.put("oname", oname);
		map.put("ip", ip);
		
		SqlSession ss = FactoryService.getFactory().openSession();
		int cnt = ss.insert("bbs2.write_bbs", map);
		
		if(cnt > 0) {
			value = true;
			ss.commit();
		}
		ss.close();
		
		return value;
	}

	// 게시글 삭제 (b_idx와 pw를 받아 처리)
	public static boolean del_Bbs(String b_idx, String pw) {
		boolean value = false;
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("b_idx", b_idx);
		map.put("pwd", pw);
		
		SqlSession ss = FactoryService.getFactory().openSession();
		
		int cnt = ss.update("bbs2.del_bbs",map);
		if(cnt > 0) {
			ss.commit();
			value = true;
		}else
			ss.rollback();
		
		ss.close();
		
		return value;
	}


	// 게시글 수정
	public static boolean edit_bbs(String b_idx, String title, 
			String writer,String content, String fname,  			
			String oname, String ip, String pwd) {
		
		boolean value = false;
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("b_idx", b_idx);
		map.put("subject", title);
		map.put("writer", writer);
		map.put("content", content);
		map.put("pwd", pwd);
		
		if(fname != null && fname.trim().length() > 0) {
			map.put("fname", fname);
			map.put("oname", oname);
		}
		
		SqlSession ss = 
			FactoryService.getFactory().openSession();
		int cnt = ss.update("bbs2.edit_bbs", map);
		
		if(cnt > 0) {
			value = true;
			ss.commit();
		}else
			ss.rollback();
		
		ss.close();
		
		return value;
	}
}
