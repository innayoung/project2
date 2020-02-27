package bbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mybatis.dao.BbsDAO;
import mybatis.vo.MemVO;

public class loginAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		MemVO vo = BbsDAO.login_member(id, pw);
		
		request.setAttribute("mem_vo", vo);
		
		return "/main.jsp";
	}

}