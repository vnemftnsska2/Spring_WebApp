<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<style>
#modDiv {
	width:300px;
	height:100px;
	background-color: gray;
	position: absolute;
	top: 50%;
	left: 50%;
	margin-top: -50px;
	margin-left: -150px;
	padding: 10px;
	z-index: 1000;
}

</style>
<title>Ajax Test Page</title>
</head>
<body>
	<div>
		<h2>Ajax Test Page</h2>

		<div>
			<div>
				REPLYER <input type='text' name='replyer' id='newReplyWriter'
					required="required">
			</div>
			<div>
				REPLY TEXT <input type='text' name='replytext' id='newReplytText'
					required="required">
			</div>
			<button id="replyAddBtn">ADD REPLY</button>
		</div>

		<br>
		<br>
		<h3 style="text-align: center;">&lt;댓글
			리스트&gt;</h3>
		<ul id="replies">
		</ul>
		<ul class="pagination">
		</ul>

		<div id='modDiv' style="display: none;">
			<div class='modal-title'></div>
			<div>
				<input type='text' id='replytext'>
			</div>
			<div>
				<button type="button" id="replyModBtn">Modify</button>
				<button type="button" id="replyDelBtn">Delete</button>
				<button type="button" id="closeBtn">Close</button>
			</div>
		</div>
	</div>
	<!-- jQuery 2.1.4 -->
	<script>

	var bno = 6127;
	//getAllList()
	getPageList(1);
	
	
	// 댓글 리스트 출력
	function getAllList(){
		$.getJSON("/replies/all/" + bno, function(data){
			var str = "";
			console.log(data.length);
			// j-query의 each는 for문과 같다.
			$(data).each(function(){
				str += "<li data-rno='" + this.rno + "' class='replyLi'>"
				+ this.rno + ":" + this.replytext + "<button>MOD</button></li>";
			});
			$("#replies").html(str);
		});
	}
	
	// 댓글 추가 버튼
	$("#replyAddBtn").on("click", function(){
		var replyer = $("#newReplyWriter").val();
		var replytext = $("#newReplytText").val();
		
		$.ajax({
			type : 'post',
			url : '/replies',
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType : 'text',	// 전송 받는 결과 타입
			data : JSON.stringify({	// 전송하는 타입
				bno : bno,
				replyer : replyer,
				replytext : replytext
			}),
			success : function(result) {
				if(result == 'SUCCESS') {
					alert("등록 되었습니다.");
					getAllList();
				}
			}
		});
	});
	
	// 댓글 모달 창 띄우기
	$("#replies").on("click", ".replyLi button", function(){
		var reply = $(this).parent();	// .replyLi button(this) 의 parent = li
		
		var rno = reply.attr("data-rno");	// 속성 가져오기
		var replytext = reply.text();	// 텍스트 내용 가져오기
		
		// alert(rno + " : " + replytext); 확인하기 위해 적음
		$(".modal-title").html(rno);
		$("#replytext").val(replytext);
		$("#modDiv").show("slow");
	});
	
	// 댓글 삭제 버튼 구현
	$("#replyDelBtn").on("click", function(){
		var rno = $(".modal-title").html();
		var replytext = $("#replytext").val();
		
		$.ajax({
			type : 'delete',
			url : '/replies/' + rno,
			headers : {
				"Context-Type" : "application/json",
				"X-HTTP-Method-Override" : "DELETE"
			},
			dataType : 'text',
			success : function(result){
				console.log("result: " + result);
				if(result == 'SUCCESS'){
					alert("삭제되었습니다.");
					$("#modDiv").hide("show");
					getAllList();
				}
			}
		});
	});
	
	// 댓글 수정 버튼
	$("#replyModBtn").on("click", function(){
		
		var rno = $(".modal-title").html();
		var replytext = $("#replytext").val();
		
		$.ajax({
			type : 'put',
			url : '/replies/'+rno,
			headers: {
				"Context-Type" : "application/json",
				"X-HTTP-Method-Override" : "PUT"
			},
			data : JSON.stringify({replytext:replytext}),
			dataType : 'text',
			success : function(result){
				console.log("result : " + result);
				if(result == 'SUCCESS'){
					alert("수정되었습니다.");
					$("#modiDiv").hide("slow");
					//getAllList();
					getPageList(replyPage);	// 419page 참조
				}
			}
		});
	});
	
	// 페이징 처리 처리
	function getPageList(page){
		$.getJSON("/replies/"+bno+"/"+page, function(data){
			console.log(data.list.length);
			
			var str = "";
			
			$(data.list).each(function(){
				str += "<li data-rno='" + this.rno + "' class='replyLi'>"
				+ this.rno + ":" + this.replytext + "<button>MOD</button></li>";
			});
			
			$("#replies").html(str);
			
			printPaging(data.pageMaker);
			
		});
	}
	
	function printPaging(pageMaker) {
		
		var str = "";
		
		if(pageMaker.prev) {
			str += "<li><a href='"+ (pageMaker.startPage-1) +"'> << </a></li>";
		}
		
		for(var i=pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
			var strClass = pageMaker.cri.page == i? 'class=active' : '';
			str += "<li "+ strClass +"><a href='"+ i +"'>"+ i +"</a></li>";			
		}
		
		if(pageMaker.next){
			str += "<li><a href='"+(pageMaker.endPage + 1)+"'> >> </a></li>";
		}
		$('.pagination').html(str);
	}
	
	var replyPage = 1;
	$(".pagination").on("click", "li a", function(event){
		
		event.preventDefault();
		replyPage = $(this).attr("href");
		getPageList(replyPage);
	});
	
	// 모달 닫기 버튼
	$("#closeBtn").click(function(){
		$("#modDiv").hide("show");
	});
	
	</script>
</body>
</html>