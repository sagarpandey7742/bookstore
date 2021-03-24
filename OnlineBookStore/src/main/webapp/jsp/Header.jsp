

<%@page import="in.co.book.store.controller.LoginCtl"%>
<%@page import="in.co.book.store.controller.OBSView"%>
<%@page import="in.co.book.store.bean.UserBean"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="/OnlineBookStore/css/style.css" rel="stylesheet" >
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
<script type="text/javascript">
function myMode() {
	
	
	 
	var mode = document.getElementById("saleType").value;
	
	
	if("Free".trim() === mode.trim()){
	  document.getElementById("input_price").disabled = true;
	  
	}
	if("Paid".trim() === mode.trim()){
		  document.getElementById("input_price").disabled = false;
		  
		}
	
	}
</script>
</head>
<body>
 <%
    UserBean userBean = (UserBean) session.getAttribute("user");

    boolean userLoggedIn = userBean != null;

    String welcomeMsg = "Hi, ";

    if (userLoggedIn) {
        String role = (String) session.getAttribute("role");
        welcomeMsg += userBean.getFirstName() + " (" + role + ")";
    } else {
        welcomeMsg += "Guest";
    }

%>
<nav class="navbar navbar-expand-md navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">OnlineBookStore</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-end" id="navbarsExampleDefault">
            <ul class="navbar-nav m-auto">
            
            <%if(userLoggedIn){ %>
 					<%if(userBean.getRoleId()==1){%>              
                <li class="nav-item active">
                    <a class="nav-link" href="<%=OBSView.WELCOME_CTL%>">Home <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item ">
                    <a class="nav-link" href="<%=OBSView.BOOK_CTL%>">Add Book</a>
                </li>
                <li class="nav-item ">
                    <a class="nav-link" href="<%=OBSView.BOOK_LIST_CTL%>">Book</a>
                </li>
  				
               <%}else if(userBean.getRoleId()==2){%>
               <li class="nav-item active">
                    <a class="nav-link" href="<%=OBSView.WELCOME_CTL%>">Home <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item ">
                    <a class="nav-link" href="<%=OBSView.BOOKED_LIST_CTL%>">Booked Book List</a>
                </li>
               <%} %>
              <%}else{%>
              	<li class="nav-item active">
                    <a class="nav-link" href="<%=OBSView.WELCOME_CTL%>">Home <span class="sr-only">(current)</span> </a>
                </li>
                
                 <li class="nav-item">
                    <a class="nav-link" href="<%=OBSView.INDEX_CTL%>">Books</a>
                </li>
               <!--  <li class="nav-item">
                    <a class="nav-link" href="">ContectUs</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="">AboutUs</a>
                </li> -->
                
              <%}%>
           
               
                
            </ul>
            
            <%if(userLoggedIn){%>  	
               
                <a class="btn btn-success btn-sm ml-3" href="<%=OBSView.LOGIN_CTL%>?operation=<%=LoginCtl.OP_LOG_OUT%>">
                    <i class="fa fa-sign-out"></i> Logout
                </a>  
                <%}else{%>
                <a class="btn btn-success btn-sm ml-3" href="<%=OBSView.LOGIN_CTL%>">
                    <i class="fa fa-sign-in"></i>Login
                </a>
                
                <%} %> 
            
        </div>
    </div>
</nav>



</body>
</html>