<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
	// 받은 날짜값을 date 형태로 형변환 해주어야 한다.
	function convertDate(date) {
		var date = new Date(date);
		alert(date.yyyymmdd());
	}

	// 받은 날짜값을 YYYY-MM-DD 형태로 출력하기위한 함수.
	Date.prototype.yyyymmdd = function() {
		var yyyy = this.getFullYear().toString();
		var mm = (this.getMonth() + 1).toString();
		var dd = this.getDate().toString();
		return yyyy + "-" + (mm[1] ? mm : "0" + mm[0]) + "-"
				+ (dd[1] ? dd : "0" + dd[0]);
	}

	var calendarFn = {

		clickAddCalendar : function() {

			// 윈도우 팝업창 오픈
			var url = "changeCalendarInfoMain.do";
			var opt = "width=600, height=500";

			window.open(url, "", opt);
		},
		setCalendar : function(data) {

			var date = new Date();

			var jsonData = data;

			var d = date.getDate();
			var m = date.getMonth();
			var y = date.getFullYear();

			$("#manageCalendar").fullCalendar({
						lang : "ko",
						header : {
							left : "prev,next today",
							center : "title",
							right : "month,basicWeek,basicDay"
						},
						titleFormat : {
							month : "yyyy년 MMMM",
							week : "yyyy년 MMMM d[yyyy]{'일~'[MMM] dd일 }",
							day : "yyyy년 MMM d일 dddd"
						},
						allDayDefault : true,
						defaultView : "month",
						editable : true,
						monthNames : [ "1월", "2월", "3월", "4월", "5월", "6월",
								"7월", "8월", "9월", "10월", "11월", "12월" ],
						monthNamesShort : [ "1월", "2월", "3월", "4월", "5월", "6월",
								"7월", "8월", "9월", "10월", "11월", "12월" ],
						dayNames : [ "일요일", "월요일", "화요일", "수요일", "목요일", "금요일",
								"토요일" ],
						dayNamesShort : [ "일", "월", "화", "수", "목", "금", "토" ],
						buttonText : {
							today : "오늘",
							month : "월별",
							week : "주별",
							day : "일별",
						},
						eventLimit: true, 
						events : jsonData,
						eventClick : function(event, jsEvent, view) {
							
						},
						eventRender: function(event, element) {
						    element.bind('dblclick', function() {
								// 윈도우 팝업창 오픈
									
								var url = "changeCalendarInfoMain.do";
								var params = "?id="+event.id+"&title="+event.title +"&description="+event.description +
										"&start="+ $.fullCalendar.formatDate(event.start, "yyyy/MM/dd") +
										"&end="+ $.fullCalendar.formatDate(event.end, "yyyy/MM/dd");
								var opt = "width=600, height=500";
									
								window.open(url+params, "", opt);
								
						    });
						},
/* 
					    eventDragStart: function(event, jsEvent, ui, view) {
					        draggedEventAllDay = event.allDay;
					    },
						eventDrop: function(event,dayDelta,minuteDelta,allDay,revertFunc) {

					        alert(
					            event.title + " was moved " +
					            dayDelta + " days and " +
					            minuteDelta + " minutes."
					        );

					        if (allDay) {
					            alert("Event is now all-day");
					        }else{
					            alert("Event has a time-of-day");
					        }

					        if (!confirm("Are you sure about this change?")) {
					            revertFunc();
					        }

					    }, */
					});

			/* 
			 // 왼쪽 버튼을 클릭하였을 경우
			 $("button.fc-prev-button.fc-button.fc-state-default.fc-corner-left").click(function() {
			 alert("?");
			 var date = $("#calendar").fullCalendar("getDate");
			 convertDate(date);
			 });

			 // 오른쪽 버튼을 클릭하였을 경우
			 $("button.fc-next-button.fc-button.fc-state-default.fc-corner-right").click(function() {
			 var date = $("#calendar").fullCalendar("getDate");
			 convertDate(date);
			 }); */
		}
	}

	// 메인에서 사용하는 AJAX를 묶어놓음
	var calendarAjaxFn = {

		initCalendarAjaxCallFn : function() {

			$.ajax({
				type : "POST",
				url : "initCalendar.do",
				success : function(result) {
					var jsonRes = JSON.parse(result);
					var resArr = [];
					$.each(jsonRes, function(i, item) {

						var transData = {};

						transData.id = item.id;
						
						transData.title = item.title;

						transData.start = item.startDate;
						transData.end = item.endDate;
						transData.description = item.description;

						resArr[i] = transData;
					});

					calendarFn.setCalendar(resArr);

				},
				error : function(request, status, error) {

					alert("달력 로딩 실패");

				}
			});
		}
	}

	$(document).ready(function() {

		calendarAjaxFn.initCalendarAjaxCallFn();
		
		  $(".input-group.date").datepicker({
	            calendarWeeks: false,
	            todayHighlight: true,
	            autoclose: true,
	            format: "yyyy/mm/dd",
	            language: "kr"
	            
		 }).on("change", function(){
		
	        var d = new Date($("#manageDate").val());
	        $("#manageCalendar").fullCalendar('gotoDate', d);
		 }); 
	});
</script>

<div class="col-lg-12">
	<h4 class="page-header">
		<i class="fa fa-calendar"></i> 도서관 일정 관리
	</h4>
	<ol class="breadcrumb">
		<li><i class="fa fa-home"></i><a href="#" onclick="javascript:adminLeftFn.pageSubmitFn('admin-main')">Home</a></li>
		<li><i class="fa fa-calendar"></i>도서관 일정 관리</li>
	</ol>
</div>
<div class="col-lg-12">
	<a href="#" class="btn btn-info" onclick="javascript:calendarFn.clickAddCalendar()">일정 추가</a>
	<span><i class="fa fa-question-circle fa-lg" aria-hidden="true"
			 title="일정을 수정하거나 삭제하고 싶으면 일정이 표기된 막대기를 더블클릭하시면 됩니다."></i></span>	
    <div class="space-20"></div>
    <div style="float:left;width:10%;margin-top:5px;">날짜 검색 </div>  
    <div class="input-group date" style="float:left;width:30%;">
    <div style="float:left;width:60%"></div>  
    	<input type="text" class="form-control" id="manageDate"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
   	</div>
        
        <div class="space-50"></div>
	<div id="manageCalendar"></div>
</div>
<!--  search form end -->