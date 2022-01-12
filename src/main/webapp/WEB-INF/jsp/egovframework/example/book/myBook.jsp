<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
var myBook=
{
	returnBook : function(rentId, bookDetailId) {

		var rentCheck = confirm("정말로 반납하시겠습니까?");
		
		if(rentCheck) {
			
			$("#rentId").val(rentId);
			$("#bookDetailId") .val(bookDetailId);
			$("#myBookFrm").attr("action", "returnBook.do");
			$("#myBookFrm").submit();

		}
	},
	renewBook : function(memberId, bookDetailId) {
		
		var rentCheck = confirm("정말로 대출을 연장하시겠습니까?\n연기는 1회까지 가능합니다.");
		if(rentCheck) {
			
			$("#myBookMemberId").val(memberId);
			$("#bookDetailId").val(bookDetailId);
			$("#myBookFrm").attr("action", "renewBook.do");
			$("#myBookFrm").submit();
		}
	}, 
	cancelReserveBook : function(reserveId, rentId) {

		var rentCheck = confirm("정말로 예약을 취소하시겠습니까?");
		
		if(rentCheck) {
			
			$("#reserveId").val(reserveId);
			$("#rentId").val(rentId);
			$("#myBookFrm").attr("action", "cancelReserveBook.do");
			$("#myBookFrm").submit();

		}
	}
}

$(document).ready(function(){	

	var state = "<c:out value='${state}'/>";
	if(state == 'SUCCESS' || state == 'FAIL') {
		
			alert("<c:out value='${message}'/>");
			$("#myBookMemberId").val("<c:out value='${loginVO.id}'/>");
			$("#myBookFrm").attr("action", "myBook.do");
			$("#myBookFrm").submit();
	}
	
	$("body").attr("data-spy", "spyscroll");
	$("body").attr("data-target", ".navbar-default");
	$("#mainmenu ul li.active").removeClass("active");
		
	
});
</script>

<form id="myBookFrm" name="myBookFrm" method="POST">
	<input type="hidden" id="myBookMemberId"  name="memberId" />
	<input type="hidden" id="rentId"  name="rentId" />
	<input type="hidden" id="reserveId"  name="reserveId" />
	<input type="hidden" id="bookDetailId"  name="bookDetailId" />
</form>

        <!-- Header-jumbotron -->
        <div class="space-100"></div>
        <div class="header-text">
            <div class="container">
                <div class="row wow fadeInUp">
                    <div class="col-xs-12 col-sm-10 col-sm-offset-1 text-center">
                        <div class="jumbotron">
                            <h1 class="text-white">Choose Your Book and Enjoy</h1>
                        </div>
                        <div class="title-bar white">
                            <ul class="list-inline list-unstyled">
                                <li><i class="icofont icofont-square"></i></li>
                                <li><i class="icofont icofont-square"></i></li>
                            </ul>
                        </div>
                        <div class="space-40"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-100"></div>
   </nav>
        <!-- Header-jumbotron-end -->
   <section>
         <div class="space-80"></div>
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-md-10 pull-right">
                    <h1>내 서재</h1>
                    <div class="space-20"></div>
                    <hr>
                    
   						<section class="panel">
                          <header class="panel-heading tab-bg-primary ">
                              <ul class="nav nav-tabs">
                                  <li class="active">
                                      <a data-toggle="tab" href="#rent">대출현황</a>
                                  </li>
                                  <li class="">
                                      <a data-toggle="tab" href="#reserve">예약현황</a>
                                  </li>
                              </ul>
                          </header>
                          <div class="panel-body">
                              <div class="tab-content">
                                  <div id="rent" class="tab-pane active">
               						<jsp:include page="/WEB-INF/jsp/egovframework/example/book/rentBook.jsp">
               							<jsp:param name="rentBookList" value="${rentBookList }" />
               						</jsp:include>
                                  </div>
	                              <div id="reserve" class="tab-pane">    
               						<jsp:include page="/WEB-INF/jsp/egovframework/example/book/reserveBook.jsp">
               							<jsp:param name="reserveBookList" value="${reserveBookList }" />
               						</jsp:include>
                                  </div>
                              </div>
                          </div>
                      </section>
                    <div class="space-50"></div>
                </div>
              