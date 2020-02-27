package mybatis.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import mybatis.service.FactoryService;
import mybatis.vo.BbsVO;
import mybatis.vo.CommVO;
import mybatis.vo.MemVO;

public class BbsDAO {
	
		//Main 태희 해외 최신 게시글 5개 조회
		public static BbsVO[] load_overseas(){
			BbsVO[] ar = null;
			
			SqlSession ss = FactoryService.getFactory().openSession();
			
			List<BbsVO> list = ss.selectList("bbs.load_overseas");
			
			if(list != null) {
				ar = new BbsVO[list.size()];
				list.toArray(ar);
			}
			ss.close();
			return ar;
		}
		//Main 태희 국내 최신 게시글 5개 조회
		public static BbsVO load_overseas_best(){
			BbsVO vo = null;
			
			SqlSession ss = FactoryService.getFactory().openSession();
			
			vo = ss.selectOne("bbs.load_overseas_best");
			
			ss.close();
			return vo;
		}
		
//Reg 나영 회원 아이디 중복 조회 기능
		public static MemVO get_member(String id) {
			
			SqlSession ss = FactoryService.getFactory().openSession();
			
			MemVO mvo = ss.selectOne("bbs.get_member", id);
			ss.close();
			
			return mvo;
		}
		
//Reg 나영 회원 추가 기능
		public static boolean add_member(String id, String pw, String name, String email, String phone) {
			  
			  boolean chk = false;
			  
			  	  
			  Map<String, String> map = new HashMap<String, String>(); 
			  map.put("id", id);
			  map.put("pw", pw); 
			  map.put("name", name); 
			  map.put("email", email);
			  map.put("phone", phone);
			 
			  SqlSession ss = FactoryService.getFactory().openSession();
			 
			  int cnt = ss.insert("bbs.add_member", map);
			  
			  if(cnt > 0) {
				  chk = true;
				  ss.commit();
			  }
			  ss.close();
			
			  return chk;
		}
		
//logIn 도현 login기능
		public static MemVO login_member(String id, String pw) {
			MemVO vo = null;
			
			System.out.println("DAO login");
			System.out.println(id);
			System.out.println(pw);
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("id", id);
			map.put("pw", pw);
			
			SqlSession ss = FactoryService.getFactory().openSession();
			
			vo = ss.selectOne("bbs.login_member", map);
			
			
			//System.out.println(vo.getM_name());
			
			ss.close();
			
			return vo;
		}
		
// list 나영 list기능
		// list 전체게시물의 수 반환
		public static int get_totalCount() {
			SqlSession ss = 
				FactoryService.getFactory().openSession();
			
			int cnt = ss.selectOne("bbs.get_totalCount");
			ss.close();
			
			return cnt;
		}
		
// list 나영 list를 배열로 반환하는 기능
		public static BbsVO[] get_list(int begin, int end) {
			BbsVO[] ar = null;
			
			SqlSession ss =
				FactoryService.getFactory().openSession();
			
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("begin", begin);
			map.put("end", end);
			
			List<BbsVO> list = ss.selectList("bbs.get_list", map);
			//각 게시물을 의미하는 객체가 BbsVO이다. 그 안에
			// 댓글들이 들어온 상태다.
			
			//받은 list를 준비된 배열로 변환해야 한다.
			if(list != null) {
				ar = new BbsVO[list.size()];
				list.toArray(ar);
			}
			ss.close();
			
			return ar;
		}
		
// view 은경 조회수 증가 기능 
		public static void add_hit(String b_idx) {
			SqlSession ss =
				FactoryService.getFactory().openSession();
			
			int cnt = ss.update("bbs.add_hit", b_idx);
			if(cnt > 0)
				ss.commit();
			else
				ss.rollback();
			
			ss.close();
		}
		
// view 은경 b_idx를 받아 게시글 읽기
		public static BbsVO get_bbs(String b_idx) {
			SqlSession ss = 
				FactoryService.getFactory().openSession();
			
			BbsVO vo = ss.selectOne("bbs.get_bbs", b_idx);
			ss.close();
			
			return vo;
		}
		
// view 태희 댓글 저장기능
		public static boolean write_comm(String writer, String content, String pwd, String ip, String b_idx) {
			
			boolean chk = false;
			
			SqlSession ss = FactoryService.getFactory().openSession();
			Map<String, String> map = new HashMap<String, String>();
			map.put("writer", writer);
			map.put("content", content);
			map.put("pwd", pwd);
			map.put("ip", ip);
			map.put("b_idx", b_idx);
			
			int commit = ss.insert("bbs.write_comm", map);
			if(commit == 1) {
				ss.commit();
				chk = true;
			}else {
				ss.rollback();
			}
			
			ss.close();
			
			return chk;
		}
		
// view 태희 댓글 조회기능
		// b_idx값을 인자로 받아서
		// 특정 게시물의 댓글 리스트를 반환하는 기능 - view.jsp
		public static CommVO[] get_commList(String b_idx) {
			CommVO[] ar = null;
			
			SqlSession ss = FactoryService.getFactory().openSession();
			
			List<CommVO> list = ss.selectList("bbs.get_commList", b_idx);
			
			if(list != null) {
				ar = new CommVO[list.size()];
				list.toArray(ar);
			}
			
			ss.close();
			return ar;
		}
		
		//원글 저장기능
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
			int cnt = ss.insert("bbs.write_bbs", map);
			
			if(cnt > 0) {
				value = true;
				ss.commit();
			}
			ss.close();
			
			return value;
		}
		
		//원글 수정기능
		public static boolean edit_bbs(String b_idx, String title, 
				String writer,String content, String fname,  			
				String oname, String ip, String pwd) {
			
			boolean value = false;
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("b_idx", b_idx);
			map.put("subject", title);
			map.put("content", content);
			map.put("pwd", pwd);
			map.put("ip", ip);
			
			if(fname != null && fname.trim().length() > 0) {
				map.put("fname", fname);
				map.put("oname", oname);
			}
			
			SqlSession ss = 
				FactoryService.getFactory().openSession();
			int cnt = ss.update("bbs.edit_bbs", map);
			
			if(cnt > 0) {
				value = true;
				ss.commit();
			}else
				ss.rollback();
			
			ss.close();
			
			return value;
		}
}















