package bbs.control;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bbs.action.Action;

/**
 * Servlet implementation class MyController
 */
@WebServlet(
		urlPatterns = { "/control" }, 
		initParams = { 
				@WebInitParam(name = "myParam", value = "/WEB-INF/action.properties")
		})
public class MyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	//action.properties���Ͽ� �ִ� Ŭ���� ��ε���
	//�����Ǿ� ����� Map���� ����
	private Map<String, Action> actionMap;
	
    public MyController() {
        super();
        
        actionMap = new HashMap<String, Action>();
    }

	@Override
	public void init() throws ServletException {
		// �� �޼��� ù ��û�ڿ� ����
		//�� �ѹ��� �����ϴ� ��!
		
		//���� ������ ������ �� ���޵� �ʱ� �Ķ���� �����´�.
		String props_path = getInitParameter("myParam");
		// "/WEB-INF/action.properties"
		
		
		//���� action.properties������ ��θ� ������ȭ ��Ų��.
		//���������� application�� ���� ���ؾ� �Ѵ�.
		ServletContext application = getServletContext();
		
		String path = application.getRealPath(props_path);
		
		//������ȭ ��Ų ������
		// �ش� ������ ����(Ŭ���� ��ε�)�� ��Ʈ���� �̿��Ͽ�
		// �о�ͼ� Properties��ü�� ��� �����̴�.
		Properties props = new Properties();
		
		//Properties�� load�Լ��� �̿��Ͽ� ������� �о�´�.
		// �̶� InputStream�� �ʿ��ϴ�.
		FileInputStream fis = null;
		try {
			//action.properties���ϰ� ����Ǵ� ��Ʈ��
			fis = new FileInputStream(path);
			
			props.load(fis);//action.properties������
			//������� �о ����� Properties��ü��
			//Ű�� ���� ������ �����ߴ�.
			//��)  "hello" ------> "ex4.HelloAction"
		} catch (Exception e) {
			e.printStackTrace();
		}
		//////////////////////////////////////////////////////
		////// ������ ��ü���� ��ΰ� ���
		////// Properties��ü�� ����Ǿ���. ������
		////// ���� ��Ʈ�ѷ� ���忡����
		////// ������ ��ü�� ��̸�, � ��ü����?
		////// ���� ���Ѵ�. Properties�� ����� Ű���� ���
		////// ������ ���� �� �� �ִ�.
		//////////////////////////////////////////////////////
		
		Iterator<Object> it = props.keySet().iterator();
		
		//Ű���� ��� ������� Ű�� ����� Ŭ���� ��θ�
		//�ϳ��� ���� ��ü�� ������ �� Map������ ����!
		
		while(it.hasNext()) {
			//���� Ű�� �ϳ� �����ͼ� ���ڿ��� ��ȯ!
			String key = (String)it.next();
			
			//������ ���� Ű�� ����� value�� ����.
			String value = props.getProperty(key);
			// "ex4.HelloAction"
			
			try {
				Object obj = 
					Class.forName(value).newInstance();
				
				actionMap.put(key, (Action)obj);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}//while�� ��!
				
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// ��û�� �ѱ�ó��
		// post����� �ѱ�ó���� �� ���̴�.
		// get����� �ѱ�ó���� server.xml�� 
		// <Connector URIEncoding="UTF-8" connectionTimeout="20000" port="9090" protocol="HTTP/1.1" redirectPort="8443"/>
		// <Connector URIEncoding="UTF-8" port="8009" protocol="AJP/1.3" redirectPort="8443"/>
		// �� �ΰ����� ���� ���� URIEncoding="UTF-8" ���־� �ѱ�ó���Ѵ�.
		request.setCharacterEncoding("utf-8");
		
		// type�̶�� �Ķ���� �ޱ�
		String type = request.getParameter("type");
		
		// type�� null�̸� �⺻��ü�� �ν��� �� �ֵ���
		// "hello"�� �־��ش�.
		if(type == null)
			type = "list";
		
		//type���� ���� ���� actionMap�� key�� ����!
		Action action = actionMap.get(type);
		
		String viewPath = action.execute(request, response);
		
		if(viewPath != null && viewPath.trim().length() > 0) {
//			if(viewPath.equals("ans")) {						// ajax������� ����ߺ� �߻�����
//				response.sendRedirect("control?type=view&cPage="+request.getParameter("cPage")+"&b_idx="+request.getParameter("b_idx"));
//			}else {
			RequestDispatcher disp = 
				request.getRequestDispatcher(viewPath);
		
			disp.forward(request, response);
//			}
		}else if(viewPath == null)
			response.sendRedirect("control");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
