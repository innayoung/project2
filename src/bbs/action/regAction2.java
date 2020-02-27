package bbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mybatis.dao.BbsDAO;
import mybatis.vo.MemVO;

public class regAction2 implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		
		String viewPath = "/registry.jsp";
		

		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String email = request.getParameter("email1")+"@"
				+request.getParameter("email2");
		String phone=request.getParameter("phone")+"-"
				+request.getParameter("phone2")+"-"
				+request.getParameter("phone3");
		
		boolean chk = BbsDAO.add_member(id, pw, name, email, phone);

		MemVO mvo = null;

		if(chk == true) {
			mvo = new MemVO(id, pw, name, phone, email);
		}

		request.setAttribute("mvo", mvo);
		
		return viewPath;
	}

}
