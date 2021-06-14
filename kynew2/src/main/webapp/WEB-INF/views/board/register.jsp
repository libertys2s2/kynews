<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/assets/css/main.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>작성페이지</title>
</head>
<body>

	<!-- Wrapper -->
			<div id="wrapper">
<!-- Main -->
					<div id="main">
						<div class="inner">




 <div class="container">


<div class="row">


	<div class="col-lg-12">
		<h1 class="page-header">기사 작성</h1>
	</div>
</div>


<section>
<div class="row">
<div class="signupcenter">
<div class="col-lg-12">
<div class="panel panel-default">


<div class="panel-heading">글쓰기 페이지</div>
	<div class="panel-body">
	
	<form role="form" action="/board/register" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<div class="form-group">
	<label>제목</label> <input class="form-control" name = "title">
	</div>
	
	<div class="form-group">
	<label>카테고리</label>
	<select name='category'>
	<option value=1>기타(선택해주세요)</option>
	<option value=0>공지</option>
	<option value=2>코로나</option>
	<option value=3>경제</option>
	<option value=4>스포츠</option>
	
	
	</select>
	</div>
		<div class="form-group">
			<label>내용</label>
			<textarea class="form-control" rows="20" name='content'></textarea>
		</div>
		<div class="form-group">
			<label>글쓴이</label><input class="form-control" name='writer' value='<sec:authentication property="principal.username"/>'readonly>
		</div>
		<button type="submit" class="btn btn-default">글쓰기</button>
		<button type="reset" class="btn btn-default">초기화</button>
	</form>
	</div>
</div>
</div>
<div class="col-lg-12">
<div class="panel panel-default">
<div class="panel-heading">관련사진 업로드</div>
<!-- /.panel-heading -->
<div class="form-group uploadDiv">
<input type="file" name='uploadFile' >
</div>
<div class='uploadResult'>
<ul>

</ul>
</div>





</div>
</div>
</div>
</div>
</div>
</section>
</div>
</div>
<%@include file="../includes/inner.jsp"%>
</div>
<script>
$(document).ready(function(e){
	var regex = new RegExp("(.*?)\.(png|bmp|dib|jpg|jpeg|jpe|jfif|gif|tif|tiff|png|heic)$");
	var maxSize = 5242880;//5mb
	var formObj = $("form[role='form']");
	var csrfHeaderName="${_csrf.headerName}"
	var csrfTokenValue="${_csrf.token}"
	
	
	//파일용량 초과 
	function checkExtension(fileName,fileSize){
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과")
			return false;
			
		}
		if(regex.test(fileName)){
			return true;
		}
		alert("해당 종류의 파일은 업로드 할 수 없습니다.")
		return false;
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
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data: formData,
			type: 'POST',
			dataType : 'json',
			success: function(result){
				console.log(result);
				showUploadResult(result);// 업로드 결과 처리 함수
			}
		});
		
		
	});
		
	function showUploadResult(uploadResultArr){
		if(!uploadResultArr || uploadResultArr.length ==0){return;}
		var uploadUL = $(".uploadResult ul");
		var str = "";
		$(uploadResultArr).each(function(i, obj){
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
			
				str +="<span>업로드 불가 파일</span>"
				
			
			}
		});
		uploadUL.append(str);
	}
	
	
	$(".uploadResult").on("click","button", function(e){
		console.log("delete file");
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		var targetLi = $(this).closest("li")	
	$.ajax({
		url: '/deleteFile',
		data:{fileName:targetFile,type:type},
		beforeSend: function(xhr){
			xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
		},
		dataType:'text',
		type:'POST',
		success: function(result){
			alert(result);
			targetLi.remove();
		}
	})	
	
	});
	
	
	
	$("button[type='submit']").on("click", function(e){
		e.preventDefault();
		console.log("submit clicked");
		var str = "";
		$(".uploadResult ul li").each(function(i, obj){
			var jobj= $(obj);
			
			console.dir(jobj);
			
			str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
			
			
		});
		formObj.append(str).submit();
		
		
		
	});
	

	
});

</script>

</body>
</html>
