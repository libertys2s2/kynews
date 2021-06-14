<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
     <%@ taglib uri = "http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/assets/css/main.css" />
    




<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그아웃</title>
</head>
<body>
<div id="wrapper">


	<div id="main">
						<div class="inner"> 

<div class="container">
<h1>로그아웃</h1>
        <div class="row">
        <div class="signupcenter">
        
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                    
                        <h3 class="panel-title">로그아웃</h3>
                 </div>
                 <div class="panel-body">
                  
                        <form role='form' method='post' action="/customLogout">
                        
                            <fieldset>
                                <!-- Change this to a button or input when using this as a form -->
                                <button type="submit" class="button primary btn-success ">logout</button>
                            </fieldset>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </form>
                   </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
    </div>

  
      <%@include file="includes/inner.jsp"%>  
</div>
  <!-- Bootstrap Core JavaScript -->
    <script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- DataTables JavaScript -->
    <script src="/resources/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="/resources/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
    <script src="/resources/vendor/datatables-responsive/dataTables.responsive.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="/resources/dist/js/sb-admin-2.js"></script>
<script>
	
	
	</script>
<c:if test="${param.logout!=null}">
<script>
$(document).ready(function(){
	alert("로그아웃 되셨습니다.");
	location.href="board/list";

});
</script>
</c:if>

</body>



</html>