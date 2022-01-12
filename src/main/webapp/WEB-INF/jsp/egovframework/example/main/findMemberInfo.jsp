<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><title>아이디/비번 찾기</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    <!-- Place favicon.ico in the root directory -->
    <link rel="apple-touch-icon" href="images/apple-touch-icon.png">
    <link rel="shortcut icon" type="image/ico" href="images/favicon.ico" />

    <!-- Plugin-CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/icofont.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/cardslider.css">
    <link rel="stylesheet" href="css/responsiveslides.css">

    <!-- Main-Stylesheets -->
    <link rel="stylesheet" href="css/normalize.css">
    <link rel="stylesheet" href="css/overright.css">
    <link rel="stylesheet" href="css/theme.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/responsive.css">
    <script src="js/vendor/modernizr-2.8.3.min.js"></script>  
    <!-- Vandor-JS -->
    <script src="js/vendor/jquery-1.12.4.min.js"></script>
    <script src="js/vendor/bootstrap.min.js"></script>
    <script src="js/jquery.history.js"></script>
    <style>
    .find-tab-li { width : 50%; text-align : center; } 
    .panel > h1 { text-align : center; }
    .tab-panel > h2 { text-align : center; }
    .id-form { display : inline; width : 60% }
    .email-form { display : inline; width : 25%  }
    .email-select-form { display : inline; width : 20%  }
    </style>
</head>
<body>
	<div class="space-50"></div>
	<div class="col-xs-12">
		
		<div class="panel">
		<h1>ID / 비밀번호 찾기 - 이메일 인증</h1>
			<div class="panel-heading">
				<ul class="nav nav-tabs">
					<li class="active find-tab-li"><a data-toggle="tab" href="#findId">아이디 찾기</a></li>
					<li class="find-tab-li"><a data-toggle="tab" href="#findPw">비밀번호 찾기</a></li>
				</ul>
			</div>
			<div class="panel-body">
				<div class="tab-content">
					<div class="tab-pane fade in active" id="findId">
					<h4>가입할 때 적으신 이메일을 입력해주세요.</h4>
						<form action="findMemberIdByEmail.do">
								<input type="text" class="form-control email-form" id="findEmail"
									placeholder="이메일을 입력해주세요." name="findEmail">
								<span>	@</span>
								<input type="text" class="form-control email-form" id="findEmailAddress"
									name="findEmailAddress" readonly="true" value="naver.com"/>
								<select class="form-control email-select-form" id="findSelectEmailAddress"
									onchange="javascript:findMemberInfoFn.changeEmailAdress()">
									<option value="user">직접 입력</option>	
									<option value="naver.com" selected>naver.com</option>
									<option value="daum.net">daum.net</option>
									<option value="gmail.com">gamil.com</option>
								</select>
								<button type="submit" class="btn btn-primary">
								아이디 찾기
								</button>	
								<div class="space-30"></div>
								<c:if test="${ !empty resultForFindId }">
									<strong><c:out value="${ resultForFindId }"/></strong>
								</c:if>
						</form>
					</div>
					<div class="tab-pane fade" id="findPw">
					<h4>아이디를 입력해주세요. 아이디와 일치하는 이메일로 인증메일을 보내 인증과정을 거칩니다.</h4>
						<form action="findMemberPwByEmailAuth.do">
								<input type="text" class="form-control id-form" id="findMemberId"
									placeholder="회원님의 아이디을 입력해주세요." name="findMemberId">
									<button type="submit" class="btn btn-primary">
										아이디와 연결된 이메일로 인증하기
									</button>
							<div class="space-30"></div>
							<c:if test="${ !empty resultForFindPw }">
								<c:choose>
									<c:when test="${ resultForFindPw == 'Y' }">
										<h5><c:out value="${ returnEmailToUser}" />로 메일을 보냈습니다. 인증번호를 적어주세요.</h5>
										<input type="text" class="form-control email-form" id="emailAuth"
										placeholder="인증코드를 입력해주세요." name="emailAuth">
										<button type="button" class="btn btn-primary" onclick="javascript:findMemberInfoFn.authFindMember()">
											인증코드 입력
										</button>	
									</c:when>
									<c:otherwise>
									<strong>아이디와 일치하는 이메일이 없습니다. 다시 한번 확인하시고 시도해주세요.</strong>
									</c:otherwise>
								</c:choose>
							</c:if>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
	var findMemberInfoFn =
	{
		changeEmailAdress : function () {

			$("#findSelectEmailAddress option:selected").each(function() {

					if ($(this).val() == 'user') { //직접입력일 경우

						$("#findEmailAddress").val(""); //값 초기화

						$("#findEmailAddress").removeAttr("readonly"); //활성화
					} else { //직접입력이 아닐경우

						$("#findEmailAddress").val($(this).text()); //선택값 입력

						$("#findEmailAddress").attr("readonly", "readonly");//비활성화
					}
				});
		}, 
		authFindMember : function() {
			
			var inputUserAuthCode = $("#emailAuth").val();
			
			if("<c:out value='${ authCode }'/>" == inputUserAuthCode) {
				
				$("#findPw").children().remove();
				
				var strTags = '<h4>인증되신 상태입니다. 아래에 변경하실 비밀번호를 입력해주세요.</h4>'
							+ '<form action="changeMemberPwByEmailAuth.do" method="post" onsubmit="return findMemberInfoFn.validateForm()">'
								+ '<input type="hidden" value="<c:out value='${findMemberId}' />" name="changeTargetId" />'	
								+ '<span>비밀번호 </span>'
								+ '<input type="password" class="form-control" id="changePw" name="changePw" onkeyup="javascript:findMemberInfoFn.checkPw()" />'
								+ '<div class="space-20"></div>'
								+ '<span>비밀번호 확인 </span>'
								+ '<input type="password" class="form-control" id="changeCheckPw" name="changePwCheck" onkeyup="javascript:findMemberInfoFn.checkPw()" />'								
								+ '<div class="space-30"></div>'
								+ '<button type="submit" class="btn btn-primary">'
									+ '비밀번호 변경하기'
								+ '</button>'
							+'</form>';
							
				$("#findPw").append(strTags);
				
				alert("인증코드가 일치합니다. 확인버튼을 누르시고 비밀번호를 입력해주세요.");
				
			} else {
				
				alert("인증코드가 일치하지 않습니다. 다시 시도해주세요.");
			}
			
		},
		checkPw : function() {

			if($("#changePw").val() != $("#changeCheckPw").val()) {
				
				if($("#changeCheck").length > 0) {
					
					$("#changeCheck").remove();
				}

				if($("#errorChangePw").length > 0) {
					
					return ;
				} else {
					
					var strTags = "<h6 id='errorChangePw'><strong><font color='red'> 비밀번호와 비밀번호확인이 다릅니다.다시 확인해주세요!</font></strong></h6>";
					
					$("#changeCheckPw").after(strTags);
					
				}
			} else {

				if($("#errorChangePw").length > 0) {
					
					$("#errorChangePw").remove();
				}


				if($("#changeCheck").length > 0) {
					
					return ;
				} else {

					var strTags = "<h6 id='changeCheck'><strong><font color='green'> 비밀번호와 비밀번호확인이 일치합니다.</font></strong></h6>";
					
					$("#changeCheckPw").after(strTags);
				}
				
			}
		},
		validateForm : function() {
				
			if($("#changePw").val() != $("#changeCheckPw").val()) {
					
				alert("비밀번호와 비밀번호 확인이 일치하지 않습니다. 다시 입력해주세요.");
				return false;
			}
				
			return true;
		}
	}
	$(document).ready(function() {

		<c:if test="${ !empty resultForFindPw }">
		
			var $ulChild = $(".nav-tabs").children();
			var $divChild = $(".tab-content").children();
			$ulChild.eq(0).removeClass("active");
			$ulChild.eq(1).addClass("active");
			
			$divChild.eq(0).removeClass("active in");
			$divChild.eq(1).addClass("active in");
		</c:if>
	});
	</script>
</body>
</html>