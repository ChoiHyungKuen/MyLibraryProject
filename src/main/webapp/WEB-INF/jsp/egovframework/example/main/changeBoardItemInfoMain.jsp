<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
    var changeBoardItemFn = {
    		commitChangeBoardItem : function(editType){
    			var message;
    			if(editType == "U") {
    				
    				message="정말로 수정하시겠습니까?";
    			} else if(editType == "D") {
    				
    				message="정말로 삭제하시겠습니까?(내용 복구 불가)";
    			}
    			
    			if(confirm(message)) {
    				
    				$("#boardEditType").val(editType);
    				$("#changeBoardForm").submit();
    			}
    		},
    		cancelChangeBoardItem : function() {
    			
    			alert("취소 하셨습니다.");
    			window.close();
    		}, 
    		// 이메일 주소 바뀔 때 입력창 값 변경해 주고(사용자 입력X) 직접입력을 선택하면 사용자가 입력할 수 있게 해주는 함수
    		changeType : function() {

    			$("#selectBoardItemType option:selected").each(function() {

    				if ($(this).val() == 'user') { //직접입력일 경우

    					$("#changeBoardItemType").val(''); //값 초기화

    					$("#changeBoardItemType").removeAttr("readonly"); //활성화
    				} else { //직접입력이 아닐경우

    					$("#changeBoardItemType").val($(this).text()); //선택값 입력

    					$("#changeBoardItemType").attr("readonly", "readonly");//비활성화
    				}
    			});
    		}, 
    	    checkValidation : function() {
    	    	if($("#changeBoardItemTitle").val()=="" || $("#changeBoardItemTitle").val() == " ") {
    	    		
    	    		alert("게시판 제목은 필수로 적어주셔야 합니다.");
    	    		
    	    		return false;
    	    	} else if($("#changeBoardItemContent").val()=="" || $("#changeBoardItemContent").val() == " ") {
    	    		
    	    		alert("게시판 내용은 필수로 적어주셔야 합니다.");
    	    		
    	    		return false;
    	    	}

    	      	var file = $("#changeBoardItemImg").val();
    	      	var FileFilter = /\.(jpg|gif|png)$/i;
    	      	var extArray = new Array(".jpg", ".gif", ".png");   
    	      	var bSubmitCheck = false;
    	        
    	      	if(file){ 
    	    	      
    	      		if(file.match(FileFilter)) { 
    	      			
    	        		bSubmitCheck = true;
    	      		}	
    	      
    	      		if (bSubmitCheck) {
    	      			
    	      			return true;
    	      	 	} else {
    	      	 		
    	        	 	alert("다음 확장자의 파일만 업로드가 가능합니다.\n\n"  + (extArray.join("  ")) + "\n\n 업로드할 파일을 "
    	        	 		+ " 다시 선택하여 주세요.");
    	        	 	return false;
    	       		}
    	    		
    	      	}
    	    	return true;
    	    }
    }
    $("document").ready(function() {
    	var isCheck = "<c:out value='${isCheck}'/>";
    	
    	if(isCheck=='Y') {
    		alert("<c:out value='${message}'/>")
    		
    		if("<c:out value='${state}'/>" == 'delete') {
					
    			window.close();

    			opener.libroInfoBoardFn.viewLibroInfoBoardList();
    			opener.mainAjaxFn.ajaxCallFn({
    				url : "libroBoardList.do?page=" + $("boardPageInfo").val(),
    				state : "load"
    			});
    			
    			opener.mainAjaxFn.initCalendarAjaxCallFn();
    		} else {
				opener.parent.location.reload();
    			window.close();
    		}
    	}
		<c:choose>
			<c:when test="${ empty param.memberId }">
				$("#addBoardButtonGroup").remove();
    		
    			var strTags = '<div id="changeBoardButtonGroup">'
								+'<a href="#" class ="btn btn-primary" style="float:left; width:32%;" onclick="javascript:changeBoardItemFn.commitChangeBoardItem(\'U\')">변경</a>'
								+'<a href="#" class ="btn btn-danger" style="float:left;width:32%; margin-left:5px;margin-right:5px;" '
									+ 'onclick="javascript:changeBoardItemFn.commitChangeBoardItem(\'D\')">삭제</a>'
								+'<a href="#" class ="btn btn-default" style="float:left; width:32%;" onclick="javascript:changeBoardItemFn.cancelChangeBoardItem()">취소</a>'
        					+'</div>';        				
    			$(".container").append(strTags);
    			$("h1").text("도서관 게시판 글 수정 및 삭제");

    			$("#changeBoardItemNo").val("<c:out value='${param.no}'/>");
    			$("#changeBoardItemTitle").val("<c:out value='${param.title}'/>");
    			$("#changeBoardItemContent").val("<c:out value='${param.content}'/>");
    			$("#changeBoardItemType").val("<c:out value='${param.type}'/>");
    			$("#changeBoardItemEventDate").val("<c:out value='${param.eventDate}'/>"); 
    			$("#boardPageInfo").val("<c:out value='${param.page}'/>"); 
			</c:when>
			<c:otherwise>
				$("#loginId").val("<c:out value='${param.memberId}'/>");
			</c:otherwise>
		</c:choose>
    	
    });
    $(function(){
        $(".input-group.date").datepicker({
            calendarWeeks: false,
            todayHighlight: true,
            autoclose: true,
            format: "yyyy/mm/dd",
            language: "kr"
        });
    });
    
    </script>
</head>
<body>
<div class="container">
        <h1 style="text-align:center;">도서관 정보게시판 글 추가</h1>
     	<input type="hidden" id="boardPageInfo" name="page"/>      
        <div class="space-30"></div>
     	<form id="changeBoardForm" action="saveBoardItemInfoTx.do" method="post" enctype="multipart/form-data" onsubmit="return changeBoardItemFn.checkValidation()">
     	<input type="hidden" id="changeBoardItemNo" name="no"/>
     	<input type="hidden" id="loginId" name="memberId"/>
     	<input type="hidden" id="boardEditType" name="editType" value="I"/>
        <div class="dataLabel">제목 : </div>
     		<input type="text" class="form-control" style="width:80%" id="changeBoardItemTitle" name="title"/>		
        <div class="space-30"></div>
        <div class="dataLabel">내용 : </div>
        	<textarea class="form-control" style="width:80%; resize:none; height:100px" id="changeBoardItemContent" name="content"></textarea>
        <div class="space-40"></div>
        <div class="dataLabel">종류 : </div>
        	<select class="form-control" style="width:80%;" id="selectBoardItemType" onchange="javascript:changeBoardItemFn.changeType()">
        		<option value="user">직접입력</option>
        		<option value="정보" selected>정보</option>
        		<option value="행사">행사</option>
        	</select>       
        <div class="space-20"></div>
        <div class="dataLabel"></div>
     	<input type="text" class="form-control" style="float:right;width:80%" id="changeBoardItemType" name="type" readonly="true" value="정보">		
        <div class="space-20"></div>
       	<div><strong>※ 아래 두 항목은 선택사항 입니다.</strong> </div>
       	<div class="space-10"></div>
        <div class="dataLabel">일자 : </div>
        <div class="input-group date dataInput">
            <input type="text" class="form-control" id="changeBoardItemDate" name="eventDate"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>   	
        </div>
        <div class="space-20"></div>
        <div class="dataLabel">사진업로드 : </div>
        <input type="file" class="form-control" style="width:80%" id="changeBoardItemImg" name="imgDes" accept="image/gif, image/jpeg, image/png">   	
        
        <div class="space-30"></div>
        <div id="addBoardButtonGroup">
			<button class ="btn btn-primary" type="submit" style="float:left; width:100px;margin-left:150px;">추가</button>
			<a href="#" class ="btn btn-default" onclick="javascript:changeBoardItemFn.cancelChangeBoardItem ()" style="float:right;width:100px;margin-right:150px;">취소</a>
        </div>
        </form>
    </div>
</body>
</html>