package bbs.action;

import java.io.File;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import mybatis.dao.BbsDAO;

public class writeBbsAction implements Action {

	@Override
	public String execute(HttpServletRequest request, 
			HttpServletResponse response) {
		
		//���� �޼���� list.jsp�� �ִ� [�۾���]��ư��
		//Ŭ������ ���� write.jsp���� [������]��ư�� Ŭ������ ��
		//ȣ��ȴ�.
		
		String c_type = request.getContentType();//��û�� ������ ����
		// MIMEŸ���� ��´�.
		// - Get��� : null
		// - Post��� : application/....
		// - Post��Ŀ� encType="multipart/form-data": multipart/....
		//System.out.println(c_type);
		String viewPath = "/write.jsp";
		
		if(c_type != null && c_type.startsWith("multipart/")) {
			try {
				//÷�������� ������ ��ġ�� ������ȭ ��Ų��.
				ServletContext application = 
						request.getServletContext();
				
				String path = application.getRealPath("/upload");
				
				MultipartRequest mr =
					new MultipartRequest(request, path, 
						1024*1024*5, "utf-8",
						new DefaultFileRenamePolicy());
				//�̶� ÷������ ���ε� ��!!!!!!
				
				//������ �Ķ���͵� �ޱ�
				String title = mr.getParameter("title");
				String writer = mr.getParameter("writer");
				String content = mr.getParameter("content");
				
				//������ ÷�εǾ�����? 
				File f = mr.getFile("file");
				
				String f_name = "";
				String o_name = "";
				if(f != null){
					//���� ÷���� �� ���ϸ�� �ö� �� �̸��� ��´�.
					o_name = mr.getOriginalFileName("file");
					f_name = f.getName();
				}
				String ip = request.getRemoteAddr(); //ip
				
				//DB����
				BbsDAO.write_bbs(title, writer, content, f_name, o_name, ip);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			//JSP��θ� ��ȯ�ϸ� forward�ǵ��� �Ǿ� �־
			// f5 ��, ȭ�� ������ �ϸ� ����� ������ ��� ����ȴ�.
			//viewPath = "control?type=list";
			viewPath = null;
		}
		
		
		return viewPath;
	}

}
