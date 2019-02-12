<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <!-- Bootstrap 3.3.4 -->
    <link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Font Awesome Icons -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Ionicons -->
    <link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="/resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins 
         folder instead of downloading all of them to reduce the load. -->
    <link href="/resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
    <script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
	<style>
	body{
		background-color: #EFFBF5;
	}
	.login-box {
		margin-top: 13%;
		border: 5px solid #A9F5D0;
		padding: 5px;
		width: 350px;
		background-color:#CEF6E3;
	}
	
	</style>
</head>
<body>
<div class="login-box">
<h3 style="text-align:center; margin-bottom: 15px;">순남2 홈페이지</h3>
<form action="/user/loginPost" method="post">
	<div class="form-group has-feedback">
		<input type="text" name="uid" class="form-control" placeholder="USER ID" required="required">
		<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
	</div>
	<div class="form-group has-feedback">
		<input type="password" name="upw" class="form-control" placeholder="PASSWORD" required="required">
		<span class="glyphicon glyphicon-lock form-control-feedback"></span>
	</div>
	<div class="row">
		<div class="col-xs-8">
			<div class="checkbox ichek">
				<label>
					<input type="checkbox" name="useCookie"> Remember Me
				</label>
			</div>
		</div>
			<div class="col-xs-4">
				<button type="submit" class="bun bun-primary btn-block btn-flat">Log In</button>
			</div>
		</div><!-- /.col -->
		<a href="/sboard/home">see the sight of home...</a>
</form>
</div>
</body>
</html>