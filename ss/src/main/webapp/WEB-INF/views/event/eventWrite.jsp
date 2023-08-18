<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@page import="com.ss.demo.domain.EventVO"%>
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
// String type = request.getParameter("type");
// if( type == null ) type = "TT";		// 기본 게시판은 TT : 전체 디폴트
// LType 변수를 request 파라미터에서 읽어옵니다.
String LType = request.getParameter("LType");
if (LType == null) {
    LType = "TT"; // LType이 파라미터로 제공되지 않은 경우 기본값을 설정합니다.
}

EventVO ev = new EventVO();

//본문에 포함된 엔터문자를 <br>태그로 변경한다
if (ev.getEvent_content() != null) {
ev.setEvent_content(ev.getEvent_content().replace("<p>", ""));
ev.setEvent_content(ev.getEvent_content().replace("</p>", ""));
}
%>



<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>이벤트 메인</title>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<link rel="stylesheet" href="../css/datepicker.css">
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
	<script>
	$.datepicker.setDefaults({
	  dateFormat: 'yy-mm-dd',
	  prevText: '이전 달',
	  nextText: '다음 달',
	  monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	  monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	  dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	  dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	  dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	  showMonthAfterYear: true,
	  yearSuffix: '년'
	});

	$(function () {
	  $('.datepicker').datepicker();
	});
	</script>
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
			ev.event_content = event_content.replace("<p>","");
			ev.event_content = event_content.replace("</p>","");
			ev.event_discript = event_discript.replace("<p>","");
			ev.event_discript = event_discript.replace("</p>","");
		    return confirm("작성된 게시물을 저장하시겠습니까?");
		  }
	</script>
<!-- <script src="./js/write.js"></script> -->
<style type="text/css">
.note-insert {
    display: none;
	}
.note-resizebar
{
	 display: none;
}
.datepicker{
	font-weight:bold;
}
</style>
</head>
<body>
	<div class="container-fluid border-top">
		<div class="row flex-nowrap" >
			<main class="col-6 offset-3 py-md-1 pl-md-5 bd-content board-article border-end border-start" style="height: 100vh;" role="main">
				<article class="container-fluid">
					<form name="write" method="post" action="eventWrite.do" onsubmit="return DoSubmit();" enctype="multipart/form-data" >	
						<input type="hidden" name="contentType" value="html">
						<div class="write-head border-bottom py-md-1">
							글쓰기 | 작성자<%--  <%= loginVo.getuName() %> --%> <input type="hidden" name="uNo" id="uNo" value="1">
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
									<input id ="event_title"  type="text" name="event_title" class="form-control form-control-sm " id="event_title" maxlength="256" required="">
								</div>
								<div class="input-group input-group-sm">
									<div class="input-group-prepend">
										<span class="input-group-text py-2">날짜</span>
									</div>
									<div class="py-2" style="background-color:white; border:1px solid lightgray; width:250px;  display:inline-block; border-radius:5px; text-align:left; padding:0px 10px; position:relative;" >
										<div class="row justify-content-center">
											<div class="col-md-5">
												<span style="color:#777777; font-size:9pt; line-height:normal; position:absolute; top:1px; left:10px;">시작일</span><br>
												<input type="text" id="event_start" name="event_start" class="search form-control datepicker" style="padding:0px; box-shadow:0 0 0 0; font-size:10pt;width:100px;position:absolute; top:18px; left:10px; outline:none;" readonly>
											</div>
											<div class="col-md-5">
												<span style="color:#777777; font-size:9pt; line-height:normal; position:absolute; top:1px; left:140px;">종료일</span><br>
												<input type="text" id="event_end" name="event_end" class="search form-control datepicker" style="padding:0px; box-shadow:0 0 0 0; font-size:10pt; width:100px;position:absolute; top:18px; left:140px; outline:none;" readonly>
											</div>
										</div>
									</div>
									<div class="input-group-prepend">
										<span class="input-group-text py-2">위치</span>
									</div>
									<input type="text" name="event_local" class="form-control form-control-sm py-2" id="event_local" maxlength="256" required="">
									<div class="input-group-prepend">
										<span class="input-group-text py-2">전화번호</span>
									</div>
									<input type="text" name="event_tel" class="form-control form-control-sm py-2" id="event_tel" maxlength="256" required="">
								</div>
							</div>
							<div class="pt-1 pb-4 mb-4">
								<span class="input-group-text justify-content-center">축제의 개요와 유래설명</span>
<!-- 							<textarea id="summernote" name="contents"></textarea> -->
								<textarea id="summernote2" name="event_discript"></textarea>
								<script>
				                    $('#summernote2').summernote({
				                      placeholder: '내용을 입력해주세요',
				                      tabsize: 2,
				                      height: 100,
				                    
				                    });
				                  </script>     
							</div>				
							<br>
							<br>		
							<div style="display:inline-block; width:200px; text-align:right; margin-right:30px;">
								<span style="font-weight:bold;">숙소 이미지 업로드</span>
							</div>
							<div class="form-group1" style="display:inline-block;">
								<input type="file" name="multiFile" multiple required>
							</div>
							<div class="pt-1">
								<span class="input-group-text justify-content-center">상세 요강</span>
<!-- 							<textarea id="summernote" name="contents"></textarea> -->
								<textarea id="summernote" name="event_content"></textarea>
								<script>
				                    $('#summernote').summernote({
				                      placeholder: '내용을 입력해주세요',
				                      tabsize: 2,
				                      height: 300
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
	
	
	

<%@ include file="../include/footer.jsp" %>