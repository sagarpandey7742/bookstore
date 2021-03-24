
<%@page import="in.co.book.store.controller.UserRegistrationCtl"%>
<%@page import="in.co.book.store.util.DataUtility"%>
<%@page import="in.co.book.store.util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registration</title>
</head>
<body>
<%@ include file="Header.jsp" %>
<section class="jumbotron text-center">
    <div class="container">
        <h1 class="jumbotron-heading">Register And Download</h1>
    </div>
</section>
<div class="container">
    <div class="row">
        <div class="col">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="<%=OBSView.INDEX_CTL%>">Home</a></li>
                    <li class="breadcrumb-item active"><a href="<%=OBSView.USER_REGISTRATION_CTL%>">Register And Download</a></li>
                </ol>
            </nav>
        </div>
    </div>
</div>
<div class="container">
    <div class="row">
        <div class="col">
            <div class="card">
                <div class="card-header bg-primary text-white"> Register And Download
                
                </div>
                <font color="red"> <%=ServletUtility.getErrorMessage(request)%></font>
                    <font color="green"> <%=ServletUtility.getSuccessMessage(request)%></font>
                <div class="card-body">
                   <form action="<%=OBSView.USER_REGISTRATION_CTL%>" method="post">
                   
                   <jsp:useBean id="bean" class="in.co.book.store.bean.UserBean"
						scope="request"></jsp:useBean>
						
						
			<input type="hidden" name="id" value="<%=bean.getId()%>"> <input
				type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
			<input type="hidden" name="modifiedBy"
				value="<%=bean.getModifiedBy()%>"> <input type="hidden"
				name="createdDatetime"
				value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
			<input type="hidden" name="modifiedDatetime"
				value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">
                   
                        <div class="form-group">
                            <label for="name">First Name</label>
                            <input type="text" class="form-control" name="firstName" placeholder="Enter First Name..." 
                                value="<%=DataUtility.getStringData(bean.getFirstName())%>" >
                                <font color="red"> <%=ServletUtility.getErrorMessage("firstName", request)%></font>
                        </div>
                        <div class="form-group">
                            <label for="name">Last Name</label>
                            <input type="text" class="form-control" name="lastName" placeholder="Enter Last Name..." 
                                alue="<%=DataUtility.getStringData(bean.getLastName())%>" >
                            <font color="red"> <%=ServletUtility.getErrorMessage("lastName", request)%></font>
                        </div>
                       
                        <div class="form-group">
                            <label for="email">Login Id</label>
                            <input type="text" class="form-control" name="login" placeholder="Enter Login Id..." 
                                value="<%=DataUtility.getStringData(bean.getLogin())%>" >
                               <font color="red"> <%=ServletUtility.getErrorMessage("login", request)%></font>
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" class="form-control" name="password" placeholder="Enter Password Here.." 
                                value="<%=DataUtility.getStringData(bean.getPassword())%>" >
                                <font color="red"> <%=ServletUtility.getErrorMessage("password", request)%></font>
                        </div>
                        
                       
                        
                        <div class="form-group">
                            <label for="email">Email  Address</label>
                            <input type="text" class="form-control" name="email" placeholder="Enter Email Address..." 
                                value="<%=DataUtility.getStringData(bean.getLogin())%>" >
                               <font color="red"> <%=ServletUtility.getErrorMessage("email", request)%></font>
                        </div>
                        
                        <div class="form-group">
                            <label for="name">Mobile No.</label>
                            <input type="text" class="form-control" name="mobile" placeholder="Enter 10 Digits mobile No."
                                value="<%=DataUtility.getStringData(bean.getMobileNo())%>" >
                                <font color="red"> <%=ServletUtility.getErrorMessage("mobile", request)%></font>
                        </div>
                        
                       <div class="form-group">
						<label for="cardNumber">Card number</label>
						<div class="input-group">
							
							<input type="text" class="form-control" name="cardNumber"
								placeholder="">
						</div>
						<!-- input-group.// -->
					</div>
					
					<div class="row">
						<div class="col-sm-8">
							<div class="form-group">
								<label><span class="hidden-xs">Expiration</span> </label>
								<div class="form-inline">
									<select class="form-control" style="width: 45%">
										<option>MM</option>
										<option>01 - January</option>
										<option>02 - February</option>
										<option>03 - March</option>
										<option>04 - April</option>
										<option>05 - May</option>
										<option>06 - June</option>
										<option>07 - July</option>
										<option>08 - August</option>
										<option>09 - September</option>
										<option>10 - October</option>
										<option>11 - November</option>
										<option>12- December</option>
									</select> <span style="width: 10%; text-align: center"> / </span> <select
										class="form-control" style="width: 45%">
										<option>YY</option>
										<option>2020</option>
										<option>2021</option>
										<option>2022</option>
										<option>2023</option>
										<option>2024</option>
										<option>2025</option>
										<option>2026</option>
									</select>
								</div>
							</div>
						</div>
					
					</div>
					
							<div class="form-group">
								<label data-toggle="tooltip" title=""
									data-original-title="3 digits code on back side of the card">CVV
									<i class="fa fa-question-circle"></i>
								</label> <input class="form-control"  type="text">
							</div>
                        
                       
                        <div class="mx-auto">
                        <input type="submit" name="operation" class="btn btn-primary text-right" value="<%=UserRegistrationCtl.OP_SIGN_UP%>">
                                <input type="submit" name="operation" class="btn btn-primary text-right" value="<%=UserRegistrationCtl.OP_RESET%>"></div>
                    </form>
                </div>
            </div>
            
             </div>
        <div class="col-12 col-sm-4">
               

            </div>
        </div>
        </div>
       
   

<br>
<%@ include file="Footer.jsp" %>
</body>
</html>