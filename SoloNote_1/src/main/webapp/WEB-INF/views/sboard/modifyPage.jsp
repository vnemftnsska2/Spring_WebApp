<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

.fileDrop {
	width: 80%;
	height: 100px;
	border: 1px dotted black;
	background-color: #F8F8F8;
	margin: auto;
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
						<h3 class="box-title">MODIFY BOARD</h3>
					</div>
					<!-- /.box-header -->
					<form role="form" action="modifyPage" method="post" id="modifyForm">
						<input type='hidden' name='page' value="${cri.page }">
						<input type='hidden' name='perPageNum' value="${cri.perPageNum }">
						<input type="hidden" name='searchType' value="${cri.searchType }">
						<input type="hidden" name='keyword' value="${cri.keyword }">
						<div class="box-body">
							<div class="form-group">
								<label for="exampleInputEmail1">BNO</label>
								<input type="text" name='bno' class="form-control" value="${boardVO.bno}" readonly="readonly">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">Title</label> <input type="text"
									name='title' class="form-control" value="${boardVO.title}">
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">Content</label>
								<textarea class="form-control" name="content" rows="3">${boardVO.content}</textarea>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">Writer</label> <input
									type="text" name="writer" class="form-control"
									value="${boardVO.writer}" readonly="readonly">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail">File Drop Here</label>
								<div class="fileDrop"></div>
							</div>
							<ul class="mailbox-attachments clearfix uploadedList">
						</ul>
						</div>
						<!-- /.box-body -->
						<div class="box-footer">
							<button type="submit" class="btn btn-primary">SAVE</button>
							<button type="button" class="btn btn-warning">CANCEL</button>
						</div>
					</form>
				</div>
				<!-- /.box -->
			</div>
			<!--/.col (left) -->

		</div>
		<!-- /.row -->
	</section>
	<!-- /.content -->
	<%@include file="../include/footer.jsp"%>
</body>
<script type="text/javascript" src="/resources/dist/js/upload.js"></script>
<script id="template" type="text/x-handlebars-template">
<li>
	<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
	<div class="mailbox-attachment-info">
		<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
		<a href="{{fullName}}" class="btn btn-default btn-xs pull-right delbtn"><i class="fa fa-fw fa-remove"></i></a>
	</div>
</li>
</script>
<script>
	$(document).ready(function(){
		
		var template = Handlebars.compile($("#template").html());
		
		// var formObj = $("form[role='form']");
		// console.log(formObj);
		
		$(".btn-warning").on("click", function(){
			self.location = "/sboard/list?page=+${cri.page}+&perPageNum=${cri.perPageNum}"
					+ "&searchType=${cri.searchType}&keyword=${cri.keyword}";
		});
	
		$(".fileDrop").on("dragenter dragover", function(event){
			event.preventDefault();
		});
		
		$(".fileDrop").on("drop", function(event){

			event.preventDefault();
			var files = event.originalEvent.dataTransfer.files;
			var file = files[0];
			var formData = new FormData();
			
			formData.append("file", file);
			
			$.ajax({
				url : '/uploadAjax',
				data : formData,
				dataType : 'text',
				processData : false,
				contentType : false,
				type : 'POST',
				success : function(data){
					
					console.log("data 확인" + data);
					
					var fileInfo = getFileInfo(data);
					var html = template(fileInfo);
					
					$(".uploadedList").append(html);
				}
			});
		});
		
		// submit 버튼
		$("#modifyForm").submit("click", function(event){
			
			event.preventDefault();
			
			var that = $(this);
			var str = "";
			
			// 화면 출력 후 링크 걸어둠(이미지 파일의 경우 확대되도록)
			$(".uploadedList .delbtn").each(function(index){
				str += "<input type='hidden' name='files["+ index +"]' value='"+ $(this).attr("href") +"'>";
			});
			
			that.append(str);
			// 내용확인
			console.log("내용 확인" + str);
			that.get(0).submit();
			//formObj.get(0).submit();
		});
		
	});
</script>
</html>