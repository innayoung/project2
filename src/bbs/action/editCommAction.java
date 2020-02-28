package bbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mybatis.dao.CommDAO;
import mybatis.vo.CommVO;

public class editCommAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		String writer = request.getParameter("writer");
		String pwd = request.getParameter("pwd");
		String content = request.getParameter("content");
		String c_idx = request.getParameter("c_idx");
		String ip = request.getRemoteAddr();
		String b_idx = request.getParameter("b_idx");
		
		CommDAO.edit_comm(c_idx, ip, pwd, writer, content);
		
		CommVO[] ar = CommDAO.get_commList(b_idx);
		
		request.setAttribute("edit_comm_ar", ar);
		
		return "/res_editComm.jsp";
	}

}
