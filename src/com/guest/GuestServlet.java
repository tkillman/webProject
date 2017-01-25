package com.guest;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.MyUtil;

import net.sf.json.JSONObject;

@WebServlet("/guest/*")
public class GuestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		process(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		process(req, resp);
	}
	
	protected void forward(HttpServletRequest req, 
			                   HttpServletResponse resp, String path)
			throws ServletException, IOException {
		RequestDispatcher rd=req.getRequestDispatcher(path);
		rd.forward(req, resp);
	}

	protected void process(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// ���ڵ�
		req.setCharacterEncoding("utf-8");
		
		// URI
		String uri=req.getRequestURI();
		
		// uri�� ���� �۾� ����
		if(uri.indexOf("guest.do")!=-1) {
			mainGuest(req, resp);
		} else if(uri.indexOf("list.do")!=-1) {
			listGuest(req, resp);
		} else if(uri.indexOf("insert.do")!=-1) {
			insertGuest(req, resp);
		} else if(uri.indexOf("delete.do")!=-1) {
			deleteGuest(req, resp);
		}
	}
	
	private void mainGuest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String path="/WEB-INF/views/guest/guest.jsp";
		forward(req, resp, path);
	}

	private void listGuest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		GuestDAO dao=new GuestDAO();
		MyUtil util=new MyUtil();
		
		String pageNo=req.getParameter("pageNo");
		int current_page=1;
		if(pageNo!=null)
			current_page=Integer.parseInt(pageNo);
		
		// ��ü ������ ����
		int dataCount=dao.dataCount();
		
		// ��ü�������� ���ϱ�
		int numPerPage=5;
		int total_page=util.pageCount(numPerPage, dataCount);
		
		// ��ü���������� ǥ���� �������� ū���
		if(total_page<current_page)
			current_page=total_page;
		
		// �����õ������� ���۰� ��
		int start=(current_page-1)*numPerPage+1;
		int end=current_page*numPerPage;
		
		// ������ ��������
		List<GuestDTO> list=dao.listGuest(start, end);
		
		// ����¡ó��
		String paging=util.paging(current_page, total_page);
		
		JSONObject job = new JSONObject();
		job.put("list", list);
		job.put("dataCount", dataCount);
		job.put("pageNo", current_page);
		job.put("paging", paging);

		resp.setContentType("text/html; charset=utf-8");
		PrintWriter out=resp.getWriter();
		out.print(job.toString());
	}

	private void insertGuest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		GuestDAO dao=new GuestDAO();
		GuestDTO dto=new GuestDTO();
		dto.setName(req.getParameter("name"));
		dto.setContent(req.getParameter("content"));
		
		int result=dao.insertGuest(dto);
		String state="true";
		
		if(result==0)
			state="false";
		
		JSONObject job=new JSONObject();
		job.put("state", state);
		
		resp.setContentType("text/html; charset=utf-8");
		PrintWriter out=resp.getWriter();
		out.print(job.toString());
	}

	private void deleteGuest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		
	}

}
