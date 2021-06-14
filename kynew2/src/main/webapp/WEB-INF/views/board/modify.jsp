<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


<!DOCTYPE HTML>

<html>
	<script type= "text/javascript" src="/resources/js/reply.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/assets/css/main.css" />

	<head>
	 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<title>Generic - Editorial by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		
	</head>
	<body class="is-preload">


		<!-- Wrapper -->
			<div id="wrapper">
<!-- Main -->
					<div id="main">
						<div class="inner">

<section>

<form role="form" action="/board/modify" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>">
<input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>">
 <input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>'>
<input type="hidden" name="type" value='<c:out value="${cri.type }"/>'>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">수정페이지</h1>
	</div>
</div>


<div class="row">
<div class="col-lg-12">
<div class="panel panel-default">


<div class="panel-heading">Board Modify Page</div>
	<div class="panel-body">
	

	
	<div class="form-group">
	<label>글번호</label> <input class="form-control" name = "bno" value ='<c:out value="${board.bno}"/>' readonly>
	<!--input type ="hidden"  -->
	</div>
	
		<div class="form-group">
			<label>제목</label>
			 <input class="form-control" name = "title" value ='<c:out value="${board.title}"/>' >
		</div>
		<div class="form-group">
			<label>내용</label>
			<textarea class="form-control" rows="3" name='content' ><c:out value="${board.content}"/></textarea>
		</div>
		<div class="form-group">
			<label>작성자</label><input class="form-control" name='writer' value ='<c:out value="${board.writer}"/>' readonly>
		</div>
		
		<div class="form-group">
			<label>작성날짜</label><input class="form-control" name='regDate' value ='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate}"/>' readonly>
		</div>
		<div class="form-group">
			<label>수정날짜</label><input class="form-control" name='updateDate' value ='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updatedate}"/>' readonly>
		</div>
		
		<div class='bigPictureWrapper'>
<div class ='bigPicture'>
</div>
</div>
<div class="row">
<div class="col-lg-12">
<div class="panel panel-default">
<div class="panel-heading">Files</div>
<!-- /.panel-heading -->
<div class="panel-body">
<input type="file" name='uploadFile' multiple>
</div>
<div class='uploadResult'>
<ul>

</ul>
</div>
</div>
</div>
</div>
		
		
		
		
		<sec:authentication property="principal" var="pinfo"/>
		<sec:authorize access="isAuthenticated()">
		<c:if test="${pinfo.username eq board.writer}">
		<button data-oper="modify" class="btn btn-default" >수정</button>
		<button data-oper="remove" class="btn btn-danger" >삭제</button>
		</c:if>
		</sec:authorize>
		<button type="submit" data-oper="list" class="btn btn-info">목록</button>

	</div>
</div>
</div>
</div>
</form>
</section>
				</div>
					</div>

<%@include file="../includes/inner.jsp"%>

			</div>

<script type="text/javascript">
$(document).ready(function(){
	var formObj = $("form");
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880;//5mb
	var formObj = $("form[role='form']");
	
	//파일용량 초과 
	function checkExtension(fileName,fileSize){
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과")
			return false;
			
		}
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드 할 수 없습니다.")
			return false;
		}
		return true;
	}
	
	$("input[type='file']").change(function(e){
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		console.log(files);
		//add filedate to formdata
		for(var i=0;i<files.length; i++){
			/* formData.append("uploadFile",files[i]); */
			if(!checkExtension(files[i].name,files[i].size)){
				return false;
			}
			formData.append("uploadFile",files[i]);
		}
		$.ajax({
			url: '/uploadAjaxAction',
			processData : false,
			contentType : false,
			data: formData,
			type: 'POST',
			beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			dataType : 'json',
			success: function(result){
				console.log(result);
				showUploadResult(result);// 업로드 결과 처리 함수
			}
		});
		
		
	});
	$('button').on("click", function(e){
		e.preventDefault();
		var operation = $(this).data("oper");
		console.log(operation);
		
		if(operation === 'remove'){
			formObj.attr("action","/board/remove");
			alert("삭제 되었습니다.");
			}else if(operation === 'list'){
				//move to list
				formObj.attr("action", "/board/list").attr("method","get");
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var KeywordTag = $("input[name='keyword']").clone();
				var typeTag = $("input[name='type']").clone();
				formObj.empty();
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(KeywordTag);
				formObj.append(typeTag);
				
			}  //수정 하는  else if 추가
			else if(operation ==='modify') {
				console.log("submit clicked");
				var str = "";
				
				$(".uploadResult ul li").each(function(i, obj){
					var jobj = $(obj);
					console.dir(jobj);
					str +=  "<input type ='hidden' name ='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
					str += "<input type = 'hidden' name ='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
					str += "<input type = 'hidden' name ='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
					str += "<input type = 'hidden' name ='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
					alert("수정되었습니다");
				});
				formObj.append(str).submit();
			}			
		
			
			
			
		formObj.submit();
	});
	(function(){ //조회화면 처리 
		var bno = '<c:out value="${board.bno}"/>';
		$.getJSON("/board/getAttachList",{bno: bno}, function(arr){
			console.log(arr);
			var str = "";
			$(arr).each(function(i,attach){
				//image type
				
				if(attach.fileType){
					var fileCallPath = encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid+"_"+attach.fileName);
					str +="<li data-path='"+attach.uploadPath+"'"
					str +=" data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.image+"'> <div>"
					str +="<span>"+ attach.fileName+"</span>"
					str +="<button type='button'data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"
					str +="<img src='/display?fileName="+fileCallPath+"'>"
					str +="</div>"
					str +="</li>"
					}else{
						str +="<li data-path='"+attach.uploadPath+"'"
						str +=" data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.image+"'> <div>"
						str +="<span>"+ attach.fileName+"</span>"
						str +="<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"
						str +="<img src='/resources/img/attach.png'></a>"
						str +="</div>"
						str +="</li>"
				}
					
				});
			
				$(".uploadResult ul").html(str);

		}); // end getjson
	})();//end function  ()지우면 안됨
	
	$(".uploadResult").on("click","button", function(e){
		console.log("delete file");
		
		
		if(confirm("Remove this file?")){
			var targetLi = $(this).closest("li");
			targetLi.remove();
		}
	});
	
	
	//파일 삽입
	function showUploadResult(arr){
		if(!arr || arr.length ==0){return;}
		var uploadUL = $(".uploadResult ul");
		var str = "";
		$(arr).each(function(i, obj){
			//image type
			
			if(obj.image){
				var fileCallPath = encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid+"_"+obj.fileName);
				str +="<li data-path='"+obj.uploadPath+"'"
				str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'> <div>"
				str +="<span>"+ obj.fileName+"</span>"
				str +="<button type='button'data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"
				str +="<img src='/display?fileName="+fileCallPath+"'>"
				str +="</div>"
				str +="</li>"
				

			}else{
				var fileCallPath = encodeURIComponent( obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
				var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
			
				str +="<li data-path='"+obj.uploadPath+"'"
				str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'> <div>"
				str +="<span>"+ obj.fileName+"</span>"
				str +="<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"
				str +="<img src='/resources/img/attach.png'></a>"
				str +="</div>"
				str +="</li>"
			
			}
		});
		uploadUL.append(str);
	}
	
	
});

</script>


</body>
</html>

