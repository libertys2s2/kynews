<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="/resources/vendor/bootstrap/js/bootstrap.js"></script>
<script src="/resources/assets/js/jquery.min.js"></script>
			<script src="/resources/assets/js/browser.min.js"></script>
			<script src="/resources/assets/js/breakpoints.min.js"></script>
			<script src="/resources/assets/js/util.js"></script>
			<script src="/resources/assets/js/main.js"></script>



<link rel="stylesheet" href="/resources/assets/css/main.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
</head>
<body>



<div id="wrapper">

			
					<div id="main">
						<div class="inner"> 
 <div class="container">
  <h1>로그인 페이지</h1>
  <h2><c:out value="${error}"/></h2>
<h2><c:out value="${logout}"/></h2>
  
        <div class="row">
        <div class="signupcenter">
       
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">로그인 해주세요</h3>
                    </div>
                    <div class="panel-body">
                        <form id="login" role="form" method="post" action="/login">
                            <fieldset>
                                <div class="form-group">
                                    <input class="form-control" placeholder="userid" name="username" type="text" autofocus>
                                </div>
                                <br/>
                                <div class="form-group">
                                    <input class="form-control" placeholder="Password" name="password" type="password" value="">
                                </div>
                                <div >
                                   
                                        <input type="checkbox" name="remember-me" id="remember-me"> 
                                        <label for="remember-me">Remember Me</label>
                                </div>
                                <!-- Change this to a button or input when using this as a form -->
                                <button  class="button primary btn-success btn-block">Login</button>
                            </fieldset>
                            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
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





<%-- <form method='post' action="/login">

<div>
<input type='text' name='username' value='admin'>
</div>
<div>
<input type='password' name='password' value='admin'>
<div>
<input type="checkbox" name="remember-me">remember me
</div>

</div>
<div>
<input type='submit'>
</div>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }"/>


</form> --%>


    
    <script>
    $(".btn-success").on("click", function(e){
    	alert("로그인중")
    	e.preventDefault();
    	$("#login").submit();
    });
    </script>

</body>
</html>