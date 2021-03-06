<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
						<h3 class="box-title">REGISTER BOARD</h3>
					</div>
					<!-- /.box-header -->

					<form role="form" method="post" id="registerForm">
						<div class="box-body">
							<div class="form-group">
								<label for="exampleInputEmail1">Title</label> <input type="text"
									name='title' class="form-control" placeholder="Enter Title">
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">Content</label>
								<textarea class="form-control" name="content" rows="3"
									placeholder="Enter ..."></textarea>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">Writer</label> <input
									type="text" name="writer" class="form-control" value="${login.uid }" readonly>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail">File Drop Here</label>
								<div class="fileDrop"></div>
							</div>
						</div>
						<!-- /.box-body -->
						<div class="box-footer">
						<div>
							<hr>
						</div>
						
						<ul class="mailbox-attachments clearfix uploadedList">
						</ul>
							<button type="submit" class="btn btn-primary saveBtn">Submit</button>
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
	<!-- /.content-wrapper -->
	<%@include file="../include/footer.jsp"%>

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
</body>
<script>

	var template = Handlebars.compile($("#template").html());
	
	
	// 첨부 파일 드래그했을 때 발생하는 이벤트 처리
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
				var fileInfo = getFileInfo(data);
				var html = template(fileInfo);
				
				$(".uploadedList").append(html);
			}
		});
	});
	
	$("#registerForm").submit(function(event){
		event.preventDefault();
		
		
		
		var that = $(this);
		var str = "";
		
		$(".uploadedList .delbtn").each(function(index){
			str += "<input type='hidden' name='files["+ index +"]' value='"+ $(this).attr("href") +"'>";
		});
		
		that.append(str);
		
		//alert(str);
		
		that.get(0).submit();
		
	});
	
</script>
</html>