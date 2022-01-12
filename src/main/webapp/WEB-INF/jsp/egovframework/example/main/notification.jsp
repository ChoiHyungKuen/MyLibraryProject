<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link href="css/admin-css/bootstrap.min.css" rel="stylesheet">
<!-- bootstrap theme -->
<link href="css/admin-css/bootstrap-theme.css" rel="stylesheet">
<!--external css-->
<!-- font icon -->
<link href="css/admin-css/elegant-icons-style.css" rel="stylesheet" />
<link href="css/admin-css/font-awesome.min.css" rel="stylesheet" />
<!-- easy pie chart-->
<link href="assets/jquery-easy-pie-chart/jquery.easy-pie-chart.css" rel="stylesheet" type="text/css" media="screen" />
<!-- owl carousel -->
<link rel="stylesheet" href="css/admin-css/owl.carousel.css" type="text/css">
<link href="css/admin-css/jquery-jvectormap-1.2.2.css" rel="stylesheet">
<!-- Custom styles -->
<link rel="stylesheet" href="css/admin-css/fullcalendar.css">
<link href="css/admin-css/widgets.css" rel="stylesheet">
<link href="css/admin-css/style.css" rel="stylesheet">
<link href="css/admin-css/style-responsive.css" rel="stylesheet" />
<link href="css/admin-css/xcharts.min.css" rel=" stylesheet">

<link href="css/admin-css/jquery-ui-1.10.4.min.css" rel="stylesheet">
<!-- javascripts -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="js/jquery-ui-1.10.4.min.js"></script>
<script src="js/jquery.js"></script>

<html>
</head>
<body>
	<form id="notificationFrm" action="removeNotification.do">
	<input type="hidden" id="notificationId" name="notificationId" />
	<input type="hidden" id="notificationMemberId" name="memberId" />
	</form>
	<div class="row">
		<div class="col-lg-12">
			<section class="panel">
				<header class="panel-heading"> 도서관 알리미 </header>
				<div class="panel-body">
					<div class="panel panel-info">
						<div class="panel-heading">
							<c:out value="${loginVO.name }" />
							님에게 온 메시지
						</div>
						<c:forEach var="notification" items="${ notification }">
							<div class="panel-content">
								<div class ="space-20"></div>
								<c:out value="${ notification.content }" />
								<div class ="space-20"></div>
								<c:out value="${ notification.createdDate }" />
								<a style="float:right;" class="btn btn-danger" onclick="javascript:removeNotification('<c:out value="${notification.id}" />','<c:out value="${loginVO.id }" />')">메시지 제거</a>
							</div>
							<hr>
						</c:forEach>
					</div>
				</div>
			</section>
		</div>
	</div>
	<script type="text/javascript">
	function removeNotification(notificationId, memberId) {
		
		if(confirm("정말로 메시지를 지우시겠습니까? 지우시면 다시 확인하실 수 없습니다.")) {

			$("#notificationId").val(notificationId);	
			$("#notificationMemberId").val(memberId);	
			$("#notificationFrm").submit();	
		}
	}

	$(document).ready(function() {
		
		if("<c:out value='${isCheck}'/>" == "Y") {
			
			alert("<c:out value='${message}'/>");
			opener.parent.location.reload();
		}

	});
	</script>
</body>
</html>