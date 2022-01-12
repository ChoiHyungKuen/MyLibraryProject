<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <link rel="stylesheet" href="css/button.css">
     <!-- Bootstrap CSS -->    
    <link href="css/admin-css/bootstrap.min.css" rel="stylesheet">
    <!-- bootstrap theme -->
    <link href="css/admin-css/bootstrap-theme.css" rel="stylesheet">
    <!--external css-->
    <!-- font icon -->
    <link href="css/admin-css/elegant-icons-style.css" rel="stylesheet" />
    <link href="css/admin-css/font-awesome.min.css" rel="stylesheet" />    
    <!-- full calendar css-->
    <link href="assets/fullcalendar/fullcalendar/bootstrap-fullcalendar.css" rel="stylesheet" />
	<link href="assets/fullcalendar/fullcalendar/fullcalendar.css" rel="stylesheet" />
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
    
    <script src="js/jquery.alphanum.js"></script> 
   	<!-- JqGrid css & script -->
	<link href="jqgrid/css/ui.jqgrid.css" rel="stylesheet" type="text/css">
   	<script src="jqgrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>
   	<script type="text/javascript" src="jqgrid/js/i18n/grid.locale-kr.js"></script>
    <!-- Jquery-ui css & script -->
    <link href="jqgrid/jquery-ui/jquery-ui.css" rel="stylesheet" type="text/css">
    <link href="jqgrid/jquery-ui/jquery-ui.js" rel="stylesheet" type="text/css">
             
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
</head>
<body>
<p>
      <center><div class="stepLine">
        <div title="이용약관" class="stepDot"></div>
        <div title="정보입력" class="stepDot activeStep"></div>
        <div title="가입완료" class="stepDot"></div>
      </div>
      </center><br><br>
<div class="col-lg-12">
	<section class="panel">
		<header class="panel-heading"> 회원 정보 기입 폼 </header>
		<div class="panel-body">
			<div class="form">
				<form:form commandName="memberVO" class="form-validate form-horizontal" id="memberInfoForm"
					 action="memberInfoCheck.do" method="post" onsubmit="return validateForm()">
					<div class="form-group ">
						<label class="control-label col-lg-2" for="bName"> 이름 
						<span class="required">*</span>
						</label>
						<div class="col-lg-10">
							<form:input path="name" class="form-control" id="bName" type="text" />
							<form:errors path="name"/>
						</div>
					</div>
					<div class="form-group ">
						<label class="control-label col-lg-2" for="bID"> ID 
							<span class="required">*</span>
						</label>	
						<div class="col-lg-10">
							<form:input path="memberId" class="form-control" id="bID" type="text" 
										onchange="changeInputId()" style="display:inline;width:250px;margin-right:10px;"/>
							
							<input type="button"class="form-control" onclick="checkDuplId()" style="display:inline;width:120px;" value="중복체크" /><p>
							<input type="hidden" id="idCheck" value="N" />
							
							<form:errors path="memberId"/>
							
						</div>
					</div>
					<div class="form-group ">
						<label class="control-label col-lg-2" for="bPassword"> 비밀번호 
							<span class="required">*</span>
						</label>
						<div class="col-lg-10">
							<form:input path="password" class="form-control" id="bPassword" type="password" onkeyup="checkPw()" />
							<form:errors path="password"/>
						</div>
					</div>
					<div class="form-group ">
						<label class="control-label col-lg-2" for="bPassword"> 비밀번호 확인
							<span class="required">*</span>
						</label>
						<div class="col-lg-10">
							<input class="form-control" id="bCheckPassword" type="password" onkeyup="checkPw()" />
						</div>
					</div>
					<div class="form-group ">
						<label class="control-label col-lg-2" for="bEmail"> 이메일 
							<span class="required">*</span>(비밀번호 찾는데 필요합니다. 정확하게 적어주세요!)
						</label>
						<div class="col-lg-10">
							<form:input path="emailId" class="form-control" style="display:inline;width:200px;" id="bEmail" type="text" /> @
							<form:input path="emailAddress" class="form-control" type="text" name="bEmailAddress" id="bEmailAddress" 
									style="display:inline;width:150px;" readonly="true" value="naver.com" />			
							<select onchange="changeEmailAdress()" class="form-control" style="display:inline;width:200px;" id="bSelectEmailAddress">
								<option value="user">직접 입력</option>
								<option value="naver.com" selected>naver.com</option>
								<option value="daum.net">daum.net</option>
								<option value="gmail.com">gmail.com</option>
							</select> 
							<form:errors path="emailId"/>
							<form:errors path="emailAddress"/>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-lg-2" for="bPage"> 핸드폰 (하이픈 [-] 없이 적어주세요.)</label>
						<div class="col-lg-10">
							<form:input path="phone" class="form-control" id="bPhone" type="text" />
							<form:errors path="phone"/>
						</div>
					</div>
					<div class="form-group">
					<label class="control-label col-lg-2" style="margin-right:13px;" for="bPostCode">주소
						<span class="required">*</span> 
					</label>
						<form:input path="postCode" class="form-control" style="display:inline;width:100px;" type="text" id="bPostCode" placeholder="우편번호"/>
						<input type="button"class="form-control" onclick="execDaumPostcode()" style="display:inline;width:130px;" value="우편번호 찾기" /><p>
						
						<form:input path="roadAddress" type="text" class="form-control" id="bRoadAddress" placeholder="도로명주소" style="margin-top:10px; margin-left:10px; display:inline;width:250px;" />
						<form:input path="jibunAddress" type="text" class="form-control" id="bJibunAddress" placeholder="지번주소" style="margin-top:10px; display:inline;width:250px;"/>
						
						<form:errors path="postCode" />
						<form:errors path="roadAddress" />
						<form:errors path="jibunAddress" />
						<span id="guide" style="color:#999"></span>
					</div>
					<div class="form-group" >
						<div class="col-lg-offset-4 col-lg-10" >
							<button class="btn_order" style="margin:10px;" type="submit">회 원 가 입</button>
							<button class="btn_cancel1" style="margin:10px;" type="button" onclick="cancelRegisterMember()">취 소 하 기</button>
						</div>
					</div>
				</form:form>
			</div>

		</div>
	</section>
</div>


<script type="text/javascript"> 

function checkDuplId() {

	var checkId = $('#bID').val();
	  
	if(checkId == ""){
		  
		alert("ID를 입력해주세요.");
		return;
	}

	if((checkId.length < 5) || (checkId.length > 15)) {
		
		alert("ID는 5자리 이상 15자리 미만으로 적어주셔야 합니다.");
		return;
	}
    $.ajax({
       
         type          : "POST",
         url           : "checkDuplId.do",
         data      	   : {"checkId" : checkId },
         async         : false,
         success       : function(result) {

   	      if(result == 0){
   	       	
   	    	alert("등록 가능 합니다.");
   	    	$("#idCheck").val("Y");
   	      }else{
   	    	  
   	       	alert("중복된 ID가 있습니다.");
   	    	$("#idCheck").val("N");
   	      }
         },
         error      : function() {
            
            alert("중복체크 중 에러가 발생했습니다.");
         }
     });  

}
function checkPw() {

	if($("#bPassword").val() != $("#bCheckPassword").val()) {
		
		if($("#checkPw").length > 0) {
			
			$("#checkPw").remove();
		}

		if($("#errorPw").length > 0) {
			
			return ;
		} else {
			
			var strTags = "<h6 id='errorPw'><strong><font color='red'> 비밀번호와 비밀번호확인이 다릅니다.다시 확인해주세요!</font></strong></h6>";
			
			$("#bCheckPassword").after(strTags);
			
		}
	} else {

		if($("#errorPw").length > 0) {
			
			$("#errorPw").remove();
		}


		if($("#checkPw").length > 0) {
			
			return ;
		} else {

			var strTags = "<h6 id='checkPw'><strong><font color='green'> 비밀번호와 비밀번호확인이 일치합니다.</font></strong></h6>";
			
			$("#bCheckPassword").after(strTags);
		}
		
	}
}
function validateForm() {

	if($("#idCheck").val() == 'N') {
		
		alert("중복확인 체크를 해주세요.");
		return false;
	}
	
	if($("#bPassword").val() != $("#bCheckPassword").val()) {
		
		alert("비밀번호와 비밀번호 확인이 일치하지 않습니다. 다시 입력해주세요.");
		return false;
	}
	
	return true;
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

	$("#bSelectEmailAddress option:selected").each(function() {

		if ($(this).val() == 'user') { //직접입력일 경우

			$("#bEmailAddress").val(''); //값 초기화

			$("#bEmailAddress").removeAttr("readonly"); //활성화
		} else { //직접입력이 아닐경우

			$("#bEmailAddress").val($(this).text()); //선택값 입력

			$("#bEmailAddress").attr("readonly", "readonly");//비활성화
		}
	});
}
function changeInputId() {
	
	$("#idCheck").val("N");
}

$(document).ready(function() {

	$("#bPhone").numeric("positiveInteger");
	
	var isCheck = "<c:out value='${isCheck}' />";
	
	if(isCheck=='N') {
		
		alert("현재 잘못 기입된 것이 있습니다. 다시 한번 확인해주세요.");
	}
	if(opener != null) { // 사이트에서 회원가입으로 들어온 경우(로그인에서 들어온 경우면 opener에서 에러남)
		
		var $name = $("#registerName",opener.document).val();
		var $email = $("#registerEmail",opener.document).val();
	
		if($name != '') {
		
			$("#bName").val($name);
		}

		if($email !='') {
		
			if($email.indexOf("@") != -1) {
			
		   		var idx = $email.indexOf("@");   
			 	var emailId = $email.substring(0, idx);
				var emailAddress = $email.substring(idx+1, $email.length);

				$("#bEmail").val(emailId);

				$("#bEmailAddress").val(emailAddress);
				$("#bEmailAddress").removeAttr("readonly");
				$("#bSelectEmailAddress").val("user");
			} else {
			
				$("#bEmail").val($email);
			}
		} else {

			$("#bEmailAddress").val("naver.com");
		}
	}
	// 윈도우 팝업창 오픈
	$("#defaultBtId").click(function() {
		
		var url = "loginView.do";
		var opt = "width=650, height=400";
		
		window.open(url, "", opt);
	});
});

function cancelRegisterMember() {
	
	alert("가입을 취소하셨습니다.");
    window.close();
    
}	
</script>
</body>
</html>