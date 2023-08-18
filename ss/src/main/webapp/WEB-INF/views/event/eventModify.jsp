<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@page import="com.ss.demo.domain.EventVO"%>
<%-- <%@page import="com.ss.demo.domain.EventDAO"%>  --%>
<%
// 로그인 정보를 세션에서 확인한 후
// 1. 로그인 정보가 없으면, 메인으로 돌려보냄
// 2. 로그인 정보가 있으면, 이 페이지를 사용자에게 노출시킴
/* if( loginVo == null )
{
//	response.sendRedirect("ss/event/eventView.do");		// 상세페이지로 돌려보냄
	response.sendRedirect("login.jsp");		// 로그인 화면으로 보냄
	return;
} */
// 파라메타를 통해 사용자가 글을 작성하려는 게시판이 어느것인지 판단하기 위해,
// 'type'이름으로 데이터를 받는다
	String type = request.getParameter("type");
// LType 변수를 request 파라미터에서 읽어옵니다.
String LType = request.getParameter("${vo.LType}");
if (LType == null) {
    LType = "TT"; // LType이 파라미터로 제공되지 않은 경우 기본값을 설정합니다.
} 

/* EventVO vo = new EventVO();
	EventVO vo = EventDAO.Read(uNo, false); 
	if( event_number == null || event_number.equals("") )
	{
		response.sendRedirect("index.jsp");		// 로그인 화면으로 보냄
		return;
	}
	String type = request.getParameter("type");
	if( type == null ) type = "TT";	
	EventDAO ed = new EventDAO();
	EventVO vo;
	// 파라메타로 넘어온 게시글 번호로 게시글을 조회
	int bNo = 0;
	try
	{
		event_number = Integer.parseInt(event_number);	// 문자열 no를 정수로
		vo = vo.Read(bNo, true);		// bNo를 인자로, 조회수를 증가시키는 read()호출
	}catch(Exception e)
	{
		System.out.println(e);
		response.sendRedirect("index.jsp");
		return;
	}
*/
//본문에 포함된 엔터문자를 <br>태그로 변경한다
/* if (vo.getEvent_content() != null) {
vo.setEvent_content(vo.getEvent_content().replace("<p>", ""));
vo.setEvent_content(vo.getEvent_content().replace("</p>", ""));
} */
%>

<script>
window.onload = function() { $("#event_title").focus(); }
</script>
<script>
  // 서머노트 초기화 함수
  $(document).ready(function() {
    $('#event_content').summernote();
  });

  // 폼 서브밋 이벤트 핸들러
  function submitForm() {
    // 서머노트에서 수정된 내용을 가져옴
    var modifiedContents = $('#event_content').summernote('code');
    // 수정된 내용을 hidden 필드에 설정
    $('#modifiedContents').val(modifiedContents);
    // 폼 서브밋
    document.modifyForm.submit();
  }
</script>
<script>
window.onload = function(){
	const openButton = document.getElementById("open-gallery-button");
	const modal = document.getElementById("gallery-modal");
	const closeButton = document.getElementById("close-button");

	openButton.addEventListener("click", () => {
	  modal.style.display = "block";
	  document.body.style.overflow = "hidden";
	});

	closeButton.addEventListener("click", () => {
	  modal.style.display = "none";
	  document.body.style.overflow = "auto";
	});

	window.addEventListener("click", (event) => {
	  if (event.target === modal) {
	    modal.style.display = "none";
	    document.body.style.overflow = "auto";
	  }
	});
}
</script>
<!-- <script src="./js/write.js"></script> -->
<body>
	<div class="container-fluid border-top">
		<div class="row flex-nowrap" >
			<main class="col-6 offset-3 py-md-1 pl-md-5 bd-content board-article border-end border-start" style="height: 100vh;" role="main">
				<article class="container-fluid">
					<form name="write" method="post" action="eventModify.do" onsubmit="return DoSubmit();" enctype="multipart/form-data" >	
						<input type="hidden" name="contentType" value="html">
						<div class="write-head border-top border-bottom py-md-1">
							글수정 | 작성자<%--  <%= loginVo.getuName() %> --%> <input type="hidden" name="uNo" id="uNo" value="1">
						</div>
						<div class="sub-row py-md-1">
						<span>글머리</span>
						<span>
							<input type="radio" class="btn-check" name="LType" id="success-outlined-TT" autocomplete="off" value="TT" <%= LType.equals("TT") ? "checked" : "" %>>								
							<label class="btn btn-light" for="success-outlined-TT">전체</label>								
						</span>
						<span>
							<input type="radio" class="btn-check" name="LType" id="success-outlined-GG" autocomplete="off" value="GG" <%= LType.equals("GG") ? "checked" : "" %>>								
							<label class="btn btn-light" for="success-outlined-GG">경기</label>								
						</span>
						<span>
							<input  type="radio" class="btn-check" name="LType" id="success-outlined-GW" autocomplete="off" value="GW" <%= LType.equals("GW") ? "checked" : "" %> >
							<label class="btn btn-light" for="success-outlined-GW">강원</label>
						</span>
						<span>
							<input type="radio" class="btn-check" name="LType" id="success-outlined-CB" autocomplete="off" value="CB" <%= LType.equals("CB") ? "checked" : "" %> >
							<label class="btn btn-light" for="success-outlined-CB">충북</label>
						</span>
						<span>
							<input type="radio" class="btn-check" name="LType" id="success-outlined-CN" autocomplete="off" value="CN" <%= LType.equals("CN") ? "checked" : "" %> >
							<label class="btn btn-light" for="success-outlined-CN">충남</label>
						</span>
						<span>
							<input type="radio" class="btn-check" name="LType" id="success-outlined-GB" autocomplete="off" value="GB" <%= LType.equals("GB") ? "checked" : "" %> >
							<label class="btn btn-light" for="success-outlined-GB">경북</label>
						</span>
						<span>
							<input type="radio" class="btn-check" name="LType" id="success-outlined-GN" autocomplete="off" value="GN" <%= LType.equals("GN") ? "checked" : "" %> >
							<label class="btn btn-light" for="success-outlined-GN">경남</label>
						</span>
						<span>
							<input type="radio" class="btn-check" name="LType" id="success-outlined-JB" autocomplete="off" value="JB" <%= LType.equals("JB") ? "checked" : "" %> >
							<label class="btn btn-light" for="success-outlined-JB">전북</label>
						</span>
						<span>
							<input type="radio" class="btn-check" name="LType" id="success-outlined-JN" autocomplete="off" value="JN" <%= LType.equals("JN") ? "checked" : "" %> >
							<label class="btn btn-light" for="success-outlined-JN">전남</label>
						</span>
						<span>
							<input type="radio" class="btn-check" name="LType" id="success-outlined-JJ" autocomplete="off" value="JJ" <%= LType.equals("JJ") ? "checked" : "" %> >
							<label class="btn btn-light" for="success-outlined-JJ">제주</label>
						</span>
						</div>
						<div class="sub-row" id="formAgreePreventDelete" style="display:none;">
							<label>
							선택하신 카테고리는 글 작성 후 수정/삭제가 불가능합니다. 동의하십니까?
							<input type="checkbox" name="agreePreventDelete">
							</label>
						</div>
						<div class="row">
							<div class="form-group col-12">
								<div class="input-group input-group-sm">
									<div class="input-group-prepend">
										<span class="input-group-text">제목</span>
									</div>
									<input type="hidden" name="event_number" value="${ev.event_number}">
									<input id ="event_title"  type="text" name="event_title" value="${ev.event_title}" class="form-control form-control-sm " id="event_title" maxlength="256" required="">
								</div>
								<div class="input-group input-group-sm">
									<div class="input-group-prepend">
										<span class="input-group-text">날짜</span>
									</div>
									<input type="text" name="event_start" class="form-control form-control-sm " id="event_start" value="${ev.event_start}" maxlength="256" required="">
									<input type="text" name="event_end" class="form-control form-control-sm " id="event_end" value="${ev.event_end}" maxlength="256" required="">
								</div>
								<div class="input-group input-group-sm">
									<div class="input-group-prepend">
										<span class="input-group-text">위치</span>
									</div>
									<input type="text" name="event_local" class="form-control form-control-sm " value="${ev.event_local}" id="event_local" maxlength="256" required="">
								</div>
								<div class="input-group input-group-sm">
									<div class="input-group-prepend">
										<span class="input-group-text">전화번호</span>
									</div>
									<input type="text" name="event_tel" class="form-control form-control-sm " value="${ev.event_tel}" value="event_tel" maxlength="256" required="">
								</div>
								
							</div>
							<input type="hidden" name="rentalhome_idx" value="${rentalhomeVO.rentalhome_idx}">
							<div id="open-gallery-button" style="display:inline-block; cursor:pointer;">등록된 이미지 보기</div>
							<div style="display:inline-block; width:200px; text-align:right; margin-right:30px;">
								<span style="font-weight:bold;">숙소 이미지 업로드</span>
							</div>
							<div class="form-group1" style="display:inline-block;">
								<input type="file" name="multiFile" value="${ev.attach_physical_name}" multiple required >
							</div>
							<div class="pt-1">
<!-- 							<textarea id="summernote" name="event_content"> -->
								<textarea id="summernote" name="event_content">${ev.event_content}</textarea>
								<script>
								  $(document).ready(function() {
									    $('#summernote').summernote({
									      height: 300,
									      callbacks: {
									        onChange: function(contents, $editable) {
									          $('#summernoteInput').val(event_content);
									        }
									      }
									    });
									  });
				                  </script>     
							</div>							
							<div id="preview"></div>
						</div>
						
						<div class="hidden-preview-checkbox">
							<input type="checkbox" name="hidden_preview" id="hidden_preview">
							<label for="hidden_preview">미디어 미리보기를 숨기시겠습니까?</label>
							<span class="ion-help-circled" data-toggle="tooltip" data-placement="top" title="" data-original-title="채널 목록에서 이미지 미리보기가 표시되지 않습니다."></span>
						</div>							
						<div class="pt-1 d-flex justify-content-end">
							<button class="btn btn-light mx-1" type="submit" style="width:10%; padding:5px;" onclick="DoSubmit();">제출</button>
						</div>
					</form>
				</article>	
			</main>
		</div>	
	</div>
	<script type="text/javascript">
	function DoSubmit() {
			if ($("#event_title").val() == "") {
			 alert("제목을 입력하세요");
			 $("#event_title").focus();
			 return false;
		    }
		    if ($("#event_content").val() == "") {
			      alert("내용을 입력하세요");
			      $("#event_content").focus();
			      return false;
			    }
			eventVO.event_content = event_content.replace("<p>","");
			eventVO.event_content = event_content.replace("</p>","");
		    return confirm("작성된 게시물을 저장하시겠습니까?");
		  }
	</script>
	
	

<%@ include file="../include/footer.jsp" %>