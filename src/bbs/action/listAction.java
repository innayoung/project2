package bbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bbs.util.Paging;
import mybatis.dao.BbsDAO;
import mybatis.vo.BbsVO;

public class listAction implements Action {

	@Override
	public String execute(HttpServletRequest request, 
			HttpServletResponse response) {
		
		// ����¡ ó���� ���� �۾�
		Paging page = new Paging();
		
		//��ü������ ���� ���ϱ� ���� ����
		//�� �Խù��� ���� ���ؼ� ��ü������ ���� �����Ѵ�.
		//int cnt = BbsDAO.getTotalCount();
		//page.setTotalRecord(cnt);
		page.setTotalRecord(BbsDAO.get_totalCount());
		//���� �� �Խù��� ���� �������鼭 �ڵ�������
		// �� ������ ���� ����ȴ�.
		
		//�Ķ���ͷ� ���� ������ ���� �ִ��� �޾ƺ���.
		String cPage = request.getParameter("cPage");
		
		if(cPage != null){
			int p = Integer.parseInt(cPage);
			page.setNowPage(p); //�̶�!!!!!
			// �Խù��� ������ ����(begin, end) �׸���
			//������������ ������������ ���� ��� ��������.
			
		}else //cPage��� �Ķ���Ͱ� ���� ȣ��Ǿ��� ��
			page.setNowPage(page.getNowPage());// setNowPage()��
		//ȣ����� ������ begin, end, startPage, endPage����
		//�������� �ʾƼ� ����� ���� �� ����.
		
		//ȭ�鿡 ǥ���� �Խù����� ������ �´�.
		BbsVO[] ar = BbsDAO.get_list(
			page.getBegin(), page.getEnd());
		
		// �� ������(list.JSP)���� ǥ���� �ڿ�����
		//request�� �����Ѵ�.
		request.setAttribute("ar", ar);
		request.setAttribute("page", page);
		
		return "/list.jsp";
	}

}






