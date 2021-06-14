<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="false" %>
<!DOCTYPE HTML>
<!--
	Editorial by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>YNEWS PAGE</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="/resources/assets/css/main.css" />
	</head>
	<body class="is-preload">

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Main -->
					<div id="main">
						<div class="inner">

							<!-- Header -->
								<header id="header">
									<a href="board/list" class="logo"><strong>YNEWS</strong> PAGE</a>
									<ul class="icons">
								<li><a href="http://www.twitter.com" class="icon brands fa-twitter"><span class="label">Twitter</span></a></li>
										<li><a href="http://www.facebook.com" class="icon brands fa-facebook-f"><span class="label">Facebook</span></a></li>
										<li><a href="http://www.instagram.com" class="icon brands fa-instagram"><span class="label">Instagram</span></a></li>
									</ul>
								</header>

							<!-- Banner -->
								<section id="banner">
								<span class="image object">
										<a href="#" ><img src="/resources/images/news1.jpg" alt="" /></a>
									</span>
									<div class="content">
										<header>
											<a href="#"><h1>코로나19 어제 525명 신규 확진…<br />
											</h1></a>
											<p>유영규 기자</p>
										</header>
										<a href="#"><p>중앙방역대책본부는 오늘 0시 기준 코로나19 신규 확진자가 525명이라고 밝혔습니다. 신규 확진자는 어제 574명 보다 49명 줄어 이틀 연속 500명 대를 유지했습니다. 감염경로는 국내 발생 509....</p>
										</a>
										
									</div>
									
								</section>
						
							<!-- Section -->
								<section>
									<header> 
									<div id="gisagul">
									<div id="gisadiv">
									<h2 id="gisa"> 코로나 관련 기사 </h2>
									</div>
									<div id="jacksungdiv">
										<button id='regBtn' type='button' class="button alignright">글쓰기</button>
										</div>
										</div>
									</header>
									<div class="posts">
									<c:forEach items="${list2}" var="board">
										<article>
											<a class="move image" href='<c:out value="${board.bno}"/>'><img src="/resources/images/pic01.jpg" alt="" /></a>
											<h3>[코로나]<a class="move" href='<c:out value="${board.bno}"/>'><c:out value="${board.title}" /></a></h3>
											<p><a class="move" href='<c:out value="${board.bno}"/>'> <c:out value="${board.content}"/></a></p>
											
										</article>
										</c:forEach>
									
									</div>
								</section>
	<form id='actionForm' action="/board/covid" method='get'>
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
					<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
					<input type="hidden" name='type' value='<c:out value="${pageMaker.cri.type }"/>'>
					<input type="hidden" name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'>	 
						
						 
						 
					<div class='pull-right'>
						<ul class="pagination">
							<c:if test="${pageMaker.prev}">	<!--이전페이지 누를수 잇는 버튼 pagedto에 의해서 0 이하는 나오지 않음  -->
								<li class="paginate_button previous"><a			
									href="${pageMaker.startPage-1}">previous</a></li> <!-- 이전페이지라서 -1임  -->
							</c:if>
							<c:forEach var="num" begin="${pageMaker.startPage}"
								end="${pageMaker.endPage}">
								<li
									class='paginate_button ${pageMaker.cri.pageNum == num?"active":""}'>
									<a href="${num}">${num}</a>
								</li>
							</c:forEach>
							<c:if test="${pageMaker.next}">
								<li class="paginate_button next"><a
									href="${pageMaker.endPage +1}">Next</a></li> <!-- 다음페이지라서 +1임  -->
							</c:if>

						</ul>
					</div>
				</form>
						</div>
					</div>
						<%@include file="../includes/inner.jsp"%>
					</div>
					
					


<!--모달끝  -->
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						var result = '<c:out value="${result}"/>';
						checkModal(result);
						history.replaceState({}, null, null);

						function checkModal(result) {
							if (result === '' || history.state) {
								return;
							}
							if (parseInt(result) > 0) {
								$(".modal-body").html(
										"게시글 " + parseInt(result)
												+ "번이 등록되었습니다");
							}
							$("#myModal").modal("show");
						}
						$("#regBtn").on("click", function() {
							self.location = "/board/register";

						});
						var actionForm = $("#actionForm");

						$(".paginate_button a").on(
								"click",
								function(e) { // 위의 기능을 무시하고 아래 2개 e를 진행시켜
									e.preventDefault();
									console.log('click');
									actionForm.find("input[name='pageNum']")
											.val($(this).attr("href")); //하나밖에 쓰지않으면 this 필요없지만 여러개가 있게 되면
									actionForm.submit(); //사용자가 선택한것을 나타내는것

								});
						$(".move")
								.on(
										"click",
										function(e) {
											e.preventDefault();
											actionForm
													.append("<input type='hidden' name='bno' value='"
															+ $(this).attr(
																	"href")
															+ "'>");
											actionForm.attr("action",
													"/board/get");
											actionForm.submit();
										});
						var searchForm = $("#searchForm");

						$("#searchForm button").on(
								"click",
								function(e) {
									if (!searchForm.find("option:selected")
											.val()) {
										alert("검색 종류를 선택하세요");
										return false;
									}
									if (!searchForm.find(
											"input[name='keyword']").val()) {
										alert("키워드를 입력하세요");
										return false;
									}
									searchForm.find("input[name='pageNum']")
											.val("1");
									e.preventDefault();
									searchForm.submit();
								})

					});
</script>
</body>


</html>





