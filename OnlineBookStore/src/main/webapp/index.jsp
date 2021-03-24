<%@page import="in.co.book.store.controller.IndexCtl"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="in.co.book.store.bean.BookBean"%>
<%@page import="in.co.book.store.util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Online Book Store</title>
</head>
<body>
<%@ include file="jsp/Header.jsp" %>


<section class="jumbotron text-center">
    <div class="container">
        <h1 class="jumbotron-heading">Book</h1>
    </div>
</section>
<form action="<%=OBSView.INDEX_CTL%>" method="post">
<div class="container">
    <div class="row">
        
        <div class="col">
            <div class="row">
             <%
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int size=(int)request.getAttribute("size");
                    int index = ((pageNo - 1) * pageSize) + 1;
                    BookBean bean=null;
                    List list = ServletUtility.getList(request);
                    Iterator<BookBean> it = list.iterator();

                    while (it.hasNext()) {

                         bean = it.next();
                %>
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="card">
                        <img class="card-img-top" src="<%=OBSView.APP_CONTEXT%>/images/<%=bean.getImageName()%>" alt="Card image cap">
                        <div class="card-body">
                            <h4 class="card-title"><%=bean.getName()%></h4>
                          	<%if(bean.getSaleType().equalsIgnoreCase("Paid")){ %>
                            <p class="bloc_left_price">$<%=bean.getPrice()%></p>
                            <%}else{ %>
                            <p class="bloc_left_price">Free</p>
                            <%} %>
                            <div class="row">
                                <div class="col">
                                <%if(bean.getSaleType().equalsIgnoreCase("Paid")){ %>
                                    <a  href="<%=OBSView.USER_REGISTRATION_CTL%>?biNa=<%=bean.getName()%>" class="btn btn-danger btn-block">Download</a>
                             		<%}else{ %>
                             		<a target="_blank"  href="<%=OBSView.APP_CONTEXT%>/pdfs/<%=bean.getPdfName()%>" class="btn btn-danger btn-block">Download</a>
                             		<%} %>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                </div>
                
                <%} %>
              
               
               
                <div class="col-12">
                    <nav aria-label="...">
                        <ul class="pagination">
                             <li class="page-item">
                                <input type="submit" name="operation" class="page-link"
								value="<%=IndexCtl.OP_PREVIOUS%>"
								<%=(pageNo == 1) ? "disabled" : ""%>>
                            </li>
                            
                            
                          
                            <li class="page-item">
                                <input type="submit" name="operation" class="page-link"
						value="<%=IndexCtl.OP_NEXT%>"
						<%=((list.size() < pageSize) || size==pageNo*pageSize) ? "disabled" : ""%>>
                            </li>
                             <li class="page-item">
                            </li>
                          
                          	
                          
                        </ul>
                    </nav>
                </div>
            </div>
        </div>

    </div>
</div>
</form>

<%@ include file="jsp/Footer.jsp" %>
</body>
</html>