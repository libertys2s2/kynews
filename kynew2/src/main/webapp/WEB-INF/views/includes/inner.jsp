<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

    <meta charset="utf-8">
			<!-- Sidebar --> 
					<div id="sidebar">
						<div class="inner">
						<header>
						<a href="/board/list" class="logo"><strong>YNEWS</strong> PAGE</a>
</header>
							<!-- Search -->
								<section id="search" class="alt">
									<form id='searchForm' action="/board/list" method='get'>
					<select name='type'>
						<option value=""
							<c:out value="${pageMaker.cri.type == null? 'selected':''}"/>>--</option>
						<!--삼항 연산자  -->
						<option value="T"
							<c:out value="${pageMaker.cri.type == 'T'? 'selected':''}"/>>제목</option>
						<option value="C"
							<c:out value="${pageMaker.cri.type == 'C'? 'selected':''}"/>>내용</option>
						<option value="W"
							<c:out value="${pageMaker.cri.type == 'W'? 'selected':''}"/>>작성자</option>
						<option value="TC"
							<c:out value="${pageMaker.cri.type == 'TC'? 'selected':''}"/>>제목
							OR 내용</option>
						<option value="TW"
							<c:out value="${pageMaker.cri.type == 'TW'? 'selected':''}"/>>제목
							OR 작성자</option>
						<option value="TWC"
							<c:out value="${pageMaker.cri.type == 'TWC'? 'selected':''}"/>>제목
							OR 내용 OR 작성자</option>
					</select> <input type="text" name='keyword'
						value='<c:out value="${pageMaker.cri.keyword }"/>' />
					<input type="hidden" name="pageNum"
						value='<c:out value="${pageMaker.cri.pageNum }"/>' /> <input
						type="hidden" name="amount"
						value='<c:out value="${pageMaker.cri.amount }"/>' />
					<button class="btn btn-default">Search</button>
				</form>
								</section>

							<!-- Menu -->
								<nav id="menu">
									<header class="major">
										<h2>Menu</h2>
										<sec:authorize access="isAuthenticated()">
										<label><sec:authentication property="principal.username"/>님 어서오십시오</label>
										<a href ="/customLogout" class ="button primary">로그아웃</a>
										<a href ="/member/memberch" class="button primary">회원정보 변경</a>
										</sec:authorize>
										<sec:authorize access="isAnonymous()">
										<a href ="/customLogin" class="button primary ">로그인</a> &nbsp;&nbsp;
										<a href ="/member/signup" class="button primary">  &nbsp;&nbsp;회원 가입</a>
										</sec:authorize>
									</header>
									<ul>
										<li><a href="/board/list">Homepage</a></li>
										<li><a href="/board/notice">공지</a></li>
										<li><a href="/board/covid">코로나</a></li>
										<li><a href="/board/sports">스포츠뉴스</a></li>
										<li><a href="/board/economy">경제뉴스</a></li>
										<li>
											<a href="/board/IT">it뉴스</a>
							<!-- 				class="opener"<ul>
												<li><a href="#">전국 추이</a></li>
												<li><a href="#">Ipsum Adipiscing</a></li>
												<li><a href="#">Tempus Magna</a></li>
												<li><a href="#">Feugiat Veroeros</a></li>
											</ul> -->
										</li>
							
									</ul>
								</nav>


							<!-- Section -->
								<section>
									<header class="major">
										<h2>Get in touch</h2>
									</header>
									<p></p>
									<ul class="contact">
										<li class="icon solid fa-envelope"><a href="#">justin221@naver.com</a></li>
										<li class="icon solid fa-phone">010 2912 1108</li>
										<li class="icon solid fa-home">울산광역시 남구 삼산중로100번길 26 케이엠빌딩 1~4층 <br />
										울산광역시 남구 삼산동 1570-1</li>
									</ul>
								</section>

							<!-- Footer -->
								<footer id="footer">
									<p class="copyright">&copy;  KYNEWS PAGE</p>
								</footer>

						</div>
					</div>

			</div>

		<!-- Scripts -->
			<script src="/resources/assets/js/jquery.min.js"></script>
			<script src="/resources/assets/js/browser.min.js"></script>
			<script src="/resources/assets/js/breakpoints.min.js"></script>
			<script src="/resources/assets/js/util.js"></script>
			<script src="/resources/assets/js/main.js"></script>
			<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
			
			<script type="text/javascript">
	$(document)
			.ready(function() {
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
			}
