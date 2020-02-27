package bbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LogoutAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		// ·Î±×¾Æ¿ô
		request.removeAttribute("mem_vo");
		
		return "/res_logout.jsp";
	}

}
