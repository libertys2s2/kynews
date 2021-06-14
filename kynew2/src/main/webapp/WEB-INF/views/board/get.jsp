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

							<!-- Header -->
								<header id="header">
									<a href="/board/list" class="logo"><strong>YNEWS</strong> PAGE</a>
									<ul class="icons">
										<li><a href="http://www.twitter.com" class="icon brands fa-twitter"><span class="label">Twitter</span></a></li>
										<li><a href="http://www.facebook.com" class="icon brands fa-facebook-f"><span class="label">Facebook</span></a></li>
										<li><a href="http://www.instagram.com" class="icon brands fa-instagram"><span class="label">Instagram</span></a></li>									
									</ul>
								</header>

							<!-- Content -->
								<section>
									<header class="main">
										<h1><c:out value="${board.title}"/></h1>
										<label>${board.writer}기자</label>
									</header>

	<hr/>								
									
									<div class='uploadResult'>

<span class="image main"><img src="/resources/images/YNEWS.png" alt="" /></span></li>

</div>

									<p><c:out value="${board.content}"/></p>
<br>
<br>
								<sec:authentication property="principal" var="pinfo"/>
		<sec:authorize access="isAuthenticated()">
		<c:if test="${pinfo.username eq board.writer }">
		<button data-oper="modify" class="btn btn-default" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">수정</button>
		<!-- <button data-oper="remove" class="btn btn-danger" >삭제</button> -->
		</c:if>
		</sec:authorize>
		<button data-oper="list" class="btn btn-default" onclick="location.href='/board/list'">목록</button>
								<hr class="major" />

								
								
								<div class="panel-body">
								<h4 class="modal-title" id="myModalLabel">댓글</h4>

<ul class="chat">
<!--  start reply -->
<li class= "left clearfix" data-rno='12'>

<div>

<div class="header">
<strong class="primary-font"></strong>
<small class="pull-right text-muted"></small>
</div>
<p></p>
</div>
</li>
</ul>
<div class="panel-footer">


</div>

 
</div>

<hr/>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> -->
                                            <h4 class="modal-title" id="myModalLabel">댓글작성</h4>
                                        </div>
                                        <div class="modal-body">
                                     
                                        <div class="form-group">
                                       
		<sec:authorize access="isAuthenticated()">
                                        <c:choose>
                                        <c:when test="${!empty pinfo.username}">
                                        <label >작성자 :<sec:authentication property="principal.username"/></label>
                                        <input type="hidden" name="replyer" value="<sec:authentication property="principal.username"/>">
                                        </c:when>
                                        <c:when test="${empty pinfo.username}">
                                        </c:when>
                                        </c:choose>
                                        </sec:authorize>
                                       
                                        </div>
                                         <div class="form-group">
                                        <input class="form-control" name='reply' placeholder='댓글을 작성해주세요'>
                                        </div>
                                       </div>
                                        <div class="modal-footer">
                                        <sec:authorize access="isAuthenticated()">           
                                        <c:if test="${!empty pinfo.username}">
                                            <button  id="modalregisterbtn" type="button" class="btn btn-primary">작성</button>
                                            </c:if>
                                            </sec:authorize>
                                            <sec:authorize access="isAnonymous()">
                                             <label>로그인후 작성해주세요.</label>
                                             </sec:authorize>
                                        </div>
                                    </div>
                                        </div>
                                <!-- /.modal-dialog -->
                            </div>










 
								</section>

						</div>
					</div>

<%@include file="../includes/inner.jsp"%>

			</div>

 <form id='operForm' action='/board/modify' method="post">
<input type="hidden" id="bno" name="bno" value="<c:out value='${board.bno}'/>">
<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
<input type='hidden' name='type' value='<c:out value="${cri.type}"/>'>
 </form> 
	</body>
	
	   
<!-- Bootstrap Core JavaScript -->
    <script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
    <!-- Metis Menu Plugin JavaScript -->
    <script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- DataTables JavaScript -->
    <script src="/resources/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="/resources/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
    <script src="/resources/vendor/datatables-responsive/dataTables.responsive.js"></script>
	<script src="/resources/vendor/bootstrap/js/bootstrap.js"></script>
	
<script type="text/javascript">
$(document).ready(function(){
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUL = $(".chat")
	var operForm = $("#operForm");
	var formObj = $("form");
	
	showList(1); 		//showlist를 뿌려주
	
	 // panel footer 댓글 페이지 번호 출력
	
	 var pageNum= 1;
	 var replyPageFooter = $(".panel-footer");
	 function showReplyPage(replyCnt){
		 var endNum = Math.ceil(pageNum/10.0)*10;
		 var startNum = endNum-9;
		 
		 var prev = startNum !=1;
		 var next = false;
		 
		 if(endNum * 10 >= replyCnt){
			 endNum = Math.ceil(replyCnt/10.0);
		 }
		 if(endNum * 10 < replyCnt){
			 next = true; 
		 }
		 var str = "<ul class='pagination pull-right'>";
		 if(prev){
			 str += "<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>previous</a></li>";
		 }
			 for(var i = startNum; i <= endNum; i++){
				 var active = pageNum == i ? "active":"";
				str+="<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>";
			 }

			 
			 if(next){
					str+="<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>Next</a></li>";
				}
				str += "</ul></div>";
				console.log(str);
				replyPageFooter.html(str);

	 }
	 replyPageFooter.on("click","li a", function(e){
		e.preventDefault();
		console.log("page click");
		
		
		var targetPageNum = $(this).attr("href");
		console.log("targetPageNum:"+ targetPageNum);
		pageNum = targetPageNum;
		showList(pageNum);
		
		 
	 });
	 
	 // 댓글페이징 끝
	
	
	
	
	$("button[data-oper='modify']").on("click",function(e){
		operForm.attr("action","/board/modify").submit();
		
	});
	$("button[data-oper='list']").on("click",function(e){
	operForm.find("#bno").remove();
	operForm.attr("action","/board/list")
	operForm.submit();
	});
	$("button[data-oper='remove']").on("click",function(e){
		operForm.attr("method","post");
		operForm.attr("action","/board/remove").submit();
		alert("삭제되었습니다.")
		
	});
	

	
	
	
	function showList(page){ // 댓글 출력
		
		console.log("show list" + page);

		replyService.getList({bno:bnoValue, page:page||1}, function(replyCnt,list){   // page: page||1
			console.log("replyCnt:"+ replyCnt);
			console.log("list:"+ list);
			console.log(list);
			
			if(page == -1){
				pageNum = Math.ceil(replyCnt/10.0);
				showList(pageNum);
				return;
			}
			
			var str="";
			if(list == null || list.length == 0){					
				return;
			}
			for(var i = 0, len = list.length || 0; i<len; i++){
		 	 	str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
				str +="  <div><div class='header'><strong class='primary-font'>작성자:    "+list[i].replyer+"</strong>";
				str +="   <small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"    </small><button  class='small' id='removebtn' name='removebtn' data-oper2='"+list[i].replyer+"' data-oper='"+list[i].rno+"' >x</button></div>";
				str +="		<p>"+list[i].reply+"</p></div></li>";
				
			}
		
			replyUL.html(str);
			
			showReplyPage(replyCnt);
			 
		 });

		}
	var modal = $(".modal");
	var modalInputReply = modal.find("input[name='reply']");
	var modalInputReplyer = modal.find("input[name='replyer']");
	var modalInputReplyDate = modal.find("input[name='replyDate']");
	
	var modalmodbtn = $("#modalmodbtn");
	var modalremovebtn = $("#modalremovebtn");
	var modalregisterbtn = $("#modalregisterbtn");
		
		var replyer = null;
		<sec:authorize access="isAuthenticated()">
		replyer ='<sec:authentication property="principal.username"/>';
		</sec:authorize>
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue ="${_csrf.token}";
		
		$("#addReplyBtn").on("click", function(e){
			modal.find("input").val("");
			modal.find("input[name='replyer']").val(replyer);
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id !='modalclosebtn']").hide();
			
			modalregisterbtn.show();
			
			$(".modal").modal("show");
		});
		
		
		
		//ajax spring security header...
		$(document).ajaxSend(function (e,xhr,options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		})
		
		
		modalregisterbtn.on("click",function(e){
		var reply = {
				reply : modalInputReply.val(),
				replyer :modalInputReplyer.val(),
				bno:bnoValue
		};
		replyService.add(reply, function(result){
			alert(result);
			modal.find("input").val("");
			modal.modal("hide");
			showList(-1);			//showlist를 한번더 불러와라   // 댓글 페이징 이후 1 -> -1 
		});
		});
		
		
		//모달 모디파이 버튼
		modalmodbtn.on("click",function(e){
			var originalReplyer = modalInputReplyer.val()
			
			var reply = {rno:modal.data("rno"), reply: modalInputReply.val(), replyer: orignalReplyer};
			
			if(!replyer){
				alert("로그인후 수정이 가능 합니다")
				modal.modal("hide");
				return;
			}
			console.log("Original Replyer:"+ originalRelyer)
			
			if(replyer != originalReplyer){
				alert("자신이 작성한 댓글만 수정이 가능합니다.");
				modal.modal("hide");
				return;
				
			}
			
			replyService.update(reply, function(result){
				alert(result);
				modal.modal("hide");
				showList(pageNum);
				
			});
			
		});
		//모달 삭제버튼
		$(document).on("click","#removebtn",function(e){
			
			var rno = $("#removebtn").data("oper");
			
			alert(rno);
			
			console.log("RNO:"+ rno);
			console.log("REPLYER:"+ replyer)
			
			if(!replyer){
				alert("로그인후 삭제가 가능합니다.");
				return;
			}
			
			var originalReplyer =  $("#removebtn").data("oper2");
			var reply = $("#removebtn").data("oper2");
			alert(replyer);
			alert(originalReplyer);
			console.log("Original Replyer:"+ originalReplyer);
			
			if(replyer != originalReplyer){
				alert("자신이 작성한 댓글만 삭제가 가능합니다.")
			
				return;
				
			}
			
			replyService.remove(rno, originalReplyer, function(result){
				alert(result);
				showList(pageNum);
			});
		});
		(function(){ //조회화면 처리 
			var bno = '<c:out value="${board.bno}"/>';
			$.getJSON("/board/getAttachList",{bno: bno}, function(arr){
				console.log(arr);
				var str = "";
				$(arr).each(function(i,attach){
					//image type
					
					if(attach.fileType){
						var fileCallPath = encodeURIComponent( attach.uploadPath+"/"+attach.uuid+"_"+attach.fileName);
						str += "<div data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'></div>";
						str += "<img src='/display?fileName="+fileCallPath+"'>";
						str += "</div>";
						str += "</div>";
						}else{
						str +="<div data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data type='"+attach.fileType+"'></div>";
						str +="</div>";
					}
						
					});
				
					$(".uploadResult").html(str);
				
				
			}); // end getjson
		})();//end function 
		
		$(".uploadResult").on("click","li", function(e){
			console.log("view image");
			var liObj = $(this);
			
			var path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
			if(liObj.data("type")){
				showImage(path.replace(new RegExp(/\\/g),"/"));
			}else{
				//download
				self.location = "/download?fileName="+path
			}
			//
			
			
			
		});
		function showImage(fileCallPath){
			alert(fileCallPath);
			$(".bigPictureWrapper").css("display","flex").show();
			$(".bigPicture")
			.html("<img src ='/display?fileName="+fileCallPath+"'>")
			.animate({width:'100%',height: '100%'}, 1000);
		} //showimage end
		$(".bigPictureWrapper").on("click", function(e){
			$(".bigPicture").animate({width:'0%',height:'0%'}, 1000);
			setTimeout(function(){
				$('.bigPictureWrapper').hide();
			}, 1000);
			
		});
	
		
		
		
}); // ready function끝

</script>
</html>











