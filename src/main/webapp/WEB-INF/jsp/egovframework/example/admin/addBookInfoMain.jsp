<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<style>

textarea.autosize { min-height: 50px; }
</style>
<script type="text/javascript">
var addBookInfoFn = {
		
	getBookInfoFromNaver : function()	{
		
		if($("#searchKeyword").val().length <= 0) {
			
			alert("한 글자 이상은 적어주셔야 합니다.");
		}
		addBookAjaxFn.ajaxCallFn({url : "parsingBookInfoFromNaver.do",searchStr : $("#searchKeyword").val()});

	}, 
	changeBookState : function() {

		$("#bState option:selected").each(function() {

			if ($(this).val() == '대출중') { 
				
				$("#bReturnTerm").removeAttr("readonly"); //활성화
			} else { //직접입력이 아닐경우

				$("#bReturnTerm").attr("readonly", "readonly");//비활성화
			}
		});
	}

}

var addBookAjaxFn = 
{
	ajaxCallFn : function(options) {
		
	    var settings = {
		         
		         url 	: "parsingBookInfoFromNaver.do",
		         searchStr  : ""
		      }
		      
		      settings = $.extend({}, settings, options);
		   
		      $.ajax({
		         
		           type          : "POST",
		           url           : settings.url,
		           data      	 : {"searchStr" : settings.searchStr },
		           async         : false,
		           success    : function(result) {
		              
		            	var jsonRes = JSON.parse(result);
		            	
		            	
		            	if(jsonRes.error) {
		            		
 							alert(jsonRes.error);
		            	} else {
		            	
		            		$("#bTitle").val(jsonRes.title);
		            		$("#bAuthor").val(jsonRes.author);
		            		$("#bPublisher").val(jsonRes.publisher);
		            		$("#bPublishDate").val(jsonRes.publishDate);
		            		$("#bPage").val(jsonRes.page);
		            		$("#bContent").val(jsonRes.content).trigger('change');
		            	}
		           },
		           error      : function() {
		              
		              alert("검색하신 책을 찾을 수 없습니다. 정확하게 입력해주세요.");
		           }
		       }); 
		}
		   
}
$(function() {
	
	$("#inputBookImg").on('change', function(){

    	readURL(this);
    
	});
});
function readURL(input) {
    
	if (input.files && input.files[0]) {
		
    var reader = new FileReader();
    
    reader.onload = function (e) {
	
    	$('#uploadImg').attr('src', e.target.result);
        }

      reader.readAsDataURL(input.files[0]);

  	$("#uploadImg").show();
    }
}

function autoChangeTextareaSize(obj, bsize) { // 객체, 기본사이즈
	
    var sTextarea = document.getElementById(obj);
    
    var csize = (sTextarea.scrollHeight >= bsize) ? sTextarea.scrollHeight+"px" : bsize+"px";
    
    sTextarea.style.height = bsize+"px"; 
    
    sTextarea.style.height = csize;
}

function beforeChangeBgCheck() {

	var file = $("#inputBookImg").val();
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
	

	if(/^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/.test($("#bPublishDate").val())) {
	
		return true;
	} else if(/^(19|20)\d{2}.(0[1-9]|1[012]).(0[1-9]|[12][0-9]|3[0-1])$/.test($("#bPublishDate").val())) {
		
		return true;
	} else {
		
		alert("출판일은 날짜형식으로 yyyy-mm-dd 이거나 yyyy.mm.dd 와 같은 형식을 사용하셔야 합니다.");
		return false;
	}

	if(/^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/.test($("#returnTerm").val())) {
	
		return true;
	} else if(/^(19|20)\d{2}.(0[1-9]|1[012]).(0[1-9]|[12][0-9]|3[0-1])$/.test($("#returnTerm").val())) {
		
		return true;
	} else {
		
		alert("반납일은 날짜형식으로 yyyy-mm-dd 이거나 yyyy.mm.dd 와 같은 형식을 사용하셔야 합니다.");
		return false;
	}
}
$(document).ready(function(){	

	$("#searchKeyword").keydown(function(key) {

		if (key.keyCode == 13) {
			
			addBookInfoFn.getBookInfoFromNaver();
		}

	});
	
	$("#uploadImg").hide();
	
	var isCheck ="<c:out value='${isCheck}' />";

	if(isCheck == 'N'){
		
		alert("내용이 잘못 기입되었거나 한 개 이상의 책을 등록하지 않았습니다.(청구기호 미작성) 다시 확인 해주세요.");
	}
	
	if(isCheck == 'Y') {
		
		alert("책이 성공적으로 추가 되었습니다.");
	} 
	
}); 
</script>

<div class="row">
	<div class="col-lg-12">
		<h4 class="page-header">
			<i class="fa fa-book"></i> 도서 관리
		</h4>
		<ol class="breadcrumb">
			<li><i class="fa fa-home"></i><a href="#" onclick="javascript:adminLeftFn.pageSubmitFn('admin-main')">Home</a></li>
			<li><i class="fa fa-book"></i>도서 관리</li>
			<li><i class="fa fa-search-plus"></i>도서 추가</li>
		</ol>
	</div>
</div>
<div class="col-lg-12">
	<form class="navbar-form" onsubmit="return false;">
		<h4>네이버 책 검색으로 책을 추가해보세요.</h4>
		<input class="form-control" id="searchKeyword" name="searchKeyword"
			placeholder="책 제목을 입력해주세요." type="text" /> <a class="btn btn-primary"
			style="margin-right: 10px;"
			onclick="javascript:addBookInfoFn.getBookInfoFromNaver()">검색</a> 
			<i class="fa fa-question-circle fa-lg" aria-hidden="true"
			   title="네이버를 이용해 책을 검색할 수 있습니다. 네이버 책 검색 사이트 맨 처음 매칭 된 1개만 가져옵니다. 그러므로 최대한 정확하게 기입해주세요."></i>
	</form>
</div>
<div class="space-20"></div>
<div class="col-lg-12">
	<section class="panel">
		<header class="panel-heading"> 책 정보 기입 폼 </header>
		<div class="panel-body">
			<div class="form">
				<form:form commandName="manageBooksVO" class="form-validate form-horizontal" id="bookInfoForm"
					action="bookInfoCheckAndUploadFile.do" method="post"  enctype="multipart/form-data" onsubmit="return beforeChangeBgCheck()">
					<div class="form-group ">
						<label class="control-label col-lg-2" for="bTitle"> 책 제목 
						<span class="required">*</span>
						</label>
						<div class="col-lg-10">
							<form:input path="title" class="form-control" id="bTitle" type="text" />
							<form:errors path="title"/>
						</div>
					</div>
					<div class="form-group ">
						<label class="control-label col-lg-2" for="bAuthor"> 작가 
							<span class="required">*</span>
						</label>
						<div class="col-lg-10">
							<form:input path="author" class="form-control" id="bAuthor" type="text" />
							<form:errors path="author"/>
						</div>
					</div>
					<div class="form-group ">
						<label class="control-label col-lg-2" for="bPublisher"> 출판사 
							<span class="required">*</span>
						</label>
						<div class="col-lg-10">
							<form:input path="publisher" class="form-control" id="bPublisher" type="text" />
							<form:errors path="publisher"/>
						</div>
					</div>
					<div class="form-group ">
						<label class="control-label col-lg-2" for="bPublishDate"> 출판일 <span
							class="required">*</span>
						</label>
						<div class="col-lg-10">
							<form:input path="publishDate" class="form-control" id="bPublishDate" type="text" />
							<form:errors path="publishDate"/>
						</div>
					</div>
					<div class="form-group ">
						<label class="control-label col-lg-2" for="bPage"> 페이지 <span
							class="required">*</span>
						</label>
						<div class="col-lg-10">
							<form:input path="bookPage" class="form-control" id="bPage" type="text" />
							<form:errors path="bookPage"/>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-lg-2" for="bClassification">분류</label>
						<div class="col-lg-10">
							<form:select class="form-control m-bot15" path="classification" id="bClassification">
								<option>일반</option>
								<option>철학</option>
								<option>종교</option>
								<option>과학</option>
								<option>예술</option>
								<option>언어</option>
								<option>문학</option>
								<option>역사</option>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-lg-2" for="bContent">책 내용</label>
						<div class="col-lg-10">
							<form:textarea path="content" id="bContent" class="form-control autosize" onkeydown="autoChangeTextareaSize('bContent', 30)" 
							onkeyup="autoChangeTextareaSize('bContent', 30)" onchange="autoChangeTextareaSize('bContent', 30)"></form:textarea>
							<form:errors path="content"/>
						</div>
					</div>
					<div class="form-group">
						<label for="inputBookImg" class="control-label col-lg-2">이미지 업로드</label> 				
								<input type="file" id="inputBookImg" name="inputBookImg" accept="image/gif, image/jpeg, image/png" />       
								<img id="uploadImg" src="#" alt="your image" width="300px" height="300px" />		
								이미지 크기는 300 X 200 사이즈를 권장합니다. 너무 크면 깨집니다
					</div>
					<div class="form-group ">
						<label class="control-label col-lg-2" for="bCallNumber"> 청구기호 <span
							class="required">*</span>
						</label>
						<div class="col-lg-10">
							<form:input path="callNumber" class="form-control" id="bCallNumber" type="text" />
							<form:errors path="callNumber"/>
						</div>
					</div>					
					<div class="form-group">
						<label class="control-label col-lg-2" for="bState">상태</label>
						<div class="col-lg-10">
							<form:select class="form-control m-bot15" id="bState" path="state" onchange="addBookInfoFn.changeBookState()">
								<option value="대출가능" selected>대출가능</option>
								<option value="대출중">대출중</option>
								<option value="대출불가">대출불가</option>
							</form:select>
						</div>
					</div>					
					<div class="form-group ">
						<label class="control-label col-lg-2" for="bReturnTerm"> 대출기한 
						</label>
						<div class="col-lg-10">
							<form:input path="returnTerm" class="form-control" readonly="true" id="bReturnTerm" type="text" />
						</div>
					</div>
					<div class="form-group">
						<div class="col-lg-offset-2 col-lg-10">
							<button class="btn btn-primary" type="submit">책 추가</button>
						</div>
					</div>
				</form:form>
			</div>

		</div>
	</section>
</div>
<!--  search form end -->