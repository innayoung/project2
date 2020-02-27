package bbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mybatis.dao.BbsDAO;
import mybatis.vo.CommVO;

public class writeCommAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		
		String writer = request.getParameter("writer");
		String pwd = request.getParameter("pwd");
		String content = request.getParameter("content");
		String b_idx = request.getParameter("b_idx");
		String ip = request.getRemoteAddr();
		
		BbsDAO.write_comm(writer, content, pwd, ip, b_idx);
		
		CommVO[] ar = BbsDAO.get_commList(b_idx);
		
		request.setAttribute("comm_ar", ar);
		
		return "/res_writeComm.jsp";
	}

}
