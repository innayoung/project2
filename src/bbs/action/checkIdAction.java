package bbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mybatis.dao.MemDAO;
import mybatis.vo.MemVO;

public class checkIdAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		
		MemVO vo = MemDAO.get_member(id);
		
		request.setAttribute("vo", vo);
		
		return "/IdCheck.jsp";
	}

}
