package mybatis.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import mybatis.service.FactoryService;
import mybatis.vo.BbsVO;

public class ListDAO {
	
	// 게시판별 전체 게시글 수 반환
	public static int get_totalCount() {
		SqlSession ss = FactoryService.getFactory().openSession();
			
		int cnt = ss.selectOne("list.get_totalCount");
		ss.close();
		
		return cnt;
	}
	
	// 게시판별 리스트 불러오기
	public static BbsVO[] get_list(int begin, int end) {
		BbsVO[] ar = null;
		
		SqlSession ss =
			FactoryService.getFactory().openSession();
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("begin", begin);
		map.put("end", end);
		
		List<BbsVO> list = ss.selectList("list.get_list", map);
		if(list != null) {
			ar = new BbsVO[list.size()];
			list.toArray(ar);
		}
		ss.close();
		
		return ar;
	}

	// 인기 게시글 1개 조회
	public static BbsVO load_bestBbs(){
		BbsVO vo = null;
		
		SqlSession ss = FactoryService.getFactory().openSession();
		
		vo = ss.selectOne("list.load_bestBbs");
		
		ss.close();
		
		return vo;
	}
	
	// 최신 게시글 5개 조회
	public static BbsVO[] load_newBbs(){
		BbsVO[] ar = null;
		
		SqlSession ss = FactoryService.getFactory().openSession();
		
		List<BbsVO> list = ss.selectList("list.load_newBbs");
		
		if(list != null) {
			ar = new BbsVO[list.size()];
			list.toArray(ar);
		}
		ss.close();
		return ar;
	}
}
