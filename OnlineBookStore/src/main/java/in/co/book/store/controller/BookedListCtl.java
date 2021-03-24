package in.co.book.store.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import in.co.book.store.bean.BaseBean;
import in.co.book.store.bean.BookBean;
import in.co.book.store.bean.BookedBean;
import in.co.book.store.bean.UserBean;
import in.co.book.store.exception.ApplicationException;
import in.co.book.store.model.BookModel;
import in.co.book.store.model.BookedModel;
import in.co.book.store.util.DataUtility;
import in.co.book.store.util.PropertyReader;
import in.co.book.store.util.ServletUtility;

/**
 * Servlet implementation class BookedListCtl
 */
@WebServlet(name = "BookedListCtl", urlPatterns = { "/ctl/bookedList" })
public class BookedListCtl extends BaseCtl {
	private static final long serialVersionUID = 1L;
       
	private static Logger log = Logger.getLogger(BookListCtl.class);

	/**
	 * Populates bean object from request parameters
	 * 
	 * @param request
	 * @return
	 */
	@Override
	protected BaseBean populateBean(HttpServletRequest request) {
		log.debug("BookListCtl populateBean method start");
		BookedBean bean = new BookedBean();
		bean.setUserId(DataUtility.getLong(request.getParameter("userId")));
		log.debug("BookListCtl populateBean method end");
		return bean;
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		log.debug("BookListCtl doGet method start");
		List list = null;
		int pageNo = 1;
		int pageSize = DataUtility.getInt(PropertyReader.getValue("page.size"));

		BookedModel model = new BookedModel();
		BookedBean bean = (BookedBean) populateBean(request);
		HttpSession session=request.getSession();
		UserBean uBean=(UserBean)session.getAttribute("user");
		bean.setUserId(uBean.getId());
		try {
			list = model.search(bean, pageNo, pageSize);
			if (list == null || list.size() == 0) {
				ServletUtility.setErrorMessage("No Record Found", request);
			}
			ServletUtility.setList(list, request);
			ServletUtility.setPageNo(pageNo, request);
			request.setAttribute("size",model.search(bean).size());
			ServletUtility.setPageSize(pageSize, request);
			ServletUtility.forward(getView(), request, response);

		} catch (ApplicationException e) {
			ServletUtility.handleException(e, request, response);
			e.printStackTrace();
			return;
		}
		log.debug("BookListCtl doGet method end");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		log.debug("BookListCtl doPost method start");
		List list = null;

		int pageNo = DataUtility.getInt(request.getParameter("pageNo"));

		int pageSize = DataUtility.getInt(request.getParameter("pageSize"));

		pageNo = (pageNo == 0) ? 1 : pageNo;

		pageSize = (pageSize == 0) ? DataUtility.getInt(PropertyReader.getValue("page.size")) : pageSize;

		BookedBean bean = (BookedBean) populateBean(request);

		BookedModel model = new BookedModel();
		String[] ids = request.getParameterValues("ids");
		String op = DataUtility.getString(request.getParameter("operation"));

		if (OP_SEARCH.equalsIgnoreCase(op) || OP_NEXT.equalsIgnoreCase(op) || OP_PREVIOUS.equalsIgnoreCase(op)) {

			if (OP_SEARCH.equalsIgnoreCase(op)) {

				pageNo = 1;

			} else if (OP_NEXT.equalsIgnoreCase(op)) {

				pageNo++;
			} else if (OP_PREVIOUS.equalsIgnoreCase(op) && pageNo > 1) {

				pageNo--;
			}
		} else if (OP_NEW.equalsIgnoreCase(op)) {
			ServletUtility.redirect(OBSView.BOOK_CTL, request, response);
			return;
		}  else if (OP_RESET.equalsIgnoreCase(op)) {
			ServletUtility.redirect(OBSView.BOOK_LIST_CTL, request, response);
			return;

		}
		
		HttpSession session=request.getSession();
		UserBean uBean=(UserBean)session.getAttribute("user");
		bean.setUserId(uBean.getId());

		try {

			list = model.search(bean, pageNo, pageSize);
			if (list == null || list.size() == 0) {
				ServletUtility.setErrorMessage("NO Record Found", request);
			}
			ServletUtility.setList(list, request);
			ServletUtility.setPageNo(pageNo, request);
			request.setAttribute("size",model.search(bean).size());
			ServletUtility.setPageSize(pageSize, request);
			ServletUtility.forward(getView(), request, response);
		} catch (ApplicationException e) {
			ServletUtility.handleException(e, request, response);
			e.printStackTrace();
			return;
		}
	}

	@Override
	protected String getView() {
		// TODO Auto-generated method stub
		return OBSView.BOOKED_LIST_VIEW;
	}

}
