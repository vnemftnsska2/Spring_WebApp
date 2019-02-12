<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	
	.popup {
		position: absolute;
	}
	
	.back {
		background-color: gray;
		opacity: 0.5;
		width: 100%;
		height: 300%;
		overflow: hidden;
		z-index: 1101;
	}
	
	.front {
		z-index: 11110;
		opacity: 1;
		border: 1px;
		margin: auto;
	}
	
	.show {
		position: relative;
		max-width: 1200px;
		max-height: 800px;
		overflow: auto;
	}

</style>
</head>
<body>
<%@include file="../include/header.jsp"%>
<!-- Main content -->
	<section class="content">
		<div class="row">
			<!-- left column -->
			<div class="col-md-12">
				<!-- general form elements -->
				<div class="box box-primary">
					<div class="box-header">
						<h3 class="box-title">READ BOARD</h3>
					</div>
					<!-- /.box-header -->
					<!-- 첨부파일 이미지 보이도록 처리 -->
					<div class="popup back" style="display:none"></div>
						<div id="popup_front" class="popup front" style="display:none"><img id="popup_img">
					</div>
					<!-- 첨부파일 END -->
					<form role="form" action="modifyPage" method="post">
						<input type='hidden' name='bno' value="${boardVO.bno}"> <input
							type='hidden' name='page' value="${cri.page }"> <input
							type='hidden' name='perPageNum' value="${cri.perPageNum }">
						<input type='hidden' name='searchType' value="${cri.searchType }">
						<input type='hidden' name='keyword' value="${cri.keyword }">
					</form>

					<div class="box-body">
						<div class="form-group">
							<label for="exampleInputEmail1">Title</label> <input type="text"
								name='title' class="form-control" value="${boardVO.title}"
								readonly="readonly">
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1">Content</label>
							<textarea class="form-control" name="content" rows="3"
								readonly="readonly">${boardVO.content}</textarea>
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">Writer</label> <input type="text"
								name="writer" class="form-control" value="${boardVO.writer}"
								readonly="readonly">
						</div>
					</div>
					<!-- /.box-body -->
					<div class="box-footer">
						<span style="float: right;">
							<button type="submit" class="btn btn-warning" id="modifyBtn">수정</button>
							<button type="submit" class="btn btn-danger" id="removeBtn">삭제</button>
							<button type="submit" class="btn btn-primary" id="goListBtn">목록							</button>
						</span>
					</div>
					<!-- 첨부파일 출력 div -->
					<div>
						<ul class="mailbox-attachments clearfix uploadedList">
						</ul>
					</div>
					<!-- 첨부파일 END  -->
				</div>
				<!-- /.box -->
			</div>
			<!--/.col (left) -->
		</div>
		<!-- /.row -->
		<div class="row">
			<div class="col-md-12">
				<div class="box box-success">
					
					<div class="box-header">
						<h3 class="title">ADD NEW REPLY</h3>
					</div>
					<div class="box-body">
						<label for="newReplyWriter">Writer</label> <input
							class="form-control" type="text" placeholder="USER ID"
							id="newReplyWriter"> <label for="newReplyText">ReplyText</label>
						<input class="form-control" type="text" placeholder="REPLY TEXT"
							id="newReplyText">
					</div>
					<div class="box-footer" >
						<button type="submit" class="btn btn-primary" id="replyAddBtn" style="float: right;">ADD REPLY</button>
					</div>
				</div>
			</div>
		</div>
			<!-- The time line -->
			<ul class="timeline">
				<!-- tmieline time label -->
				<li class="time-label" id="repliesDiv"><span class="bg-green">Replies List <small id='replycntSmall'>[ ${boardVO.replycnt} ]</small></span></li>
			</ul>
			<div class='text-center'>
				<ul id="pagination" class="pagination pagination-sm no-margin">
				</ul>
			</div>
			<!-- Modal -->
			<div id="modifyModal" class="modal modal-primary fade" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content -->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title"></h4>
						</div>
						<div class="modal-body" data-rno>
							<p><input type="text" id="replytext" class="form-control"></p>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-info" id="replyModBtn">Modify</button>
							<button type="button" class="btn btn-danger" id="replyDelBtn">DELETE</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
						<ul class="mailbox-attachments clearfix uploadedList"></ul>
					</div>
				</div>
			</div>
			<!-- end of Modal -->
	</section>
	<%@include file="../include/footer.jsp"%>
	<script type="text/javascript" src="/resources/dist/js/upload.js"></script>
</body>
<!-- start of java script template -->
<script id="template" type="text/x-handlebars-template">
{{#each .}}
<li class="replyLi" data-rno={{rno}}>
<i class="fa fa-comments bg-blue"></i>
<div class="timeline-item">
	<span class="time">
		<i class="fa fa-clock-o"></i>{{prettifyDate regdate}}
	</span>
	<h3 class="timeline-header"><strong>{{rno}}</strong> : {{replyer}}</h3>
	<div class="timeline-body">{{replytext}} </div>
	<div class="timeline-footer">
		<a class="btn btn-primary btn-xs"
		data-toggle="modal" data-target="#modifyModal">Modify</a>
	</div>
</div>
</li>
{{/each}}
</script>
<!-- 첨부 파일 출력 template -->
<script id="templateAttach" type="text/x-handlebars-template">
<li data-src="{{fullName}}">
	<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
	<div class="mailbox-attachment-info">
	<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
	</div>
</li>
</script>
<!-- end of java script template -->
<script>
	
	$(document).ready(function() {
		var formObj = $("form[role='form']");
		console.log(formObj);
		console.log("${boardVO.bno}");
		
		$("#modifyBtn").on("click", function() {

			formObj.attr("action", "/sboard/modifyPage");
			formObj.attr("method", "get");
			formObj.submit();
		});

		$("#removeBtn").on("click", function() {

			var replyCnt = $("#replycntSmall").html().replace(/[^0-9]/g,"");
			
			if(replyCnt > 0) {
				alert("댓글이 달린 게시물은 삭제할 수 없습니다.");
				return;
			}
			
			var arr = [];
			$(".uploadedList li").each(function(index){
				arr.push($(this).attr("data-src"));
			});
			
			if(arr.length > 0){
				$.post("/deleteAllFiles", {files:arr}, function(){
					
				});
			}
			
			formObj.attr("action", "/sboard/removePage");
			formObj.submit();
		});
		
		$("#goListBtn").on("click", function() {
			formObj.attr("action", "/sboard/list");
			formObj.attr("method", "get");
			formObj.submit();
		});
		
		//페이징 처리 구현
		var bno = ${boardVO.bno};
		var replyPage = 1;	// 첫페이지는 1, 댓글의 페이지 번호를 유지하기 위해 정의한 변수
		// getPage("/replies/" + bno + "/" + replyPage); 삽질의 흔적...ㅅㅂ
		
		function getPage(pageInfo){
			
			$.getJSON(pageInfo, function(data){
				printData(data.list, $("#repliesDiv"), $("#template"));
				printPaging(data.pageMaker, $(".pagination"));
				
				$("#modifyModal").modal('hide');
				$("#replycntSmall").html("[ " + data.pageMaker.totalCount + " ]")
			});
		}
		
		var printPaging = function(pageMaker, target) {
			
			var str = "";
			
			if(pageMaker.prev) {
				str += "<li><a href='" + (pageMaker.startPage-1) + "'> << </a></li>";
			}
			
			for(var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
				var strClass = pageMaker.cri.page == i ? 'class = active' : '';
				str += "<li " + strClass + "><a href='" + i + "'>" + i + "</a></li>";
			}
			
			if(pageMaker.next) {
				str += "<li><a href='" + (pageMaker.endPage + 1) + "'> >> </a></li>";
			}
			
			target.html(str);
		};
		
		// 댓글 목록 보기
		$("#repliesDiv").on("click", function(){
			if($(".timeline li").size() > 1) {
				return;
			}
			getPage("/replies/" + bno + "/1");
		});
		
		$(".pagination").on("click", "li a", function(event){
			event.preventDefault();	// a 태그 속성을 막은 후
			replyPage = $(this).attr("href");	// 다시 a태그의 속성 href 정의한다.
			getPage("replies" + bno + "/" + replyPage); // href 안에 url을 변경시켜준다.
		})
		
		// 댓글 추가 구현
		$("#replyAddBtn").on("click", function(){	// 버튼을 클릭했을 시
			
			var replyerObj = $("#newReplyWriter");	// 작성자 객체를 변수로 담고
			var replytextObj = $("#newReplyText");	// 위와 마찬가지고 변수에 객체를 담습니다.
			var replyer = replyerObj.val();	// 작성자 이름을 변수에 담습니다.
			var replytext = replytextObj.val();	// 댓글 내용을 변수에 담습니다.
			
			$.ajax({
				type : 'post',
				url : '/replies/',	// 댓글 등록 컨트롤러에 보낼 맵핑 주소
				headers: {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST" },
				dataType : 'text',	// 서버로부터 받을 데이터 타입
				data : JSON.stringify({bno:bno, replyer:replyer, replytext:replytext}),	// 서버로 보낼 때 스크립트 객체를 JSON 데이터로 변환하여 보낸다.
				success : function(result){
					console.log("result : " + result);	// 'SUCCESS' 가 찍혀야 함
					if(result == 'SUCCESS') {
						alert("등록 되었습니다.");
						replyPage = 1;
						getPage("/replies/" + bno + "/" + replyPage);
						replyerObj.val("");
						replytextObj.val("");	// 데이터를 등록했으니 입력 창 초기화 시켜줌.
					}
					
				}
			});
			
		});
		
		// 댓글의 버튼 이벤트 처리
		$(".timeline").on("click", ".replyLi", function(event){
			
			var reply = $(this);
			
			$("#replytext").val(reply.find('.timeline-body').text());
			$(".modal-title").html(reply.attr("data-rno"));
		});
		
		// 댓글 수정 버튼
		$("#replyModBtn").on("click", function(){
			
			var rno = $(".modal-title").html();
			var replytext = $("#replytext").val();
			
			$.ajax({
				type : 'put',
				url : '/replies/' + rno,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PUT"
				},
				dataType : 'text',
				data : JSON.stringify({replytext:replytext}),
				success : function(result) {
					console.log("result : " + result);
					if(result == 'SUCCESS') {
						alert("수정 되었습니다.");
						getPage("/replies/" + bno + "/" + replyPage);
					}
				}
			});
		});
		
		// 댓글 삭제 버튼
		$("#replyDelBtn").on("click", function(){
			
			var rno = $(".modal-title").html();
			
			$.ajax({
				type : 'delete',
				url : '/replies/' + rno,
				headers : {
					"Context-Type" : "application/json",
					"X-HTTP-Method-Override" : "DELETE"
				},
				dataType : 'text',
				success : function(result) {
					console.log("result : " + result);
					if(result == 'SUCCESS') {
						alert("삭제 되었습니다.");
						getPage("/replies/" + bno + "/" + replyPage);
					}
				}
			});
		});
		
		// 자바스크립트 템플릿 기능 확장 추가
		Handlebars.registerHelper("prettifyDate", function(timeValue){
			var dateObj = new Date(timeValue);
			var year = dateObj.getFullYear();
			var month = dateObj.getMonth() + 1;
			var date = dateObj.getDate();
			return year +"/"+ month +"/"+ date;
		});
		
		var printData = function (replyArr, target, templateObject){
			
			var template = Handlebars.compile(templateObject.html());
			
			var html = template(replyArr);
			$(".replyLi").remove();
			target.after(html);
		}
		
		var template = Handlebars.compile($("#templateAttach").html());
		
		$.getJSON("/sboard/getAttach/" + bno, function(list){
			$(list).each(function(){
				//alert("들어온나");
				var fileInfo = getFileInfo(this);
				var html = template(fileInfo);
				
				console.log(html)
				
				$(".uploadedList").append(html);
			});
		});
		
	}); // document.ready 끝
		
	// img파일 확대와 다운로드
	$(".uploadedList").on("click", ".mailbox-attachment-info a", function(event){
		
		var fileLink = $(this).attr("href");
		
		if(checkImageType(fileLink)) {
			
			event.preventDefault();
			
			var imgTag = $("#popup_img");
			imgTag.attr("src", fileLink);
			
			console.log(imgTag.attr("src"));
			
			$(".popup").show('slow');
			imgTag.addClass("show");
		}
	});
	
	$("#popup_img").on("click", function(){
		$(".popup").hide('slow');
	});
	
	
</script>
</html>