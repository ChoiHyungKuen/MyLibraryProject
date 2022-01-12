<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="author" content="GeeksLabs">

<link rel="shortcut icon" href="img/favicon.png">

<title>로그인 페이지</title>

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
<script type="text/javascript" src="js/jquery.cookie.js"></script>  
<!-- HTML5 shim and Respond.js IE8 support of HTML5 -->
<!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
</head>

<body class="login-libro-body">
	<form class="login-form" action="actionLogin.do" name="loginForm" 
		  method="post" onsubmit="return loginFn.checkLogin()">
		<div class="login-wrap">
			<p class="login-img">
				<i class="icon_lock_alt"></i>
			</p>
			<div class="input-group">
				<span class="input-group-addon"><i class="icon_profile"></i></span>
				<input id="loginId" name="id" type="text" class="form-control" placeholder="Username"
					autofocus>
			</div>
			<div class="input-group">
				<span class="input-group-addon"><i class="icon_key_alt"></i></span>
				<input id="loginPw" name="password" type="password" class="form-control" placeholder="Password">
			</div>
			<label class="checkbox"> 
			<input type="checkbox" name="rememberId" value="remember-me" id="checkRememberId"> 아이디 저장 
			<span class="pull-right"> 
			<a href="#" onclick="javascript:loginFn.clickFindMemberInfo()">아이디/비번 찾기</a> 
			</span>	
			</label>	
			<button class="btn btn-primary btn-lg btn-block" type="submit">Login</button>
			<button class="btn btn-info btn-lg btn-block" type="button" onclick="javascript:loginFn.clickRegisterMember()">Signup</button>
		</div>
	</form>

	<script type="text/javascript">
	var loginFn = {
		getId : function(form) {
			
			form.rememberId.checked = ((form.id.value = $.cookie("saveId")) != null);
		},
		saveId : function(form)
		{
			$.cookie("saveId", form.id.value, {expires : 30});
		},
		checkLogin : function() {
			
			if( $("#loginId").val() == "") {
				
				alert("ID를 입력해주세요.");
				return false;
			} else if($("#loginPw").val() == "") {
				
				alert("비밀번호를 입력해주세요.");
				return false;
			}
			
			// submit할때 아이디저장하는 버튼이 체크 되있으면 아이디 저장
			if($("#checkRememberId").is(":checked")) {
			
				loginFn.saveId(document.loginForm);
			} else {
				$.cookie('saveId', null);
			}
			
			return true;
		},
		clickRegisterMember : function() {
			
			window.close();
			
			var url = "termsOfRegisterView.do";
			var opt = "width=900, height=800";
				
			window.open(url, "", opt);	
		},
		clickFindMemberInfo : function() {

			window.close();
			
			var url = "findMemberInfo.do";
			var opt = "width=850, height=500";
				
			window.open(url, "", opt);	
		}
	}
	$(document).ready(function(form) {

		var isCheck = "<c:out value='${isCheck}' />";
			
		if (isCheck == 'Y') {

			alert("성공적으로 회원가입되었습니다. 로그인해주세요.");
			return ;
		}
			
		var isChangeMemberInfo = "<c:out value='${isChangeMemberInfo}' />";
			
		if(isChangeMemberInfo == 'Y') {
				
			alert("회원님의 정보를 변경했습니다. 다시 로그인 해주세요.");
			opener.parent.location.reload();	
			return ;
		}
		
		var isLogin = "<c:out value='${isLogin}' />";
		if (isLogin == "Y" || isLogin == "N") {
				
			alert("<c:out value='${message}' />");
			
			if(isLogin == "Y") {
				
				opener.parent.location.reload();
				window.close();
			}
		}
		
		loginFn.getId(document.loginForm);
	});
	</script>
</body>
</html>
