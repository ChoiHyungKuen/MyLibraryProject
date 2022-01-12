<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/theme.css"/>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
    <script type='text/javascript' src='//code.jquery.com/jquery-1.8.3.js'></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
    <script type='text/javascript' src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>
    <script src="calendar/bootstrap-datepicker.kr.js" charset="UTF-8"></script>
    <style>
    .dataLabel {
    	float : left;
    	width : 20%;
    }
    .dataInput {
    	float : left;
    	width : 80%;
    }
    </style>
    <script type="text/javascript">
    var changeCalendarFn = {
    		
    	commitChangeCalendar : function(editType){
    		var message;
    		if(editType == "U") {
    				
    			message="정말로 수정하시겠습니까?";
    		} else if(editType == "D") {
    				
    			message="정말로 삭제하시겠습니까?(내용 복구 불가)";
    		}
    			
    		if(confirm(message)) {
    				
    			$("#editType").val(editType);
    		
    			$("#changeCalendarForm").submit();
    		}
    	},
    	cancelChangeCalendar : function() {
    			
    		alert("취소 하셨습니다.")
    		
    		window.close();
    	},
    	checkValidation : function() {
    		if($("#changeCalendarTitle").val()=="" || $("#changeCalendarTitle").val() == " ") {
    	    		
    	    	alert("일정 제목은 필수로 적어주셔야 합니다.");
    	    		
    	    		return false;
    	    } else if($("#changeCalendarDescription").val()=="" || $("#changeCalendarDescription").val() == " ") {
    	    		
    	    	alert("일정 내용은 필수로 적어주셔야 합니다.");
    	    		
    	    	return false;
    	   	} else if(!($("#changeCalendarStartDate").val())) {
    	    		
    	    	alert("일정 시작일은 필수로 적어주셔야 합니다.");
    	    		
    	    	return false;
    	    } else if(!($("#changeCalendarEndDate").val())) {
    	    		
    	    	alert("일정 종료일은 필수로 적어주셔야 합니다.");
    	    		
    	    	return false;
    	    }
    		return true;
		}
    }
    $(document).ready(function() {
    	var isCheck = "<c:out value='${isCheck}'/>";
    	
    	if(isCheck=='Y') {
    		alert("<c:out value='${message}'/>")
    		
			opener.parent.location.reload();
    		window.close();
    	}
		
    	var manageDate = $("#manageDate",opener.document).val();
    	if(manageDate != "") {
    		
    		$("#changeCalendarStartDate").val(manageDate);
    	}
    	
    	<c:if test="${ !empty param }">
    		$("#addCalendarButtonGroup").remove();
    		
    		var strTags = '<div id="changeCalendarButtonGroup">'
						+'<a href="#" class ="btn btn-primary" style="float:left; width:32%;" onclick="javascript:changeCalendarFn.commitChangeCalendar(\'U\')">변경</a>'
						+'<a href="#" class ="btn btn-danger" style="float:left;width:32%; margin-left:5px;margin-right:5px;" '
						+ 'onclick="javascript:changeCalendarFn.commitChangeCalendar(\'D\')">삭제</a>'
						+'<a href="#" class ="btn btn-default" style="float:left; width:32%;" onclick="javascript:changeCalendarFn.cancelChangeCalendar()">취소</a>'
        				+'</div>';
    		$(".container").append(strTags);
    		$("h1").text("도서관 일정 수정 및 삭제");

    		$("#eventId").val("<c:out value='${param.id}'/>");
    		$("#changeCalendarTitle").val("<c:out value='${param.title}'/>");
    		$("#changeCalendarDescription").val("<c:out value='${param.description}'/>");
    		$("#changeCalendarStartDate").val("<c:out value='${param.start}'/>");
    		$("#changeCalendarEndDate").val("<c:out value='${param.end}'/>");
    	</c:if>
    	
    });
    
    $(function(){
        $(".input-group.date.start").datepicker({
            calendarWeeks: false,
            todayHighlight: true,
            autoclose: true,
            format: "yyyy/mm/dd",
            language: "kr"
        }).on("change", function(){
        	
	        var startDate = new Date($("#changeCalendarStartDate").val());
	        
        	if($("#changeCalendarEndDate").val() == "") {
    	        $(".input-group.date.end").datepicker("setStartDate", startDate);
    	        
        		return ;
        	}
        	
	        var endDate = new Date($("#changeCalendarEndDate").val());
	        
	        if(startDate.getTime() > endDate.getTime()) {

	        	$("#changeCalendarStartDate").val("");
	        	
		       	alert("종료날짜보다 시작날짜가 작아야합니다.");    
		       	
		     	return ;
		     }

		}); 
    });

    $(function(){
        $(".input-group.date.end").datepicker({
            calendarWeeks: false,
            todayHighlight: true,
            autoclose: true,
            format: "yyyy/mm/dd",
            language: "kr"
        }).on("change", function(){
	        var endDate = new Date($("#changeCalendarEndDate").val());
        	if($("#changeCalendarStartDate").val() == "") {

    	        $(".input-group.date.start").datepicker("setEndDate", endDate);
    	        
        		return ;
        	}
        	
	        var startDate = new Date($("#changeCalendarStartDate").val());
			/* 
	        if(endDate.getTime() > startDate.getTime()) {

	        	$("#changeCalendarStartDate").val("");
	        	$("#changeCalendarEndDate").val("");
	        	
		       	alert("종료날짜보다 시작날짜가 작아야합니다.");    
		     	return ;
		     } */
		}); 
    });
    </script>
</head>
<body>
<div class="container">
        <h1 style="text-align:center;">도서관 일정 추가</h1>
        
        <div class="space-30"></div>
     	<form id="changeCalendarForm" action="saveCalendarInfoTx.do" onsubmit="return changeCalendarFn.checkValidation()">
     	<input type="hidden" id="eventId" name="id"/>
     	<input type="hidden" id="editType" name="editType" value="I"/>
        <div class="dataLabel">제목 : </div>
     		<input type="text" class="form-control" style="width:80%" id="changeCalendarTitle" name="title"/>		
        <div class="space-30"></div>
        <div class="dataLabel">내용 : </div>
        	<textarea class="form-control" style="width:80%; resize:none; height:100px" id="changeCalendarDescription" name="description"></textarea>
        <div class="space-30"></div>
        <div class="dataLabel">시작일 : </div>
        <div class="input-group date start dataInput">
            <input type="text" class="form-control" id="changeCalendarStartDate" name="startDate"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>   	
        </div>
        <div class="space-30"></div>
       	<div class="dataLabel">종료일 : </div>
        <div class="input-group date end dataInput" >
            <input type="text" class="form-control" id="changeCalendarEndDate" name="endDate" ><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
        </div>
        <div class="space-30"></div>
        <div id="addCalendarButtonGroup">
			<button class ="btn btn-primary" type="submit" style="float:left; width:100px;margin-left:150px;">추가</button>
			<a href="#" class ="btn btn-default" onclick="javascript:changeCalendarFn.cancelChangeCalendar()" style="float:right;width:100px;margin-right:150px;">취소</a>
        </div>
        </form>
    </div>
</body>
</html>