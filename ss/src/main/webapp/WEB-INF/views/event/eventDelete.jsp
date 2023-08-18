<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%
// 게시판 타입이 선택되었는지 확인후, 기본값 셋팅
String type = request.getParameter("Ltype");
if( type == null || type.equals("") )
{
	type = "TT"; 			// 전체게시판으로 셋팅
}

// 페이지번호가 선택되었는지, 확인하고, 없으면 1페이지로 가정
/* String curPage = request.getParameter("page");
int pageNo = 1;
try { pageNo = Integer.parseInt(curPage); }catch(Exception e) {}
System.out.println("페이지 번호 : " + pageNo);
 */
// EventVO vo = new EventVO();
// 선택된 게시판의 목록을 만들기 위해 listDAO를 생성하고, 게시판 종류를 인자로 넘긴다
/* EventDAO ed = new EventDAO("LType", type);
// 선택된 게시글의 총 개수를 읽어옴 ============================================================
int total = ed.GetTotal();
System.out.println("선택된 게시판의 게시글 전체 개수 : " + total);
// 선택된 게시글의 총 게시글 수와, 현재 페이지 번호로 페이징 객체를 생성
paging pager = new paging();
pager.SetTotal(total, pageNo);
// 선택된 게시판의 선택된 페이지의 게시글 목록을 생성======================= */
%>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>

<%
// 파라메타로 조회할 게시글 번호를 받는다
/* String no = request.getParameter("no");
// 넘어온 게시글 번호가 없으면 메인으로 보낸다
if( no == null ) { response.sendRedirect("index.jsp"); return; }
// 게시글을 조회하기 위한 객체를 선언한다
EventDAO ed = new EventDAO();  */
// 파라메타로 넘어온 게시글 번호로 게시글을 조회
/* int bNo = 0;
try
{
	bNo = Integer.parseInt(no);	// 문자열 no를 정수로
	bVO = bDAO.Read(bNo, true);		// bNo를 인자로, 조회수를 증가시키는 read()호출
}catch(Exception e)
{
	System.out.println(e);
	response.sendRedirect("index.jsp");
	return;
} */
// 본문에 포함된 엔터문자를 <br>태그로 변경한다
/* vo.setEvent_content(vo.getEvent_content().replace("\n", "<br>")); */
%>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>

<style>
		.title {
	        text-decoration: none;
	    }
	
	    .title:hover {
	        text-decoration: underline;
	    }
		 a {
        color: black;
        
    	}
		.bd-sidebar {
		  position: sticky;
		  top: 4rem;
		  height: calc(100vh - 4rem);
		  background: #eee;
		  border-right: 1px solid rgba(0,0,0,.1);
		  max-width: 220px;
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
		</style>
<!-- 메인 내용 작성 영역 =========================================== -->
<div class="container-fluid">
	<div class="row flex-nowrap" >
		<main class="col-6 offset-2 py-md-1 pl-md-5 bd-content board-article border-end border-start position: fixed;" style="min-height: 100vh;" role="main">		
			<article class="containe-fluid board-article">
				<div class="row">
				<div class="col-sm-0 col-lg-1"></div>
					<div class="col-sm-12 col-lg-10">
						<div class="dialog card py-3 ">
							<div class="card-block mx-2">
								<h4 class="card-title mx-4">게시물 삭제</h4>
								<h6 class="card-subtitle text-muted mx-4 ">
								${ev.event_title}
								</h6>
								<form action="eventDelete.do" method="POST">
									<input type="hidden" name="_csrf" value="guu3y5pg-4oj0awwx063mGNGTPgCiYRuSsGI">
									<div class="row mx-4 py-3">
										삭제된 글은 복구할 수 없습니다.
									</div>	
									<div class="btns d-flex justify-content-end px-4">
										<input type="hidden" name="event_number" value="${ev.event_number}">
										<button class="btn btn-danger float-right">
										<span class="ion-trash-b">
										삭제
										</span>
										</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				<div class="col-sm-0 col-lg-1"></div>
				</div>
			</article>
		</main>
		
	</div>	
</div>	

<!-- 메인 내용 작성 영역 =========================================== -->
	<p class="text-center">
			<small class="text-muted" data-datetime="2023-05-23T05:39:45.029Z" data-format="" data-localdate=""></small>
	</p>
	
<%@ include file="../include/footer.jsp" %>