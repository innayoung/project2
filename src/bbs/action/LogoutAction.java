package bbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LogoutAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		// �α׾ƿ�
		request.removeAttribute("mem_vo");
		
		return "/res_logout.jsp";
	}

}
