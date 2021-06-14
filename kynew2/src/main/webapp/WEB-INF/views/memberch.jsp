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
<title>회원 정보 변경</title>
</head>
<body>



<div id="wrapper">

				<!-- Main -->
					<div id="main">
						<div class="inner">
 <div class="container">
         <h1>회원 정보변경</h1>
        <div class="row">

        <div class="signupcenter">
        
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">회원정보 변경 페이지</h3>
                    </div>
                    <div class="panel-body">
                        <form role="form" method="post" >
                            <fieldset>
                                <div class="form-group">
                                <br/>
                                <span>아이디</span>
                                    <input class="form-control" placeholder="userid" name="userid" type="text" value="<sec:authentication property="principal.username"/>" readonly >
                                </div>
                                <div class="form-group">
                                <span>비밀번호</span>
                                    <input class="form-control" placeholder="Password" name="userpw" type="password" value="">
                                </div>
                                 <div class="form-group">
                                 <span>비밀번호 확인</span>
                                    <input class="form-control" placeholder="Password" name="password2" type="password" value="">
                                </div>
                                <div class="form-group">
                                <span>이름</span>
                                    <input class="form-control" placeholder="name" name="username" type="text" value="">
                                </div>
                                <div class="form-group">
                                <span>이메일</span>
                                    <input class="form-control" placeholder="email" name="useremail" type="text">
                                </div>
                               
                                <!-- Change this to a button or input when using this as a form -->
                                <button type="submit"  class="button primary"  id="sujung" name="sujung" data-oper="sujung">회원정보 수정</button>
                                <button type="submit" class="button primary" id="sakjae" name="sakjae" data-oper="sakjae">회원 탈퇴</button>
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
<script>
$(document).ready(function(){
	var formObj = $("form");
$('button').on("click",function(e){
	var operation = $(this).data("oper");
	console.log(operation);
	
	if(operation ==='sakjae'){
		if(confirm("정말로 삭제하시겠습니까?")){
			formObj.attr("type","submit");
			formObj.attr("method","POST");
		formObj.attr("action","/member/delete");

		alert("삭제되었습니다.")
		}
	}
	else if(operation ==='sujung'){
		formObj.attr("type","submit");
		formObj.attr("method","POST");
		formObj.attr("action","/member/update");
		alert("수정되었습니다.")
		
	}
	else{
		 
	}
	formObj.submit();
});

});
</script>
</body>


</html>

