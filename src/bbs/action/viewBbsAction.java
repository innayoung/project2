package bbs.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mybatis.dao.BbsDAO;
import mybatis.vo.BbsVO;

public class viewBbsAction implements Action {

	@Override
	public String execute(HttpServletRequest request, 
			HttpServletResponse response) {
		// �Ķ���� �� �ޱ�
		String cPage = request.getParameter("cPage");
		String b_idx = request.getParameter("b_idx");
		
		//cPage�� �ٽ� ���ȭ������ ���ư� �� �ʿ��ϸ�, b_idx��
		// ǥ���� �Խù� ����(BbsVO)�� ��� ���� �ʿ��ϴ�.
		BbsVO vo = BbsDAO.get_bbs(b_idx);
		
		HttpSession session = request.getSession();
		
		Object obj = session.getAttribute("read_bbs");
		
		if(vo != null){
			boolean chk = false;
			List<BbsVO> list = null;
			
			if(obj == null){
				list = new ArrayList<BbsVO>();
				session.setAttribute("read_bbs", list);
			}else{
				list = (List<BbsVO>)obj;
				
				//vo�� b_idx�� list�� �ִ� �� BbsVO�� b_idx�� ��
				for(BbsVO r_vo : list){
					if(b_idx.equals(r_vo.getB_idx())){
						chk = true;
						break;
					}
				}
			}
			
			if(!chk){
				//�ϴ� �� �Խù��� ��ȸ�� ���� �����´�.
				int hit = Integer.parseInt(vo.getHit());
				++hit;
				
				vo.setHit(String.valueOf(hit)); 
				
				// ��������� vo�� ������ �ִ� hit���� ����������
				// DB���� ������� �ʾҴ�.
				BbsDAO.add_hit(b_idx);
				
				//���� �Խù��� ó���ϱ� ���� list�� vo�� �߰�
				list.add(vo);
			}
		
			request.setAttribute("vo", vo);
			request.setAttribute("cPage", cPage);//JSP���� �ٷ� EL�� ��밡��
		}
		
		return "/view.jsp";
	}

}
