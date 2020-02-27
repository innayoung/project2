package mybatis.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import mybatis.service.FactoryService;
import mybatis.vo.CommVO;

public class CommDAO {
	
	//댓글 불러오기
	// b_idx값을 인자로 받아서
	// 특정 게시물의 댓글 리스트를 반환하는 기능 - view.jsp
	public static CommVO[] get_commList(String b_idx) {
		CommVO[] ar = null;
		
		SqlSession ss = FactoryService.getFactory().openSession();
		
		List<CommVO> list = ss.selectList("comm.get_commList", b_idx);
		
		if(list != null) {
			ar = new CommVO[list.size()];
			list.toArray(ar);
		}
		
		ss.close();
		return ar;
	}
	
	// 댓글 쓰기
	public static boolean write_comm(String writer, String content, String pwd, String ip, String b_idx) {
		
		boolean chk = false;
		
		SqlSession ss = FactoryService.getFactory().openSession();
		Map<String, String> map = new HashMap<String, String>();
		map.put("writer", writer);
		map.put("content", content);
		map.put("pwd", pwd);
		map.put("ip", ip);
		map.put("b_idx", b_idx);
		
		int commit = ss.insert("comm.write_comm", map);
		if(commit == 1) {
			ss.commit();
			chk = true;
		}else {
			ss.rollback();
		}
		
		ss.close();
		
		return chk;
	}
	
	// 댓글 수정 기능
	
	/*
	//댓글 삭제
	public static boolean delBbs(String b_idx, String pw) {
		boolean value = false;
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("no", b_idx);
		map.put("pwd", pw);
		
		SqlSession ss = 
			FactoryService.getFactory().openSession();
		
		int cnt = ss.update("bbs.del",map);
		if(cnt > 0) {
			ss.commit();
			value = true;
		}else
			ss.rollback();
		
		ss.close();
		
		return value;
	}
	*/
}
