package bbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mybatis.dao.BbsDAO2;

public class delBbsAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		
		String b_idx = request.getParameter("b_idx");
		String pwd = request.getParameter("pwd");
		
		/*
			System.out.println("");
			System.out.println(b_idx);
			System.out.println(pwd);
		*/
		
		boolean chk = BbsDAO2.del_Bbs(b_idx, pwd);
		
		request.setAttribute("delResult", chk);
		
		return "/res_delBbs.jsp";
	}

}
