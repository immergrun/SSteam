<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@page import="com.ss.demo.domain.EventReviewVO"%>
<%@page import="com.ss.demo.domain.EventVO"%>
<%
// 로그인 정보를 세션에서 확인한 후
// 1. 로그인 정보가 없으면, 메인으로 돌려보냄
// 2. 로그인 정보가 있으면, 이 페이지를 사용자에게 노출시킴
/* if( loginVo == null )
{
//	response.sendRedirect("index.jsp");		// 메인으로 돌려보냄
	response.sendRedirect("login.jsp");		// 로그인 화면으로 보냄
	return;
} */
// 파라메타를 통해 사용자가 글을 작성하려는 게시판이 어느것인지 판단하기 위해,
// 'type'이름으로 데이터를 받는다
 
%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>이벤트 메인</title>
<script>
   $(document).ready(function() {
       $('#summernote').summernote({
           placeholder: '내용을 입력해주세요',
           tabsize: 2,
           height: 300
       });
   });
</script>

<style>
*{margin:0; padding:0;}
.star{
  display:inline-block;
  width: 30px;height: 60px;
  cursor: pointer;
}
.star_left{
  background: url(https://cdn-icons.flaticon.com/png/512/2550/premium/2550223.png?token=exp=1658206826~hmac=853093603ce7f8188af247e705aef276) no-repeat 0 0; 
  background-size: 60px; 
  margin-right: -3px;
}
.star_right{
  background: url(https://cdn-icons.flaticon.com/png/512/2550/premium/2550223.png?token=exp=1658206826~hmac=853093603ce7f8188af247e705aef276) no-repeat -30px 0; 
  background-size: 60px; 
  margin-left: -3px;
}
.star.on{
  background-image: url(https://cdn-icons.flaticon.com/png/512/2550/premium/2550357.png?token=exp=1658206869~hmac=205ea741a33853793221c4343f94576a);
}
</style>
</head>
<body>
	<div class="container-fluid border-top">
		<div class="row flex-nowrap" >
			<main class="col-6 offset-3 py-md-1 pl-md-5 bd-content board-article border-end border-start" style="height: 100vh;" role="main">
				<article class="container-fluid" >
					<form name="write" method="post" action="eventReviewModify.do" onsubmit="return DoSubmit();">
						<div class="write-head border-top border-bottom py-md-1">
							글쓰기 | 작성자<%--  <%= loginVo.getuName() %> --%> 
						</div>
						<div class="sub-row py-md-1">
						<span>${erv.event_number}.${event_title}</span>
						<input type="hidden" name="event_number" value="${erv.event_number}">
						</div>
						<!-- <div class="sub-row" id="formAgreePreventDelete" style="display:none;">
							<label>
							
							
							선택하신 카테고리는 글 작성 후 수정/삭제가 불가능합니다. 동의하십니까?
							
							
							<input type="checkbox" name="agreePreventDelete">
							</label>
						</div> -->
						<div class="row">
							<div class="form-group col-12">
								<div class="input-group input-group-sm">
									<div class="input-group-prepend">
										<span class="input-group-text">리뷰 제목</span>
									</div>
									<input type="hidden" name="comment_number" value="${erv.comment_number}">
									<input id ="comment_title"  type="text" name="comment_title" value="${erv.comment_title}" class="form-control form-control-sm " id="comment_title" maxlength="256" required="">
								</div>
							</div>
							<div class="pt-1">
							<textarea id="summernote" name="comment_content"> ${erv.comment_content}</textarea>
							</div>
						</div>
						
						<div class="hidden-preview-checkbox">
										
							
							<script type="text/javascript">
							   function DoSubmit() {
									if ($("#comment_title").val() == "") {
									 alert("제목을 입력하세요");
									 $("#comment_title").focus();
									 return false;
								    }
								    if ($("#comment_content").val() == "") {
									      alert("내용을 입력하세요");
									      $("#comment_content").focus();
									      return false;
									    }
									comment_content = comment_content.replace("<p>","");
									comment_content = comment_content.replace("</p>","");
									
								    return confirm("작성된 게시물을 저장하시겠습니까?");
								  }
							</script>
							
							
							
							<input type="checkbox" name="hidden_preview" id="hidden_preview">
							<label for="hidden_preview">미디어 미리보기를 숨기시겠습니까?</label>
							<span class="ion-help-circled" data-toggle="tooltip" data-placement="top" title="" data-original-title="채널 목록에서 이미지 미리보기가 표시되지 않습니다."></span>
						</div>		
						<div class="pt-1 d-flex justify-content-end ">
					   		<button class="btn btn-light " type="submit" style="width:10%; padding:5px;" onclick="DoSubmit();">제출</button>	
						</div>
					</form>
				</article>	
			</main>
		</div>	
	</div>		
<%@ include file="../include/footer.jsp" %>