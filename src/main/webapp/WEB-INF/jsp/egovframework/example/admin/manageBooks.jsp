<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

   
<script type="text/javascript">
   
$(document).ready(function() {
   
	manageBooksJqGridTable.init();
});

var manageBooksJqGridTable = 
{
	
   init : function() {
      
      var cnames = ['아이디','제목','작가','출판사','출판일','분류', '내용','이미지 경로', '페이지', '대여횟수','구분'];
      
       $("#manageBooksJqGrid").jqGrid({
          
           url: "manageBooksJqGridMain.do",
           datatype: "local",
           colNames: cnames,
           colModel:[
                  {name:'id',      			index:'id',       		width:55,  key:true,    align:"center"},
                  {name:'title',      		index:'title',       	width:120, edittype : "textarea", align:"center"},
                  {name:'author',      		index:'author',       	width:100, edittype : "textarea", align:"center"},
                  {name:'publisher',    	index:'publisher',      width:100, align:"center"},
                  {name:'publishDate',    	index:'publishDate',    width:80, align:"center"},       
                  {name:'classification',   index:'classification',     width:50, editable:true, edittype: "select", formatter:"select", align:"center",
                      editoptions: {
                          
                          value         :   {"일반":"일반","컴퓨터":"컴퓨터","철학":"철학", "종교":"종교",
                        	  				 "과학":"과학","예술":"예술","언어":"언어","문학":"문학","역사":"역사"},
                          dataEvents   :   [{
                           type   :   'change',
                           fn   : function(e) {
                           
                           }
                          }]
                      }
                  },
                  {name:'content',      	index:'content',    	width:200, edittype : "textarea", align:"center"},
                  {name:'imgDes',      		index:'imgDes',       	width:100, edittype : "textarea", align:"center"},
                  {name:'bookPage',      	index:'bookPage',       width: 60, align:"center"},
                  {name:'rentCnt',      	index:'rentCnt',       	width: 60, align:"center"},
                  {name:'btn',      		index:'btn', 			width: 70,  formatter:gridFunc.rowBtn, align:"center"}
         ],
           height         	: 400,
           rowNum         	: 10,
           rowList        	: [10,20,30],
           pager         	: '#manageBooksJqGridPager',
           cellEdit      	: true, 
           cellsubmit      	: "clientArray", // 셀 수정하고 다른 셀을 클릭하면 바로 서버를 타게되는 성격이다. 그렇게 안하기 위해서는 이놈을 추가해 줘야 한다.
           multiselect      : true,      // 저장과 삭제 용도
           rownumbers     	: true,  
          
           ondblClickRow : function(rowId, iRow, iCol, e) {
				
        	   	var id = $("#manageBooksJqGrid").getCell(rowId, "id");
        	   	
        	   	if(id == "") {
        	   		
        	   		return; 
           		}	
        	   
        		$("#bookId").val(id);
        		$("#bookTitle").val($("#manageBooksJqGrid").getCell(rowId, "title"));
        		
				$("#manageBooksFrm").attr("action", "manageBooksDetail.do");
				
				$("#manageBooksFrm").submit();
 
           },
           
           onCellSelect : function(rowId, colId, val, e) {
              
              	var id = $("#manageBooksJqGrid").getCell(rowId, "id");

            	if(!CommonJsUtil.isEmpty(id)) {
            		
                    $("#manageBooksJqGrid").setColProp("id", {editable:false});
                    $("#manageBooksJqGrid").setColProp("title", {editable:false});
                    $("#manageBooksJqGrid").setColProp("author", {editable:false});
                    $("#manageBooksJqGrid").setColProp("publisher", {editable:false});
                    $("#manageBooksJqGrid").setColProp("publishDate", {editable:false});
                    $("#manageBooksJqGrid").setColProp("classification", {editable:false});
                    $("#manageBooksJqGrid").setColProp("content", {editable:false});
                    $("#manageBooksJqGrid").setColProp("imgDes", {editable:false});
                    $("#manageBooksJqGrid").setColProp("bookPage", {editable:false});
                } else {

                    $("#manageBooksJqGrid").setColProp("id", {editable:true});
                    $("#manageBooksJqGrid").setColProp("title", {editable:true});
                    $("#manageBooksJqGrid").setColProp("author", {editable:true});
                    $("#manageBooksJqGrid").setColProp("publisher", {editable:true});
                    $("#manageBooksJqGrid").setColProp("publishDate", {editable:true});
                    $("#manageBooksJqGrid").setColProp("classification", {editable:true});
                    $("#manageBooksJqGrid").setColProp("content", {editable:true});
                    $("#manageBooksJqGrid").setColProp("imgDes", {editable:true});
                    $("#manageBooksJqGrid").setColProp("bookPage", {editable:true});
                 
              }
           },
       
           viewrecords : true,
           caption:"도서 관리 테이블"
       });
       
   	},
   	deleteData : function() {
		
	   this.selectData('del');
	   
	},

   	goSearch : function() {
      
      var jsonObj = {};
/* 
      if($("#selectId").val() != "C") {
         
         jsonObj.serviceImplYn = $("#selectId").val();
        
      } */
      
      $("#manageBooksJqGrid").setGridParam({
         		
           datatype : "json",
           postData : {"param" : JSON.stringify(jsonObj)},
           loadComplete: function(data){
              
              $.each(data, function (i, item) { 

               if(i == "rows") {   
                  
                  if(item < 1) {                     
            
                     alert("데이터가 없습니다.");
                  }
               }
              });
           },
       
           gridComplete : function() {
             
          }
       }).trigger("reloadGrid");
   },
   saveData   :   function() {
	
	   	$("#manageBooksJqGrid").editCell(0, 0, false);
	
	  	var that =this;
     	// 저장 전 validation 체크
	    if(!this.gridValid()){   
    	    return false; 
    	}
  
		this.selectData('save');
     
   },
   selectData : function(gubun) {
	   
	   var gubunText = gubun == 'save' ? '저장' : '삭제';
	      //체크박스의 체크된 것?을가져오는것
	   var checkData = $("#manageBooksJqGrid").getGridParam("selarrrow");
	   
	   if(checkData.length == 0) {
	         
	        alert("저장할 데이터를 선택하여 주십시오");         
	        return;
	   }
	   
	   if(confirm("선택한 데이터를 "+gubunText+" 하시겠습니까?") == false) {
	     
	    	 return false;
	   }
	   
	   var iCnt =0;
	   var jsonArray = new Array();
	   
	   for(var i=0; i<checkData.length; i++) {
		   
		   var jsonObj = {};
		   
		   var id = $("#manageBooksJqGrid").getCell(checkData[i], "id");
		   
		   var editType = "" ;
		   if(gubun=='del') {

			   editType = "D";
		   } else if(!CommonJsUtil.isEmpty(id)) {
			 
			   editType = "U";
		   } else {

			   editType = "I";
		   }
	   		jsonObj.editType = editType;
	   		jsonObj.id = id;
	   
	   		jsonObj.title =				$("#manageBooksJqGrid").getCell(checkData[i], "title");
	   		jsonObj.author =			$("#manageBooksJqGrid").getCell(checkData[i], "author");
	   		jsonObj.publisher =			$("#manageBooksJqGrid").getCell(checkData[i], "publisher");	
	   		jsonObj.publishDate =		$("#manageBooksJqGrid").getCell(checkData[i], "publishDate");
	   		jsonObj.classification =	$("#manageBooksJqGrid").getCell(checkData[i], "classification");
	   		jsonObj.content =			$("#manageBooksJqGrid").getCell(checkData[i], "content");
	   		jsonObj.imgDes =			$("#manageBooksJqGrid").getCell(checkData[i], "imgDes");
	   		jsonObj.bookPage =			$("#manageBooksJqGrid").getCell(checkData[i], "bookPage");
	   		jsonObj.rentCnt =			$("#manageBooksJqGrid").getCell(checkData[i], "rentCnt");
	   		
	   		jsonArray[iCnt] = jsonObj;
	   		iCnt++;
	   		
	  	}	   
	   	var param = JSON.stringify(jsonArray);

	    this.ajaxCallFn(param, gubunText);
   },
   gridValid   :   function() {

	   	var selectedObj = $("#manageBooksJqGrid").getGridParam("selarrrow");
     	
	  	//var trObj = $("#manageInfoBoardJqGrid").find("tr");
       
	  	for(var i=0; i<selectedObj.length; i++) {
	  		
	        var rowId = selectedObj[i];

			var title = $("#manageBooksJqGrid").getCell(rowId, "title");
			var author = $("#manageBooksJqGrid").getCell(rowId, "author");
			var publisher = $("#manageBooksJqGrid").getCell(rowId, "publisher");
			var publishDate = $("#manageBooksJqGrid").getCell(rowId, "publishDate");
			var bookPage = $("#manageBooksJqGrid").getCell(rowId, "bookPage");
			var rentCnt = $("#manageBooksJqGrid").getCell(rowId, "rentCnt");
			
			if (CommonJsUtil.isEmpty(title)) {

				alert(rowId + "째 행의 제목은 꼭 적어주셔야 합니다.");

				return false;

				break;

			} else if (CommonJsUtil.isEmpty(author)) {

				alert(rowId + "째 행의 저자는 꼭 적어주셔야 합니다.");

				return false;

				break;
			} else if (CommonJsUtil.isEmpty(publisher)) {

				alert(rowId + "째 행의 출판사는 꼭 적어주셔야 합니다.");

				return false;

				break;
			} else if (CommonJsUtil.isEmpty(publishDate) || !CommonJsUtil.isDate(publishDate)) {

				alert(rowId + "째 행의 출판일은 공백이 아닌 YYYY/MM/DD 형식으로 날짜를 적어주셔야 합니다.");

				return false;
				
				break;		
				
			} else if (CommonJsUtil.isEmpty(bookPage) || !CommonJsUtil.isNumeric(bookPage)) {

				alert(rowId + "째 행의 페이지는 공백이 아닌 숫자만 적어주셔야 합니다.");

				return false;

				break;	
			} else if (CommonJsUtil.isEmpty(rentCnt) || !CommonJsUtil.isNumeric(rentCnt)) {

				alert(rowId + "째 행의 대여횟수는 공백이 아닌 숫자만 적어주셔야 합니다.");

				return false;
	
				break;
			} 
		}
		return true;

	},
	ajaxCallFn : function(param, gubunText) {

		$.ajax({
			type : "POST",
			url : "saveManageBooksJqGrid.do",
			data : {
				"param" : param
			},
			async : false,
			beforeSend : function(xhr) {

			},
			success : function(result) {

				if (result == "SUCCESS") {

					alert("성공적으로 " + gubunText + "하였습니다.");

					var lastPage = $("#manageBooksJqGrid").getGridParam("lastpage");

					if (gubunText == "삭제" && $("#manageBooksJqGrid").getGridParam("reccount") 
							== $("#manageBooksJqGrid").getGridParam("selarrrow").length) {

							$("#manageBooksJqGrid").setGridParam({

								page : lastPage
							}).trigger("reloadGrid");
					} else {
						manageBooksJqGridTable.goSearch();
					}
				} else {

						alert("에러");
				}

			},
			error : function() {

			}
		});
	}
}

var gridFunc = {
	// options안에 
	rowBtn : function(cellvalue, options, rowObject) {

		if (rowObject.id == "") {

			return '<a href="javascript:gridFunc.delRow(' + options.rowId + ');"> 행삭제 </a>';
		} else {

			return "";
		}
	},
	//행삭제
	delRow : function(rowid) {

		$("#manageBooksJqGrid").delRowData(rowid);
	},
	addRow : function() {

		var totalCnt = $("#manageBooksJqGrid").getGridParam("records");

		var addData = {"id" : "", "title" : "", "author" : "", "publisher" : "","publishDate" : "","classification" : "일반","content" : "","imgDes" : "","bookPage" : "", "rentCnt" : "0"};

		// 행추가
		$("#manageBooksJqGrid").addRowData(totalCnt + 1, addData);
		// 이후 각 행들을 수정가능하게 변경
		$("#manageBooksJqGrid").setColProp("title", {editable : true});
		$("#manageBooksJqGrid").setColProp("author", {editable : true});
		$("#manageBooksJqGrid").setColProp("publisher", {editable : true});
		$("#manageBooksJqGrid").setColProp("publishDate", {editable : true});
		$("#manageBooksJqGrid").setColProp("classification", {editable : true});
		$("#manageBooksJqGrid").setColProp("content", {editable : true});
		$("#manageBooksJqGrid").setColProp("imgDes", {editable : true});
		$("#manageBooksJqGrid").setColProp("bookPage", {editable : true});
		$("#manageBooksJqGrid").setColProp("rentCnt", {editable : true});
	},
	clearGrid : function() {

		$("#manageBooksJqGrid").clearGridData();
	}

}

var CommonJsUtil = {
	isEmpty : function(val) {

		if (null == val || null === val || "" == val || val == undefined 
				|| typeof (val) == undefined || "undefined" == val || "NaN" == val) {

			return true;
		} else {

			return false;
		}
	},
	isNumeric : function(val) {

		if (/[^0-9]/.test(val)) {

			return false;
		} else {

			return true;
		}
	},
	isDate : function(val) {
    	
    	if(/^(19|20)\d{2}([/])(0[1-9]|1[012])([/])(0[1-9]|[12][0-9]|3[0-1])$/.test(val)) {
    		
    		return true;
    	} else {
    		
    		return false;
    	}

    }
}
</script>

	<form id="manageBooksFrm" name ="manageBookFrm">
		<input type="hidden" id="bookId" name="bookId" />
		<input type="hidden" id="bookTitle" name="bookTitle" />
	</form>
	<div class="row">
		<div class="col-lg-12">
		<h4 class="page-header"><i class="fa fa-book"></i> 도서 관리</h4>
			<ol class="breadcrumb">
				<li><i class="fa fa-home"></i><a href="#" onclick="javascript:adminLeftFn.pageSubmitFn('admin-main')">Home</a></li>
				<li><i class="fa fa-book"></i>도서 관리</li>
				<li><i class="fa fa-table"></i>도서 관리 테이블</li>
			</ol>
		</div>
	</div>
   	<div class="row" style="margin-left: 5px; ">
      <div>
         <span><a href="#" class ="btn btn-info" onclick="javascript:manageBooksJqGridTable.goSearch();">조회</a></span> 
         <span><a href="#" class ="btn btn-info" onclick="javascript:gridFunc.addRow();">행추가</a></span>
         <span><a href="#" class ="btn btn-info" onclick="javascript:manageBooksJqGridTable.saveData();">저장</a></span>
         <span><a href="#" class ="btn btn-info" onclick="javascript:gridFunc.clearGrid();">초기화</a></span>
         <span><a href="#" class ="btn btn-info" onclick="javascript:manageBooksJqGridTable.deleteData();">삭제</a></span>
         <span><i class="fa fa-question-circle fa-lg" aria-hidden="true"
			      title="책을 추가한 뒤 그 셀을 더블 클릭해서 상세정보를 반드시 등록해주세요."></i></span>
      </div>
      <div class="space-10"></div>         
      <div>
         <table id="manageBooksJqGrid"></table>
          <div id="manageBooksJqGridPager"></div>
      </div>   
   </div>