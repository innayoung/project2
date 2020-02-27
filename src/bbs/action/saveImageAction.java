package bbs.action;

import java.io.File;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class saveImageAction implements Action {

	@Override
	public String execute(HttpServletRequest request, 
			HttpServletResponse response) {
		// �̹����� ������ ��ġ�� ������ȭ ��Ų��.
		ServletContext application = request.getServletContext();
		String path = application.getRealPath("/editor_img");
		
		try {
			MultipartRequest mr = 
				new MultipartRequest(request, path, 1024*1024*5,
						"utf-8", new DefaultFileRenamePolicy());
			
			String fname = null;
			File f = mr.getFile("upload");
			if(f != null)
				fname = f.getName();
			
			//jsp���Ͽ��� jsonǥ������� ���� ���ε�� ������
			//��θ� ����ؾ� �Ѵ�.
			//�׷��� ���ϸ�� ��θ� request�� ������ ��
			//jsp�� forward�Ǿ� ǥ���ؾ� ��!
			request.setAttribute("fname", fname);
			request.setAttribute("c_path", request.getContextPath());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/saveImage.jsp";
	}

}
