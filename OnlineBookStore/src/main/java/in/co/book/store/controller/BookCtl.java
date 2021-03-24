package in.co.book.store.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.log4j.Logger;

import in.co.book.store.bean.BaseBean;
import in.co.book.store.bean.BookBean;
import in.co.book.store.exception.ApplicationException;
import in.co.book.store.exception.DuplicateRecordException;
import in.co.book.store.model.BookModel;
import in.co.book.store.util.DataUtility;
import in.co.book.store.util.DataValidator;
import in.co.book.store.util.PropertyReader;
import in.co.book.store.util.ServletUtility;

/**
 * Servlet implementation class BookVtl
 */
@WebServlet(name="BookCtl",urlPatterns={"/ctl/book"})
@MultipartConfig(maxFileSize = 16177215)
public class BookCtl extends BaseCtl {
	private static final long serialVersionUID = 1L;
	private static Logger log=Logger.getLogger(BookCtl.class);
	/**
	 * Validate input Data Entered By User
	 * 
	 * @param request
	 * @return
	 */
	@Override
    protected boolean validate(HttpServletRequest request) {
		log.debug("BookCtl validate method start");
        boolean pass = true;
        
        Part part = null;
        Part pdfpart = null;
		try {
			part = request.getPart("photo");
			pdfpart = request.getPart("pdfName");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        if (DataValidator.isNull(request.getParameter("name"))) {
            request.setAttribute("name",
                    PropertyReader.getValue("error.require", "Name"));
            pass = false;
        }
        
        if ("-----Select-----".equalsIgnoreCase(request.getParameter("saleType"))) {
			request.setAttribute("saleType", PropertyReader.getValue("error.require", "Sale Type"));
			pass = false;
		}
        
        if (DataValidator.isNull(request.getParameter("price"))) {
            
            if(request.getParameter("saleType").equalsIgnoreCase("Free")) {
            	pass=true;
            }else {
            	request.setAttribute("price",
                        PropertyReader.getValue("error.require", "Price"));
            	pass=false;
            }
        }else if (!DataValidator.isInteger(request.getParameter("price"))) {
			request.setAttribute("price",
					PropertyReader.getValue("error.name", "Price"));
			pass = false;
		}

        if (DataValidator.isNull(request.getParameter("description"))) {
            request.setAttribute("description",
                    PropertyReader.getValue("error.require", "Description"));
            pass = false;
        }
        
        String img=String.valueOf(part);
        System.out.println("in Validate image =======-----"+img);
        
        String imgName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        
        
       
        if (DataValidator.isNull(imgName)) {
            request.setAttribute("photo",
                    PropertyReader.getValue("error.require", "Image"));
            pass = false;
        }
        
       String pdf=String.valueOf(pdfpart);
       
       System.out.println("in Validate pdf =======-----"+pdf);
       String pdfName = Paths.get(pdfpart.getSubmittedFileName()).getFileName().toString();
       
       if (DataValidator.isNull(pdfName)) {
           request.setAttribute("pdfName",
                   PropertyReader.getValue("error.require", "Pdf"));
           pass = false;
       }
        
        
        
        

        log.debug("BookCtl validate method end");
        return pass;
    }

	@Override
	protected BaseBean populateBean(HttpServletRequest request) {
		log.debug("BookCtl populateBean method start");
		BookBean bean=new BookBean();
		bean.setId(DataUtility.getLong(request.getParameter("id")));
		bean.setName(DataUtility.getString(request.getParameter("name")));
		bean.setDescription(DataUtility.getString(request.getParameter("description")));
		bean.setPrice(DataUtility.getLong(request.getParameter("price")));
		bean.setSaleType(DataUtility.getString(request.getParameter("saleType")));
		populateDTO(bean, request);
		log.debug("BookCtl populateBean method end");
		return bean;
	}
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		log.debug("BookCtl doGet method start"); 
		String op = DataUtility.getString(request.getParameter("operation"));
	        
	       BookModel model = new BookModel();
	        long id = DataUtility.getLong(request.getParameter("id"));
	        ServletUtility.setOpration("Add", request);
	        if (id > 0 || op != null) {
	            System.out.println("in id > 0  condition");
	            BookBean bean;
	            try {
	                bean = model.findByPK(id);
	                ServletUtility.setOpration("Edit", request);
	                ServletUtility.setBean(bean, request);
	            } catch (ApplicationException e) {
	                ServletUtility.handleException(e, request, response);
	                return;
	            }
	        }

	        ServletUtility.forward(getView(), request, response);
	        log.debug("BookCtl doGet method end");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 log.debug("BookCtl doPost method start");
			String op=DataUtility.getString(request.getParameter("operation"));
			BookModel model=new BookModel();
			long id=DataUtility.getLong(request.getParameter("id"));
			
			
			
			if(OP_SAVE.equalsIgnoreCase(op)){
				
				BookBean bean=(BookBean)populateBean(request);
				bean.setImageName(SubImage(request, response));
				bean.setPdfName(Subpdf(request, response));
					try {
						if(id>0){
							
						model.update(bean);
						ServletUtility.setOpration("Edit", request);
						ServletUtility.setSuccessMessage("Data is successfully Updated", request);
		                ServletUtility.setBean(bean, request);

						}else {
							long pk=model.add(bean);
							//bean.setId(id);
							ServletUtility.setSuccessMessage("Data is successfully Saved", request);
							ServletUtility.forward(getView(), request, response);
						}
		              
					} catch (ApplicationException e) {
						e.printStackTrace();
						ServletUtility.forward(OBSView.ERROR_VIEW, request, response);
						return;
					
				} catch (DuplicateRecordException e) {
					ServletUtility.setBean(bean, request);
					ServletUtility.setErrorMessage(e.getMessage(),
							request);
				}
				
			}else if (OP_DELETE.equalsIgnoreCase(op)) {
			BookBean bean=	(BookBean)populateBean(request);
			try {
				model.delete(bean);
				ServletUtility.redirect(OBSView.BOOK_LIST_CTL, request, response);
			} catch (ApplicationException e) {
				ServletUtility.handleException(e, request, response);
				e.printStackTrace();
			}
			}else if (OP_CANCEL.equalsIgnoreCase(op)) {
				ServletUtility.redirect(OBSView.BOOK_LIST_CTL, request, response);
				return;
		}else if (OP_RESET.equalsIgnoreCase(op)) {
			ServletUtility.redirect(OBSView.BOOK_CTL, request, response);
			return;
	}
					
			
			ServletUtility.forward(getView(), request, response);
			 log.debug("BookCtl doPost method end");
	}
	
	private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
	
	
	protected String SubImage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		response .setContentType("");
		String savePath = DataUtility.getString(PropertyReader.getValue("imagePath")); 

		File fileSaveDir = new File(savePath);
	       if (!fileSaveDir.exists()) {
	           fileSaveDir.mkdir();
	       }

	       Part part = request.getPart("photo");
	       String fileName = extractFileName(part);
	       part.write(savePath + File.separator + fileName);
	       String filePath = fileName;
	       System.out.println("Path----"+savePath + File.separator + fileName);
		
		return fileName;
		
	}
	
	protected String Subpdf(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		
		response.setContentType("application/pdf");
		String pdfPath = DataUtility.getString(PropertyReader.getValue("pdfPath"));
		
		 File pdffileSaveDir = new File(pdfPath);
	       if (!pdffileSaveDir.exists()) {
	    	   pdffileSaveDir.mkdir();
	       }
	       
	       Part pdfpart = request.getPart("pdfName");
	       String pfdfileName = extractFileName(pdfpart);
	       pdfpart.write(pdfPath + File.separator + pfdfileName);
	       
	       String pdffilePath = pfdfileName;
		
	       System.out.println("Path----"+pdfPath + File.separator + pfdfileName);
	       return pfdfileName;
		
	}

	@Override
	protected String getView() {
		// TODO Auto-generated method stub
		return OBSView.BOOK_VIEW;
	}

}
