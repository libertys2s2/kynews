<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/assets/css/main.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>



<div id="wrapper">

				<!-- Main -->
					<div id="main">
						<div class="inner">
 <div class="container">
         <h1>회원 가입 페이지</h1>
<h2><c:out value="${error}"/></h2>
<h2><c:out value="${logout}"/></h2>
        <div class="row">

        <div class="signupcenter">
        
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Please Sign In</h3>
                    </div>
                    <div class="panel-body">
                        <form role="form" method="post" action="/member/signup">
                            <fieldset>
                            	
                                <div class="form-group">
                                <br/>
                                <span>아이디</span>
                                    <input class="form-control" placeholder="userid" name="userid" type="text" autofocus>                                    
                                </div>
                                <label id="wid"></label>
                                <div class="form-group">
                                <span>비밀번호</span>
                                    <input class="form-control" placeholder="Password" name="userpw" type="password" value="">
                                </div>
                                <label id="wps"></label>
                                <span>비밀번호 확인</span>
                                 <div class="form-group">
                                    <input class="form-control" placeholder="Password" name="password2" type="password" value="">
                                </div>
                                <label id="wps2"></label>
                                <div class="form-group">
                                <span>이름</span>
                                    <input class="form-control" placeholder="name" name="username" type="text" value="">
                                </div>
                                <span>이메일</span>
                                <div class="form-group">
                                    <input class="form-control" placeholder="email" name="useremail" type="text">
                                </div>
                               
                                <!-- Change this to a button or input when using this as a form -->
                                <button type="submit" class="button primary" id="gaip">Sign Up </button>
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
<script>
$("#gaip").on("click", function(e){
	alert("회원가입완료");
});
</script>
</body>


</html>

