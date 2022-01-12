<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   
<script type="text/javascript">
   
$(document).ready(function() {
   
	manageLibroInformationJqGridTable.init();
	
	if("<c:out value='${isCheck}'/>" == "Y") {
		
		alert("배경이미지를 변경했습니다.");
			
		var url = "http://" + location.host + "/sample/#sc6";
		var opt = "width=800, height=500";
		
		location.reload();
		
		window.open(url, "", opt);	
	}
});

var manageLibroInformationJqGridTable = 
{
	
   init : function() {
      
      var cnames = ['아이디','제목','내용','부연설명','구분'];
      
       $("#manageLibroInformationJqGrid").jqGrid({
          
           url: "manageLibroInformationJqGridMain.do",
           datatype: "local",
           colNames: cnames,
           colModel:[
                  {name:'id',      			index:'id',       		width:55,  key:true, align:"center"},
                  {name:'title',      		index:'title',      	width:250, edittype : "textarea", align:"center"},
                  {name:'content',      	index:'content',       	width:300, edittype : "textarea", align:"center"},
                  {name:'explanation',      index:'explanation',    width:250, edittype : "textarea", align:"center"},
                  {name:'btn',      index:'btn', width:100,  formatter:gridFunc.rowBtn}
         ],
           height         	: 400,
           rowNum         	: 10,
           rowList        	: [10,20,30],
           pager         	: '#manageLibroInformationJqGridPager',
           cellEdit      	: true, 
           cellsubmit      	: "clientArray", // 셀 수정하고 다른 셀을 클릭하면 바로 서버를 타게되는 성격이다. 그렇게 안하기 위해서는 이놈을 추가해 줘야 한다.
           multiselect      : true,      // 저장과 삭제 용도
           rownumbers     	: true,  
           /* onCellSelect : function(rowId, colId, val, e) {
              
              	var menuId = $("#manageLibroInformationJqGrid").getCell(rowId, "menuId");

            	if(!CommonJsUtil.isEmpty(menuId)) {
            		
                    $("#manageLibroInformationJqGrid").setColProp("menuId", {editable:false});
                    $("#manageLibroInformationJqGrid").setColProp("meneNm", {editable:false});
                    $("#manageLibroInformationJqGrid").setColProp("menuUrl", {editable:false});
                    $("#manageLibroInformationJqGrid").setColProp("menuClass", {editable:false});
                    $("#manageLibroInformationJqGrid").setColProp("useYn", {editable:false});
                    $("#manageLibroInformationJqGrid").setColProp("sortNo", {editable:false});
                    $("#manageLibroInformationJqGrid").setColProp("innerLink Yn", {editable:false});
                } else {

                    $("#manageLibroInformationJqGrid").setColProp("menuId", {editable:true});
                    $("#manageLibroInformationJqGrid").setColProp("meneNm", {editable:true});
                    $("#manageLibroInformationJqGrid").setColProp("menuUrl", {editable:true});
                    $("#manageLibroInformationJqGrid").setColProp("menuClass", {editable:true});
                    $("#manageLibroInformationJqGrid").setColProp("useYn", {editable:true});
                    $("#manageLibroInformationJqGrid").setColProp("sortNo", {editable:true});
                    $("#manageLibroInformationJqGrid").setColProp("innerLink Yn", {editable:true});
                 
              }
           }, */
       
           viewrecords : true,
           caption:"도서관 이용안내 테이블"
       });
     
	},
   	deleteData : function() {

		this.selectData('del');
	   
	},

   	goSearch : function() {
      
      var jsonObj = {};
      
      $("#manageLibroInformationJqGrid").setGridParam({
         	
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
	
		$("#manageLibroInformationJqGrid").editCell(0, 0, false);
	
	 	// 저장 전 validation 체크
	 	if(!this.gridValid()){  
	 		
    		return false;
    	} 
    	
	 	this.selectData('save');
   	},
   	selectData : function(gubun) {
	   
	   var gubunText = gubun == 'save' ? '저장' : '삭제';
	   
	   //체크박스의 체크된 것을가져오는것
	   var checkData = $("#manageLibroInformationJqGrid").getGridParam("selarrrow");
	      
	   if(checkData.length == 0) {
	         
	        alert(gubunText + "할 데이터를 선택하여 주십시오");         
	        return;
	   }
	   
	   if(confirm("선택한 데이터를 "+gubunText+" 하시겠습니까?") == false) {
	     
	    	 return false;
	   }
	   
	   var iCnt =0;
	   var jsonArray = new Array();
	   
	   for(var i=0; i<checkData.length; i++) {
		   
		   	var jsonObj = {};
		   
		   	var id = $("#manageLibroInformationJqGrid").getCell(checkData[i], "id");
		   
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
	   
	   		jsonObj.title =				$("#manageLibroInformationJqGrid").getCell(checkData[i], "title");
	   		jsonObj.content =			$("#manageLibroInformationJqGrid").getCell(checkData[i], "content");
	   		jsonObj.explanation =		$("#manageLibroInformationJqGrid").getCell(checkData[i], "explanation");	
	   		
	   		jsonArray[iCnt] = jsonObj;
	   		iCnt++;
	   		
	  	}	   
	   	var param = JSON.stringify(jsonArray);

	    this.ajaxCallFn(param, gubunText);
   },
   gridValid   :   function() {

	   	var selectedObj = $("#manageLibroInformationJqGrid").getGridParam("selarrrow");
     	
	  	for(var i=0; i<selectedObj.length; i++) {
	  		
	        var rowId = selectedObj[i];

	    	var title = $("#manageLibroInformationJqGrid").getCell(rowId, "title");
	    	var content = $("#manageLibroInformationJqGrid").getCell(rowId, "content");
	    	var explanation = $("#manageLibroInformationJqGrid").getCell(rowId, "explanation");
	    	
	    	
	    	if(CommonJsUtil.isEmpty(title)) {

				alert(rowId + "째 행의 제목은 꼭 적어주셔야 합니다.");

				return false;

				break;

			} else if (CommonJsUtil.isEmpty(content)) {

				alert(rowId + "째 행의 제목은 꼭 적어주셔야 합니다.");

				return false;

				break;
			} else if(title.length >= 30) {

				alert(rowId + "째 행의 제목은 30자 미만으로 적어주셔야 합니다.");

				return false;

				break;	
			} else if(content.length >= 50) {

				alert(rowId + "째 행의 내용은 50자 미만으로 적어주셔야 합니다.");

				return false;

				break;	
			} else if(explanation.length >= 30) {

				alert(rowId + "째 행의 부연설명은 30자 미만으로 적어주셔야 합니다.");

				return false;

				break;	
			} 


		}
		return true;

		},
		ajaxCallFn : function(param, gubunText) {

			$.ajax({
				type : "POST",
				url : "saveManageLibroInformationJqGrid.do",
				data : {
					"param" : param
				},
				async : false,
				beforeSend : function(xhr) {

				},
				success : function(result) {

					if (result == "SUCCESS") {

						alert("성공적으로 " + gubunText + " 하였습니다.");

						var lastPage = $("#manageLibroInformationJqGrid").getGridParam("lastpage");

						if (gubunText == "삭제" && $("#manageLibroInformationJqGrid").getGridParam("reccount") 
								== $("#manageLibroInformationJqGrid").getGridParam("selarrrow").length) {

							$("#manageLibroInformationJqGrid").setGridParam({

								page : lastPage
							}).trigger("reloadGrid");
						} else {

							manageLibroInformationJqGridTable.goSearch();
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

				return '<a href="javascript:gridFunc.delRow(' + options.rowId
						+ ');"> 행삭제 </a>';
			} else {

				return "";
			}
		},
		//행삭제
		delRow : function(rowid) {

			$("#manageLibroInformationJqGrid").delRowData(rowid);
		},
		addRow : function() {

			var totalCnt = $("#manageLibroInformationJqGrid").getGridParam("records");
			
			var addData = {"id" : "","title" : "", "content" : "", "explanation" : ""};

			// 행추가
			$("#manageLibroInformationJqGrid").addRowData(totalCnt + 1, addData);
			// 이후 각 행들을 수정가능하게 변경
			$("#manageLibroInformationJqGrid").setColProp("title", {editable : true});
			$("#manageLibroInformationJqGrid").setColProp("content", {editable : true});
			$("#manageLibroInformationJqGrid").setColProp("explanation", {editable : true});
		},
		clearGrid : function() {

			$("#manageLibroInformationJqGrid").clearGridData();
		}

	}

	var CommonJsUtil = {
		isEmpty : function(val) {

			if (null == val || null === val || "" == val || val == undefined
					|| typeof (val) == undefined || "undefined" == val
					|| "NaN" == val) {

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
		}

	}
	function beforeChangeBgCheck() {

  		var file = $("#libroInformationBg").val();
  		var FileFilter = /\.(jpg|gif|png)$/i;
  		var extArray = new Array(".jpg", ".gif", ".png");   
  		var bSubmitCheck = false;
    
  		if( !file ){ 
  		  alert( "파일을 선택하여 주세요!");
  	  
  		  return false;
  		}
  
  		if(file.match(FileFilter)) { 
  			
    		bSubmitCheck = true;
  		}	
  
  		if (bSubmitCheck) {
  			
  			return confirm("정말로 배경 이미지를 변경하시겠습니까?");
  	 	} else {
  	 		
    	 	alert("다음 확장자의 파일만 업로드가 가능합니다.\n\n"  + (extArray.join("  ")) + "\n\n 업로드할 파일을 "
    	 		+ " 다시 선택하여 주세요.");
    	 	return false;
   		}
	}


</script>

	<div class="row">
		<div class="col-lg-12">
		<h4 class="page-header"><i class="fa fa-bullhorn"></i>도서관 이용안내 관리</h4>
			<ol class="breadcrumb">
				<li><i class="fa fa-home"></i><a href="#" onclick="javascript:adminLeftFn.pageSubmitFn('admin-main')">Home</a></li>
				<li><i class="fa fa-bullhorn"></i>도서관 이용안내 관리</li>
			</ol>
		</div>
	</div>
   	<div class="row" style="margin-left: 5px; ">
	<section class="panel">
		<header class="panel-heading">도서관 정보(이용안내) 배경화면 설정</header>
		<div class="panel-body">
	<div class="form">
		<form  class="form-validate form-horizontal" id="libroInformationBgForm"
					 action="changeLibroInformationBg.do" method="post" enctype="multipart/form-data" onsubmit="return beforeChangeBgCheck()">
		<div class="form-group">	
			<div class="col-lg-10">   	
   				<input type="file" accept="image/gif, image/jpeg, image/png" id="libroInformationBg" name="libroInformationBg" />
    			<div class="space-20"></div>  
   			</div>     
			<div class="col-lg-10">   	
   				<button type="submit" class="btn btn-primary">이미지 변경하기</button>
   			</div>     
   		</div>
   		</form>
   	</div>
   	</div>
   	</section> 
	<div>
         <span><a href="#" class ="btn btn-info" onclick="javascript:manageLibroInformationJqGridTable.goSearch();">조회</a></span> 
         <span><a href="#" class ="btn btn-info" onclick="javascript:gridFunc.addRow();">행추가</a></span>
         <span><a href="#" class ="btn btn-info" onclick="javascript:manageLibroInformationJqGridTable.saveData();">저장</a></span>
         <span><a href="#" class ="btn btn-info" onclick="javascript:gridFunc.clearGrid();">초기화</a></span>
         <span><a href="#" class ="btn btn-info" onclick="javascript:manageLibroInformationJqGridTable.deleteData();">삭제</a></span>
      </div>
      <div class="space-10"></div>         
      <div>
         <table id="manageLibroInformationJqGrid"></table>
          <div id="manageLibroInformationJqGridPager"></div>
      </div>   
   </div> 