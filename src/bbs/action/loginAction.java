package bbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mybatis.dao.MemDAO;
import mybatis.vo.MemVO;

public class loginAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		MemVO vo = MemDAO.login_member(id, pw);
		
		HttpSession session = request.getSession();
		
		session.setAttribute("mem_vo", vo);
		
		return "/main.jsp";
	}

}