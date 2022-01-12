<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="css/button.css">
     <!-- Bootstrap CSS -->    
    <link href="css/admin-css/bootstrap.min.css" rel="stylesheet">
    <!-- bootstrap theme -->
    <link href="css/admin-css/bootstrap-theme.css" rel="stylesheet">
    <!--external css-->
    <!-- font icon -->
    <link href="css/admin-css/elegant-icons-style.css" rel="stylesheet" />
    <link href="css/admin-css/font-awesome.min.css" rel="stylesheet" />    
    <!-- easy pie chart-->
    <link href="assets/jquery-easy-pie-chart/jquery.easy-pie-chart.css" rel="stylesheet" type="text/css" media="screen"/>
    <!-- owl carousel -->
    <link rel="stylesheet" href="css/admin-css/owl.carousel.css" type="text/css">
	<link href="css/admin-css/jquery-jvectormap-1.2.2.css" rel="stylesheet">
    <!-- Custom styles -->
	<link rel="stylesheet" href="css/admin-css/fullcalendar.css">
	<link href="css/admin-css/widgets.css" rel="stylesheet"> 
    <link href="css/admin-css/style.css" rel="stylesheet"> 
    <link href="css/admin-css/style-responsive.css" rel="stylesheet" />
	<link href="css/admin-css/xcharts.min.css" rel=" stylesheet">	 
	
    <link rel="stylesheet" href="css/join.css">
	<link href="css/admin-css/jquery-ui-1.10.4.min.css" rel="stylesheet"> 
  	<!-- javascripts -->
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="js/jquery-ui-1.10.4.min.js"></script>
    <script src="js/jquery.js"></script> 
    
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<title>나의 정보</title>
</head>
<body>
<p>
<div class="col-lg-12">
	<section class="panel">
		<header class="panel-heading"> 회원 정보 </header>
		<div class="panel-body">
			<div class="form">
				<form class="form-validate form-horizontal" id="changeMemberInfoForm"
					 action="changeMemberInfo.do" method="post" onsubmit="return validateForm()">
					 
				<input type="hidden" name="changeMemberId" value="<c:out value="${ memberInfoMap.memberId }"/>"/>
					<div class="form-group ">
						<div class="col-lg-10" id="profileName">
						<label class="control-label col-lg-2" for="profileName"> 이름 
						</label>
							<c:out value="${ memberInfoMap.name }"/>
						</div>
					</div>
					<div class="form-group ">
						<div class="col-lg-10" id="profileID">
						<label class="control-label col-lg-2" for="profileID"> ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						</label>	
							<c:out value="${ memberInfoMap.memberId }"/>
						</div>
					</div>
					<div class="form-group ">
						<label class="control-label col-lg-2" for="profilePassword"> 비밀번호 
						</label>
						<div class="col-lg-10">
							<input class="form-control" id="profilePassword" type="password" name="password" title="비밀번호"/>
						</div>
					</div>
					<div class="form-group ">
						<label class="control-label col-lg-2" for="profileEmail"> 이메일
						</label>
						<div class="col-lg-10">
							<input class="form-control" style="display:inline;width:200px;" id="profileEmail" name="emailId" type="text" title="이메일 ID"/> @
							<input class="form-control" type="text" name="emailAddress" id="profileEmailAddress" style="display:inline;width:150px;" readonly="true" value="naver.com" title="이메일 주소" />			
							<select onchange="changeEmailAdress()" class="form-control" style="display:inline;width:200px;" id="profileSelectEmailAddress">
								<option value="user">직접 입력</option>
								<option value="naver.com" selected>naver.com</option>
								<option value="daum.net">daum.net</option>
								<option value="gmail.com">gmail.com</option>
							</select> 
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-lg-2" for="profilePhone" > 핸드폰 </label>
						<div class="col-lg-10">
							<input class="form-control" id="profilePhone" type="text" name="phone" title="핸드폰"/>
						</div>
					</div>
					<div class="form-group">
					<label class="control-label col-lg-2" style="margin-right:13px;" for="profilePostCode">주소
					</label>
						<input class="form-control" style="display:inline;width:100px;" type="text" id="profilePostCode" name="postCode" title="주소"/>
						<input type="button"class="form-control" onclick="execDaumPostcode()" style="display:inline;width:130px;" value="우편번호 찾기" /><p>
						
						<input type="text" class="form-control" id="profileRoadAddress" style="margin-top:10px; margin-left:10px; display:inline;width:250px;" name="roadAddress" />
						<input type="text" class="form-control" id="profileJibunAddress" style="margin-top:10px; display:inline;width:250px;" name="jibunAddress"/>
						
						<span id="guide" style="color:#999"></span>
					</div>
					<div class="form-group" >
						<div class="col-lg-offset-4 col-lg-10" >
							<button class="btn_order" style="margin:10px;" type="submit">변 경 하 기</button>
							<button class="btn_cancel1" style="margin:10px;" type="button" onclick="cancelRegisterMember()">취 소 하 기</button>
						</div>
					</div>
				</form>
			</div>

		</div>
	</section>
</div>


<script type="text/javascript"> 

function validateForm() {
	var validator = true;
	
	$("form input").each(function(index){
		
		if($(this).val() == "") {

			validator=false;
			
			alert($(this).attr("title")+"은(는) 필수 입력사항 입니다.");
			
			$(this).focus();
			
			return false;
		}
	});
	
	if($("#profileRoadAddress").val() == "" && $("#profileJibunAddress").val() == "" ) {
		
		alert("지번주소 혹은 도로명 주소 둘 중 한개는 입력하셔야 합니다.");
		validator=false;
	}
	
	if($("#profilePassword").val().length <5 || $("#profilePassword").val().length > 10 ) {
		
		alert("비밀번호는 5자리 이상 10자리까지 허용됩니다.");
		validator=false;
	}
		
	return validator;
}
// 다음에서 제공하는 주소 검색 API 이용
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 도로명 조합형 주소 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }
            // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
            if(fullRoadAddr !== ''){
                fullRoadAddr += extraRoadAddr;
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('bPostCode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('bRoadAddress').value = fullRoadAddr;
            document.getElementById('bJibunAddress').value = data.jibunAddress;

            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                //예상되는 도로명 주소에 조합형 주소를 추가한다.
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

            } else {
                document.getElementById('guide').innerHTML = '';
            }
        }
    }).open();
}
// 이메일 주소 바뀔 때 입력창 값 변경해 주고(사용자 입력X) 직접입력을 선택하면 사용자가 입력할 수 있게 해주는 함수
function changeEmailAdress() {

	$("#profileSelectEmailAddress option:selected").each(function() {

		if ($(this).val() == 'user') { //직접입력일 경우

			$("#profileEmailAddress").val(''); //값 초기화

			$("#profileEmailAddress").removeAttr("readonly"); //활성화
		} else { //직접입력이 아닐경우

			$("#profileEmailAddress").val($(this).text()); //선택값 입력

			$("#profileEmailAddress").attr("readonly", "readonly");//비활성화
		}
	});
}

$(document).ready(function() {

    $("#profileSelectEmailAddress").val("user").attr("selected", true);
	$("#profileEmail").val("<c:out value='${ memberInfoMap.emailId }' />");
	$("#profileEmailAddress").val("<c:out value='${ memberInfoMap.emailAddress }' />").removeAttr("readonly");
	$("#profilePhone").val("<c:out value='${ memberInfoMap.phone }' />");
	$("#profilePostCode").val("<c:out value='${ memberInfoMap.postCode }' />");
	$("#profileRoadAddress").val("<c:out value='${ memberInfoMap.roadAddress }' />");
	$("#profileJibunAddress").val("<c:out value='${ memberInfoMap.jibunAddress }' />");
});

function cancelRegisterMember() {
	
    window.close();
    
}	
</script>
</body>
</html>