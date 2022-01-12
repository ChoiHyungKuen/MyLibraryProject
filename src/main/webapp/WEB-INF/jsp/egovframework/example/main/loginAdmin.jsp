<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description"
	content="Creative - Bootstrap 3 Responsive Admin Template">
<meta name="author" content="GeeksLabs">
<meta name="keyword"
	content="Creative, Dashboard, Admin, Template, Theme, Bootstrap, Responsive, Retina, Minimal">
<link rel="shortcut icon" href="img/favicon.png">

<title>관리자 페이지 로그인(인증)</title>

<!-- Bootstrap CSS -->
<link href="css/admin-css/bootstrap.min.css" rel="stylesheet">
<!-- bootstrap theme -->
<link href="css/admin-css/bootstrap-theme.css" rel="stylesheet">
<!--external css-->
<!-- font icon -->
<link href="css/admin-css/elegant-icons-style.css" rel="stylesheet" />
<link href="css/admin-css/font-awesome.css" rel="stylesheet" />
<!-- Custom styles -->
<link href="css/admin-css/style.css" rel="stylesheet">
<link href="css/admin-css/style-responsive.css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- HTML5 shim and Respond.js IE8 support of HTML5 -->
<!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
</head>

<body class="login-admin-body">

	<form class="login-form" action="<c:url value='/j_spring_security_check'/>" method="POST" >
		<h1>관리자 페이지</h1>
		
		<c:if test="${not empty param.error }">
    		<h4 style="color:red;">${SPRING_SECURITY_LAST_EXCEPTION.message }</h4>
		</c:if>
		<div class="login-wrap">
			<p class="login-img">
				<i class="icon_lock_alt"></i>
			</p>
			<div class="input-group">
				<span class="input-group-addon"><i class="icon_profile"></i></span>
				<input id="id" name="j_username" type="text" class="form-control" placeholder="Username"
					autofocus>
			</div>
			<div class="input-group">
				<span class="input-group-addon"><i class="icon_key_alt"></i></span>
				<input id="password" name="j_password" type="password" class="form-control" placeholder="Password">
			</div>
            <c:out value= "${ message}" />
			<button class="btn btn-primary btn-lg btn-block" type="submit">Login</button>
		</div>
	</form>

	<script type="text/javascript">
		$(document).ready(function() {

		});
	</script>
</body>
</html>
