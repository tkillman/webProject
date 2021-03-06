package com.bbs;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.SessionInfo;
import com.util.MyServlet;
import com.util.MyUtil;

import net.sf.json.JSONObject;

@WebServlet("/bbs/*")
public class BoardServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");

		String uri = req.getRequestURI();

		// uri에 따른 작업 구분
		if (uri.indexOf("list.do") != -1) {// ok , 리스트를 보여준다.
			list(req, resp);
		} else if (uri.indexOf("created.do") != -1) {// ok,작성란으로 보낸다.
			createdForm(req, resp);
		} else if (uri.indexOf("created_ok.do") != -1) {// ok,작성한 것 디비에 저장
			createdSubmit(req, resp);
		} else if (uri.indexOf("article.do") != -1) {// ok, 글 보기
			article(req, resp);
		} else if (uri.indexOf("update.do") != -1) {// ok ,자신이 올린 글 맞는지 확인후 작성란
			updateForm(req, resp);
		} else if (uri.indexOf("update_ok.do") != -1) {// ok , 작성한 것 디비에 저장
			updateSubmit(req, resp);
		} else if (uri.indexOf("delete.do") != -1) { // ok , 삭제
			delete(req, resp);
		} else if (uri.indexOf("insertReply.do") != -1) {// ok, 답글 넣기
			insertReply(req, resp);
		} else if (uri.indexOf("listReply.do") != -1) { // ok, 답글 리스트
			listReply(req, resp);
		} else if (uri.indexOf("deleteReply.do") != -1) {// ok , 답글 삭제
			deleteReply(req, resp);
		}
	}

	private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시물 리스트
		String cp = req.getContextPath();

		// 디비에서 작업할 객체생성
		BoardDAO dao = new BoardDAOImpl();

		// 페이징처리 객체생성
		MyUtil util = new MyUtil();

		// 페이지 값 받아오기
		String page = req.getParameter("page");

		// 일단 현재 페이지를 1로 설정
		int current_page = 1;

		if (page != null)
			current_page = Integer.parseInt(page);

		// 검색

		// 찾을 목차(제목,작성자,내용,등록일)
		String searchKey = req.getParameter("searchKey");

		// 찾을 내용
		String searchValue = req.getParameter("searchValue");

		if (searchKey == null) {
			searchKey = "subject";
			searchValue = "";
		}

		// GET 방식인 경우 디코딩
		if (req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}

		// 전체 데이터 개수
		int dataCount;
		if (searchValue.length() == 0)
			// 게시글 전체 int 반환
			dataCount = dao.dataCount();
		else
			// 조건에 맞는 갯수만 int 반환
			dataCount = dao.dataCount(searchKey, searchValue);

		// 전체 페이지 수

		int numPerPage = 10;
		int total_page = util.pageCount(numPerPage, dataCount);

		// 웹 페이지는 정적이기 때문에 내가 요청한 페이지가 다른 사람이 삭제 했을 수도 있기 때문에
		if (current_page > total_page)
			current_page = total_page;

		// 게시물 가져올 시작과 끝
		int start = (current_page - 1) * numPerPage + 1;
		int end = current_page * numPerPage;

		// 게시물 가져오기
		List<BoardDTO> list = null;

		if (searchValue.length() == 0)

			// 전체 게시글
			list = dao.listBoard(start, end);
		else
			// 조건에 맞는 게시글
			list = dao.listBoard(start, end, searchKey, searchValue);

		// 리스트 글번호 만들기
		int listNum, n = 0;

		Iterator<BoardDTO> it = list.iterator();

		while (it.hasNext()) {
			BoardDTO dto = it.next();

			listNum = dataCount - (start + n - 1);

			dto.setListNum(listNum);

			n++;
		}

		String params = "";

		if (searchValue.length() != 0) {
			// 검색인 경우 검색값 인코딩
			searchValue = URLEncoder.encode(searchValue, "utf-8");
			params = "searchKey=" + searchKey + "&searchValue=" + searchValue;
		}

		// 페이징 처리
		String listUrl = cp + "/bbs/list.do";
		String articleUrl = cp + "/bbs/article.do?page=" + current_page;

		if (params.length() != 0) {
			listUrl += "?" + params;
			articleUrl += "&" + params;
		}

		String paging = util.paging(current_page, total_page, listUrl);

		// 포워딩할 JSP로 넘길 속성
		req.setAttribute("list", list);
		req.setAttribute("page", current_page);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("paging", paging);
		req.setAttribute("articleUrl", articleUrl);

		// JSP로 포워딩
		String path = "/WEB-INF/views/bbs/list.jsp";
		forward(req, resp, path);

	}

	private void createdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// 글쓰기 폼
		String cp = req.getContextPath();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) { // 로그인되지 않은 경우
			resp.sendRedirect(cp + "/member/login.do");
			return;
		}

		req.setAttribute("mode", "created");
		String path = "/WEB-INF/views/bbs/created.jsp";
		forward(req, resp, path);
	}

	private void createdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글 저장
		String cp = req.getContextPath();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) { // 로그인되지 않은 경우
			resp.sendRedirect(cp + "/member/login.do");
			return;
		}

		BoardDAO dao = new BoardDAOImpl();
		BoardDTO dto = new BoardDTO();

		// userId는 세션에 저장된 정보
		dto.setUserId(info.getUserId());

		// 파라미터
		dto.setSubject(req.getParameter("subject"));
		dto.setContent(req.getParameter("content"));

		dao.insertBoard(dto);

		resp.sendRedirect(cp + "/bbs/list.do");
	}

	private void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글보기
		String cp = req.getContextPath();
		BoardDAO dao = new BoardDAOImpl();

		// 파라미터 : num, page, [searchKey, searchValue]
		int num = Integer.parseInt(req.getParameter("num"));
		String page = req.getParameter("page");
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		if (searchKey == null) {
			searchKey = "subject";
			searchValue = "";
		}

		searchValue = URLDecoder.decode(searchValue, "utf-8");

		// 조회수 증가
		dao.updateHitCount(num);

		// 게시물 가져오기
		BoardDTO dto = dao.readBoard(num);
		if (dto == null) { // 게시물이 없으면 다시 리스트로
			resp.sendRedirect(cp + "/bbs/list.do?page=" + page);
			return;
		}

		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));

		// 이전글 다음글
		BoardDTO preReadDto = dao.preReadBoard(dto.getNum(), searchKey, searchValue);
		BoardDTO nextReadDto = dao.nextReadBoard(dto.getNum(), searchKey, searchValue);

		// 리스트나 이전글/다음글에서 사용할 파라미터
		String params = "page=" + page;
		if (searchValue.length() != 0) {
			params += "&searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");
		}

		// JSP로 전달할 속성
		req.setAttribute("dto", dto);
		req.setAttribute("page", page);
		req.setAttribute("params", params);
		req.setAttribute("preReadDto", preReadDto);
		req.setAttribute("nextReadDto", nextReadDto);

		req.setAttribute("searchKey", searchKey);
		req.setAttribute("searchValue", searchValue);

		// 포워딩
		String path = "/WEB-INF/views/bbs/article.jsp";
		forward(req, resp, path);
	}

	private void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 수정 폼
		String cp = req.getContextPath();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) { // 로그인되지 않은 경우
			resp.sendRedirect(cp + "/member/login.do");
			return;
		}

		BoardDAO dao = new BoardDAOImpl();

		String page = req.getParameter("page");
		int num = Integer.parseInt(req.getParameter("num"));
		BoardDTO dto = dao.readBoard(num);

		if (dto == null) {
			resp.sendRedirect(cp + "/bbs/list.do?page=" + page);
			return;
		}

		// 게시물을 올린 사용자가 아니면
		if (!dto.getUserId().equals(info.getUserId())) {
			resp.sendRedirect(cp + "/bbs/list.do?page=" + page);
			return;
		}

		req.setAttribute("dto", dto);
		req.setAttribute("page", page);
		req.setAttribute("mode", "update");

		String path = "/WEB-INF/views/bbs/created.jsp";
		forward(req, resp, path);
	}

	private void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 수정 완료
		String cp = req.getContextPath();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) { // 로그인되지 않은 경우
			resp.sendRedirect(cp + "/member/login.do");
			return;
		}
		BoardDAO dao = new BoardDAOImpl();

		String page = req.getParameter("page");

		if (req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/bbs/list.do?page=" + page);
			return;
		}

		BoardDTO dto = new BoardDTO();
		dto.setNum(Integer.parseInt(req.getParameter("num")));
		dto.setSubject(req.getParameter("subject"));
		dto.setContent(req.getParameter("content"));

		dao.updateBoard(dto);

		resp.sendRedirect(cp + "/bbs/list.do?page=" + page);
	}

	private void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 삭제
		String cp = req.getContextPath();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) { // 로그인되지 않은 경우
			resp.sendRedirect(cp + "/member/login.do");
			return;
		}

		BoardDAO dao = new BoardDAOImpl();

		String page = req.getParameter("page");
		int num = Integer.parseInt(req.getParameter("num"));
		BoardDTO dto = dao.readBoard(num);

		if (dto == null) {
			resp.sendRedirect(cp + "/bbs/list.do?page=" + page);
			return;
		}

		// 게시물을 올린 사용자나 admin이 아니면
		if (!dto.getUserId().equals(info.getUserId()) && !info.getUserId().equals("admin")) {
			resp.sendRedirect(cp + "/bbs/list.do?page=" + page);
			return;
		}

		// bbsReply 테이블은 ON DELETE CASCADE 옵션으로 bbs 테이블의 데이터가 지워지면 자동 지워짐
		dao.deleteBoard(num);
		resp.sendRedirect(cp + "/bbs/list.do?page=" + page);
	}

	private void insertReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 리플 저장하기 ---------------------------------------

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String isLogin = "true";
		String state = "false";

		if (info == null) {
			isLogin = "false";
		} else {

			int num = Integer.parseInt(req.getParameter("num"));

			String content = req.getParameter("content");

			BoardDAO dao = new BoardDAOImpl();

			ReplyDTO dto = new ReplyDTO();
			dto.setNum(num);
			dto.setContent(content);
			dto.setUserId(info.getUserId());

			int result = dao.insertReply(dto);

			if (result == 1) {
				state = "true";
			}

			JSONObject job = new JSONObject();
			job.put("isLogin", isLogin);
			job.put("state", state);

			resp.setContentType("text/html; charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print(job.toString());

		}

	}

	private void listReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 리플 리스트 ---------------------------------------
		// 리플 리스트(AJAX:TEXT) ---------------------------------------

		BoardDAO dao = new BoardDAOImpl();
		MyUtil util = new MyUtil();

		int num = Integer.parseInt(req.getParameter("num"));
		String pageNo = req.getParameter("pageNo");
		int current_page = 1;
		if (pageNo != null)
			current_page = Integer.parseInt(pageNo);

		// 한 페이지에 보여줄 댓글 개수
		int numPerPage = 5;

		int total_page = 0;

		int dataCount = 0;

		dataCount = dao.dataCountReply(num);

		total_page = util.pageCount(numPerPage, dataCount);

		// 현재 가야할 페이지가 전체 페이지보다 작은 경우, 내가 1페이지에서 3페이지로 가려는데 다른 사람이 3페이지를 지움
		if (current_page > total_page)
			current_page = total_page;

		int start = (current_page - 1) * numPerPage + 1;

		int end = current_page * numPerPage;

		// 리스트에 출력할 데이터
		List<ReplyDTO> list = dao.listReply(num, start, end);

		// 엔터를 <br>
		Iterator<ReplyDTO> it = list.iterator();

		while (it.hasNext()) {
			ReplyDTO dto = it.next();
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}

		// 페이징처리(인수2개 짜리 js로 처리)
		String paging = util.paging(current_page, total_page);

		req.setAttribute("list", list);
		req.setAttribute("pageNo", current_page);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("total_page", total_page);
		req.setAttribute("paging", paging);

		// 포워딩
		String path = "/WEB-INF/views/bbs/listReply.jsp";
		forward(req, resp, path);
	}

	private void deleteReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 리플 삭제 ---------------------------------------

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String isLogin = "true";
		String state = "false";

		if (info == null) {

			isLogin = "false";

		} else {

			BoardDAO dao = new BoardDAOImpl();

			int replyNum = Integer.parseInt(req.getParameter("replyNum"));
			int result = dao.deleteReply(replyNum);

			if (result == 1) {
				state = "true";
			}

			JSONObject job = new JSONObject();
			job.put("isLogin", isLogin);
			job.put("state", state);

			resp.setContentType("text/html; charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print(job.toString());

		}
	}
}
