<%@page import="com.ss.demo.domain.EventVO"%>
<%@page import="com.ss.demo.domain.PageMaker"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>
<%@ page import="java.util.List" %>
<%
	// 게시판 타입이 선택되었는지 확인후, 기본값 셋팅
String type = request.getParameter("type");
if( type == null || type.equals("") )
{
	type = "TT"; 			// 전체게시판으로 셋팅
}

EventVO vo = new EventVO();

// 본문에 포함된 엔터문자를 <br>태그로 변경한다
if (vo.getEvent_content() != null) {
	vo.setEvent_content(vo.getEvent_content().replace("\n", "<br>"));
}
PageMaker pageMaker = (PageMaker)request.getAttribute("pageMaker");
%>
<script>
$(document).ready(function() {
  // 초기에 보여질 아이템 개수 설정
  var itemsToShow = 2;
  
  // 더보기 버튼을 클릭할 때마다 추가로 보여질 아이템 개수 설정
  var itemsToAdd = 2;
  
  // 모든 lead 아이템을 숨깁니다.
  $('.lead').hide();
  
  // 초기에 일부 아이템만 보이도록 설정
  $('.lead:lt(' + itemsToShow + ')').show();
  
  // 더보기 버튼을 클릭할 때 이벤트 처리
  $('#load').on('click', function(e) {
    e.preventDefault();
    
    // 보이도록 할 아이템의 인덱스 범위 계산
    var startIndex = itemsToShow;
    var endIndex = itemsToShow + itemsToAdd;
    
    // 인덱스 범위에 해당하는 아이템 보이기
    $('.lead:lt(' + endIndex + '):lt(' + endIndex + ')').show();
    
    // 보여진 아이템 개수 업데이트
    itemsToShow += itemsToAdd;
    
    // 더보기 버튼 숨기기 (만약 모든 아이템을 다 보여줬을 경우)
    if (itemsToShow >= $('.lead').length) {
      $('#load').hide();
    }
  });
});
</script>
<style type="text/css">
/* CSS 스타일 */
	a {
		text-decoration: none;
		color: black;
	}
	body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	}
	.bd-sidebar {
	  position: sticky;
	  top: 0rem;
	  height: calc(100vh - 0rem);
	  background: #eee;
	
	  display: flex;
	  padding: 0;
	  overflow-y: hidden;
	  flex-direction: column;
	}
	.bd-sidebar-body {
	  height: 100%;
	  overflow-y: auto;
	  display: block;
	}
	.bd-sidebar-body .nav {
	  display: block;
	}
	.bd-sidebar-body .nav>li>a {
	  display: block;
	  padding: .25rem 1.5rem;
	  font-size: 90%;
	}
	.bd-sidebar-footer {
	  padding: 1rem;
	  background: #ddd;
	}
	
	
	.fixed-sidebar {
	  position: fixed;
	  top: 0;
	  left: 0;
	  width: 280px;
	  height: 100vh; /* or any other appropriate height */
	  overflow-y: auto;
	}
	
	.container {
	margin: 20px auto;
	max-width: 960px;
	padding: 0 20px;
	}
	.restaurant-item {
	border: none; /* 회색 선 제거 */
	margin-bottom: 20px;
	padding: 20px;
	display: flex;
	border-bottom: 1px solid #ddd; /* 바닥선만 추가 */
	}
	.restaurant-thumbnail {
	flex: 0 0 auto;
	margin-right: 20px;
	}
	.restaurant-thumbnail img {
	width: 250px;
	height: 250px;
	object-fit: cover;
	}
	.restaurant-info {
	flex: 1 1 auto;
	}
	.restaurant-title {
	font-size: 24px;
	font-weight: bold;
	margin-bottom: 10px;
	}
	.restaurant-title span.mirai {
	font-family: "미라이", sans-serif;
	color: #ff7f00;
	font-size: 30px;
	
	margin-left: 10px;
	}
	.restaurant-rating {
	font-size: 16px;
	margin-bottom: 10px;
	}
	.restaurant-address {
	font-size: 10pt;
	color: silver;
	}
	.restaurant-description {
	font-size: 16px;
	line-height: 1.5;
	max-height: 4.5em;
	overflow: hidden;
	position: relative;
	}
	.restaurant-description::after {
	content: "";
	position: absolute;
	bottom: 0;
	right: 0;
	background: linear-gradient(to right, rgba(255, 255, 255, 0), rgba(255, 255, 255, 1) 70%);
	width: 100%;
	height: 1.5em;
	}
	.restaurant-more {
	color: #ff7f00;
	cursor: pointer;
	position: absolute;
	bottom: 0;
	right: 0;
	margin: 0;
	padding: 0;
	background: none;
	border: none;
	font-size: 16px;
	line-height: 1;
	}
	.user-info {
	display: flex;
	align-items: center;
	margin-bottom: 10px;
	}
	.user-thumbnail {
	width: 40px;
	height: 40px;
	margin-right: 10px;
	border-radius: 50%;
	overflow: hidden;
	}
	.user-thumbnail img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	}
	.user-nickname {
	
	font-size: 14px;
	font-weight: bold;
	}
	.restaurant-favorite-btn{
    width: 60px;
    height: 60px;
    background-color: #ff7f00;
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 35px;
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
  	}
  	
</style>
<body>
	<div class="container-fluid offset-2" style="max-width: 1280px;">
		<div class="row">
			<div class="btns-board border-top d-flex justify-content-between px-3 border-bottom bg-light">					
				<a class="float-right" >
					<span>
						<c:if test="${ not empty login}">
						유저: ${login.uName} 권한:${login.uType}
						</c:if>
					</span>
				</a>
				<div class="float-right ">
					
						<%
							if( login != null )
							{
								%><button type="button" class="btn btn-outline-secondary" style="--bs-btn-padding-y: auto; --bs-btn-padding-x: auto; --bs-btn-font-size: .15rem;">
								<a href="eventWrite.do?type=<%= type %>" class=" float-right btn btn-sm btn-arca btn-arca-article-write" title="글쓰기">
									<span class="ion-compose">
									</span>
									&nbsp;글쓰기
								</a><%
							}
						%>
				 	</button>
				</div>
			</div>	
		<!-- 사이드바 부문 ======================================================================= -->
		
			<div class="bd-sidebar d-flex flex-column flex-shrink-0 p-3 bg-light " style="width: 280px;">
				<a href="/" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none offset-3">
					<span class="fs-4"  >지역별 구분</span>
				</a>
				<hr>
				<ul class="nav nav-pills flex-column mb-auto">
					<% String activeTab = type != null && !type.equals("") ? type : "TT"; %>
					<%
						String boardTitle = "";
					switch (type)
					{
						case "TT":
					        boardTitle = "전체";
					        activeTab = "TT";
					        break;
					    case "GG":
					        boardTitle = "경기";
					        activeTab = "GG";
					        break;
					    case "GW":
					        boardTitle = "강원";
					        activeTab = "GW";
					        break;
					    case "CB":
					        boardTitle = "충북";
					        activeTab = "CB";
					        break;
					    case "CN":
					        boardTitle = "충남";
					        activeTab = "CN";
					        break;
					    case "GB":
					        boardTitle = "경북";
					        activeTab = "GB";
					        break;
					    case "GN":
					        boardTitle = "경남";
					        activeTab = "GN";
					        break;
					    case "JB":
					        boardTitle = "전북";
					        activeTab = "JB";
					        break;
					    case "JN":
					        boardTitle = "전남";
					        activeTab = "JN";
					        break;
					    case "JJ":
					        boardTitle = "제주";
					        activeTab = "JJ";
					        break;
					}
							
							%>
					<li class="nav-item" >
						<a href="eventMain.do?type=TT" class="nav-link link-dark  <%= activeTab.equals("TT") ? "active" : "" %>"  style="text-align:center;">
							
							전체
						</a>
					</li>
					<li>
						<a href="eventMain.do?type=GG" class="nav-link link-dark <%= activeTab.equals("GG") ? "active" : "" %>" style="text-align:center;">
							
							경기
						</a>
					</li>
					<li>
						<a href="eventMain.do?type=GW" class="nav-link link-dark <%= activeTab.equals("GW") ? "active" : "" %>" style="text-align:center;">
							
							강원
						</a>
					</li>
					<li>
						<a href="eventMain.do?type=CB" class="nav-link link-dark <%= activeTab.equals("CB") ? "active" : "" %>" style="text-align:center;">
							
							충북
						</a>
					</li>
					<li>
						<a href="eventMain.do?type=CN" class="nav-link link-dark <%= activeTab.equals("CN") ? "active" : "" %>" style="text-align:center;">
							
							충남
						</a>
					</li>
					<li>
						<a href="eventMain.do?type=GB" class="nav-link link-dark <%= activeTab.equals("GB") ? "active" : "" %>" style="text-align:center;">
							
							경북
						</a>
					</li>
					<li>
						<a href="eventMain.do?type=GN" class="nav-link link-dark <%= activeTab.equals("GN") ? "active" : "" %>" style="text-align:center;">
							
							경남
						</a>
					</li>
					<li>
						<a href="eventMain.do?type=JB" class="nav-link link-dark <%= activeTab.equals("JB") ? "active" : "" %>" style="text-align:center;">
							
							전북
						</a>
					</li>
					<li>
						<a href="eventMain.do?type=JN" class="nav-link link-dark <%= activeTab.equals("JN") ? "active" : "" %>" style="text-align:center;">
							전남
						</a>
					</li>
					<li>
						<a href="eventMain.do?type=JJ" class="nav-link link-dark <%= activeTab.equals("JJ") ? "active" : "" %>" style="text-align:center;">
							
							제주
						</a>
					</li>					
				</ul>
				<!-- <div class="modal fade" id="exampleModalCenteredScrollable" tabindex="-1" aria-labelledby="exampleModalCenteredScrollableLabel" aria-hidden="true">
					  <div class="modal-dialog modal-dialog-scrollable modal-xl">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="exampleModalCenteredScrollableLabel">리뷰 더보기</h5>
			
					      </div>
					      <div class="modal-body">
					        모달 내용을 이곳에 추가
					   		ㅁㄴㅇㅁㄴㅇ
					    	</div>
					    </div>
					  </div>
					</div>
					<button type="button" class="btn btn-lg btn-link float-right" data-bs-toggle="modal" data-bs-target="#exampleModalCenteredScrollable">
					more
					</button>
				 -->
								
			</div>
			<!-- 사이드바 부문 ======================================================================= -->
			
			
			<!-- 메인 부문 ======================================================================= -->
			<div class="tab-content container-fluid ml-2 col-md-8" >
			<c:forEach items="${list}" var="event" begin="0" end="5">
				
				
				<div class="container tab-pane fade show p-0 active" style="margin-right: 18rem;">
					<div class="restaurant-item" >
						<div class="restaurant-thumbnail">							
							<c:choose>
								<c:when test="${empty event.attach_logical_name}">
									<img onclick="location.href ='<%=request.getContextPath() %>/event/eventView.do?event_number=${event.event_number}'" src="https://mp-seoul-image-production-s3.mangoplate.com/406312/1763517_1635134765363_16478?fit=around|738:738&crop=738:738;*,*&output-format=jpg&output-quality=80" alt="맛집 썸네일">
								</c:when>
								<c:otherwise>
									<img src="<%=request.getContextPath() %>/resources/upload/${event.attach_physical_name}" onclick="location.href ='<%=request.getContextPath() %>/event/eventView.do?event_number=${event.event_number}'">
								</c:otherwise>
							</c:choose>
						</div>
						
						<div class="restaurant-info">
							<h2 class="restaurant-title"><span>${event.event_number}. </span><span>${event.event_title} </span><span class="mirai">4.7</span>
							</h2>
							<div class="user-info">
								<div class="user-thumbnail">
								
									<img src="https://slp-
									statics.astockcdn.net/static_assets/staging/23summer/home/kr/featured-contributors/card-3.jpg?
									
									width=580&format=webp" alt="사용자 썸네일">
								</div>
								<div class="user-nickname">세이콩</div>
								<div class="button-container offset-8">
									<button class="restaurant-favorite-btn" onclick="handleFavoriteButtonClick(this);">❤</button>
									<p align="center"  style="font-size: 15px; color: #ff1493;">좋아요</p>
								</div>
							</div>
							<p class="restaurant-address" style="color: silver;">${event.event_local}</p>
							<p class="restaurant-description">${event.event_content}</p>
							<p class="restaurant-address" style="color: silver; text-align:right;">
							<a href="<%=request.getContextPath()%>/event/eventView.do?event_number=${event.event_number}">상세보기</a></p>
						</div>
					</div>
				</div>
			</c:forEach>		
				
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">
				        <%-- 이전 페이지 링크 생성 --%>
				        <li class="page-item">
<%-- 				        <% if (pageMaker.isPrev()){ %> --%>
				            <a class="page-link" href="<%=request.getContextPath()%>/event/eventMain.do?page=<%=pageMaker.getStartPage()-1%>">Previous</a>
<%-- 						<%} %> --%>
				        </li>
						<% 
						for(int i = pageMaker.getStartPage();i<=pageMaker.getEndPage();i++) {
						%>
						<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath()%>/event/eventMain.do?page=<%=i%>">
							<%=i %>
						</a>
						</li>
				        <%
				        } 
				        %>
				        <%-- 다음 페이지 링크 생성 --%>
				        <li class="page-item">
<%-- 				        <%if(pageMaker.isNext()&&pageMaker.getEndPage()>0 ){ %> --%>
				            <a class="page-link" href="<%=request.getContextPath()%>/event/eventMain.do?page=<%=pageMaker.getEndPage()+1%>">Next</a>
<%-- 				        <% } %> --%>
				        </li>
					</ul>
					<br>
				</nav>
			</div>
				
			</div>			
				<!-- 메인 부문 ======================================================================= -->	
		</div>
	</div>


<%@ include file="../include/footer.jsp" %>