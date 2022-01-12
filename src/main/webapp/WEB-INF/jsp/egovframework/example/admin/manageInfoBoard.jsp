<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

   
<script type="text/javascript">
   
$(document).ready(function() {
   
	manageInfoBoardJqGridTable.init();
});

var manageInfoBoardJqGridTable = 
{
	
   init : function() {
      
      var cnames = ['번호','제목','내용','이미지 경로','일정','작성일자','종류', '회원ID','구분'];
      
       $("#manageInfoBoardJqGrid").jqGrid({
           url: "manageInfoBoardJqGridMain.do",
           datatype: "local",
           colNames: cnames,
           colModel:[
                  {name:'no',      			index:'no',       		width:55,  key:true,    align:"center"},
                  {name:'title',      		index:'title',       	width:200, edittype: "textarea", align:"center"},
                  {name:'content',      	index:'content',       	width:200, edittype: "textarea", align:"center"},
                  {name:'imgDes',    		index:'imgDes',      	width:150, edittype: "textarea", align:"center"},
                  {name:'eventDate',    	index:'eventDate',   	width:80, align:"center"},       
                  {name:'createdDate',    	index:'createdDate',    width:80, align:"center"},       
                  {name:'type',   			index:'type',     width:50, editable:true, edittype: "select", formatter:"select", align:"center",
                      editoptions: {
                          
                          value         :   {"정보":"정보","행사":"행사"},
                          dataEvents   :   [{
                           type   :   'change',
                           fn   : function(e) {
                           
                           }
                          }]
                      }
                  },  
                  {name:'memberId',    	index:'memberId',    width:100, align:"center"},       
                  {name:'btn',      		index:'btn', 			width:60,  formatter:gridFunc.rowBtn, align:"center"}
           ],
           height         	: 400,
           rowNum         	: 10,
           rowList        	: [10,20,30],
           pager         	: '#manageInfoBoardJqGridPager',
           cellEdit      	: true, 
           cellsubmit      	: "clientArray", // 셀 수정하고 다른 셀을 클릭하면 바로 서버를 타게되는 성격이다. 그렇게 안하기 위해서는 이놈을 추가해 줘야 한다.
           multiselect      : true,      // 저장과 삭제 용도
           rownumbers     	: true,  
           onCellSelect : function(rowId, colId, val, e) {
        	   	alert("dd");
              	var no = $("#manageInfoBoardJqGrid").getCell(rowId, "no");
            	if(!CommonJsUtil.isEmpty(no)) {

    				alert(no);
                    $("#manageInfoBoardJqGrid").setColProp("no", {editable:false});
                    $("#manageInfoBoardJqGrid").setColProp("title", {editable:false});
                    $("#manageInfoBoardJqGrid").setColProp("content", {editable:false});
                    $("#manageInfoBoardJqGrid").setColProp("imgDes", {editable:false});
                    $("#manageInfoBoardJqGrid").setColProp("eventDate", {editable:false});
                    $("#manageInfoBoardJqGrid").setColProp("createdDate", {editable:false});
                } else {

                    $("#manageInfoBoardJqGrid").setColProp("no", {editable:true});
                    $("#manageInfoBoardJqGrid").setColProp("title", {editable:true});
                    $("#manageInfoBoardJqGrid").setColProp("content", {editable:true});
                    $("#manageInfoBoardJqGrid").setColProp("imgDes", {editable:true});
                    $("#manageInfoBoardJqGrid").setColProp("eventDate", {editable:true});
                 
              }
           },
       
           viewrecords : true,
           caption:"정보 게시판 관리 테이블"
       });
       
   	},
   	deleteData : function() {
		
	   this.selectData('del');
	   
	},

   	goSearch : function() {
      
      var jsoidbj = {};
      
      $("#manageInfoBoardJqGrid").setGridParam({
         		
           datatype : "json",
           postData : {"param" : JSON.stringify(jsoidbj)},
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
	
	   	$("#manageInfoBoardJqGrid").editCell(0, 0, false);
	   	
	 	// 저장 전 validation 체크
	 	if(!this.gridValid()){  
	 		
    		return false;
    	} 

    	this.selectData('save');
     
   },
   selectData : function(gubun) {
	   
	   var gubunText = gubun == 'save' ? '저장' : '삭제';
	   //체크박스의 체크된 것을가져오는것
	   var checkData = $("#manageInfoBoardJqGrid").getGridParam("selarrrow");
	   
	   if(checkData.length == 0) {
	         
	        alert(gubunText+"할 데이터를 선택하여 주십시오");         
	        return;
	   }
	   
	   if(confirm("선택한 데이터를 "+gubunText+" 하시겠습니까?") == false) {
	     
	    	 return false;
	   }
	   
	   var iCnt =0;
	   var jsonArray = new Array();
	   
	   for(var i=0; i<checkData.length; i++) {
		   
		   var jsoidbj = {};
		   
		   var no = $("#manageInfoBoardJqGrid").getCell(checkData[i], "no");
		   
		   var editType = "" ;
		   if(gubun=='del') {

			   editType = "D";
		   } else if(!CommonJsUtil.isEmpty(no)) {
			 
			   editType = "U";
		   } else {

			   editType = "I";
		   }
	   		jsoidbj.editType = editType;
	   		jsoidbj.no = no;
	   
	   		jsoidbj.title =				$("#manageInfoBoardJqGrid").getCell(checkData[i], "title");
	   		jsoidbj.content =			$("#manageInfoBoardJqGrid").getCell(checkData[i], "content");
	   		jsoidbj.imgDes =			$("#manageInfoBoardJqGrid").getCell(checkData[i], "imgDes");	
	   		jsoidbj.eventDate =			$("#manageInfoBoardJqGrid").getCell(checkData[i], "eventDate");
	   		jsoidbj.type =				$("#manageInfoBoardJqGrid").getCell(checkData[i], "type");
	   		jsoidbj.memberId =			$("#manageInfoBoardJqGrid").getCell(checkData[i], "memberId");
	   		
	   		jsonArray[iCnt] = jsoidbj;
	   		iCnt++;
	   		
	  	}	   
	   	var param = JSON.stringify(jsonArray);

	    this.ajaxCallFn(param, gubunText);
   },
   gridValid   :   function() {
      	// 선택된 셀을 기준으로 데이터들을 validation 체크한다.
	   	var selectedObj = $("#manageInfoBoardJqGrid").getGridParam("selarrrow");
      	
	  	//var trObj = $("#manageInfoBoardJqGrid").find("tr");
        
	  	for(var i=0; i<selectedObj.length; i++) {
	  		
	        var rowId = selectedObj[i];
	        
	    	var title = $("#manageInfoBoardJqGrid").getCell(rowId, "title");
	    	
	    	var content = $("#manageInfoBoardJqGrid").getCell(rowId, "content");
	    		
	    	if(CommonJsUtil.isEmpty(title)) {

	        	alert(rowId + "째 행의 제목은 꼭 적어주셔야 합니다.");
	                 
	            return false;
	                 
	            break;
	                 
	         } else if(CommonJsUtil.isEmpty(content)) {

	          	alert(rowId + "째 행의 내용은 꼭 적어주셔야 합니다.");
	                 
	            return false;
	                 
	            break;
	          } 
        }
	  	
        return true; 
      
	},
	ajaxCallFn : function(param, gubunText) {
		var that = this;
		
		$.ajax({
    		type			:	"POST",
    		url				: 	"saveManageInfoBoardJqGrid.do",
    		data			: 	{"param":param},
    		async			:	false,
    		beforeSend	:	function(xhr) {
    			
    		},
    		success		:	function(result) {
    			
  				if(result == "SUCCESS") {
  					
  					alert("성공적으로 "+ gubunText +"하였습니다." );
  					
  					var lastPage = $("#manageInfoBoardJqGrid").getGridParam("lastpage");
					
  					if(gubunText == "삭제" && $("#manageInfoBoardJqGrid").getGridParam("reccount") 
  							== $("#manageInfoBoardJqGrid").getGridParam("selarrrow").length) {
								
							  $("#manageInfoBoardJqGrid").setGridParam({
			                         
			                         page: lastPage 
			                      }).trigger("reloadGrid");
					} else {
						that.goSearch();
					}
  				}  	
  				else {
  						
  					alert("에러");
  				}
  						
    		},
    		error			:	function() {
    			
    		}
     	});
	} 
}   

var gridFunc = {
      // options안에 
      rowBtn : function(cellvalue, options, rowObject) {
    	  
         if(rowObject.no == "") {
            
               return '<a href="javascript:gridFunc.delRow('+options.rowId+');"> 행삭제 </a>';
         } else {
            
            return "";
         }
      },
      //행삭제
      delRow : function(rowid) {
      	
      	$("#manageInfoBoardJqGrid").delRowData(rowid);  
      },
      addRow : function() {
         
         var totalCnt = $("#manageInfoBoardJqGrid").getGridParam("records");
         
         var addData = {"no" : "", "title" : "", "content" : "", "imgDes" : "", "eventDate" : "","type" : "정보","memberId" : "admin"};
         
         // 행추가
         $("#manageInfoBoardJqGrid").addRowData(totalCnt + 1, addData);
         // 이후 각 행들을 수정가능하게 변경
         $("#manageInfoBoardJqGrid").setColProp("title", {editable:true}); 
         $("#manageInfoBoardJqGrid").setColProp("content", {editable:true});  
         $("#manageInfoBoardJqGrid").setColProp("imgDes", {editable:true});
         $("#manageInfoBoardJqGrid").setColProp("eventDate", {editable:true}); 
         $("#manageInfoBoardJqGrid").setColProp("type", {editable:true}); 
      },
      clearGrid   : function() {
         
         $("#manageInfoBoardJqGrid").clearGridData();
      }
      
}

var CommonJsUtil = 
{
    isEmpty : function(val) {
     
        if(null == val || null === val || "" == val || val == undefined || typeof(val) == undefined || "undefined" == val || "NaN" == val) {
         	
            return true;
        } else {
         
            return false;
        }
    }, 
    isNumeric : function(val) {
       
       if(/[^0-9]/.test(val)) {
          
          return false;
       } else {
          
          return true;
       }
    }
    
}
</script>

	<form id="manageInfoBoardFrm" name ="manageInfoBoardFrm">
	</form>
	<div class="row">
		<div class="col-lg-12">
		<h4 class="page-header"><i class="fa fa-comments-o"></i> 게시판 관리</h4>
			<ol class="breadcrumb">
				<li><i class="fa fa-home"></i><a href="#" onclick="javascript:adminLeftFn.pageSubmitFn('admin-main')">Home</a></li>
				<li><i class="fa fa-comments-o"></i>게시판 관리</li>
			</ol>
		</div>
	</div>
   	<div class="row" style="margin-left: 5px; ">
      <div>
         <span><a href="#" class ="btn btn-info" onclick="javascript:manageInfoBoardJqGridTable.goSearch();">조회</a></span> 
         <span><a href="#" class ="btn btn-info" onclick="javascript:gridFunc.addRow();">행추가</a></span>
         <span><a href="#" class ="btn btn-info" onclick="javascript:manageInfoBoardJqGridTable.saveData();">저장</a></span>
         <span><a href="#" class ="btn btn-info" onclick="javascript:gridFunc.clearGrid();">초기화</a></span>
         <span><a href="#" class ="btn btn-info" onclick="javascript:manageInfoBoardJqGridTable.deleteData();">삭제</a></span>
      </div>
      <div class="space-10"></div>         
      <div>
         <table id="manageInfoBoardJqGrid"></table>
          <div id="manageInfoBoardJqGridPager"></div>
      </div>   
   </div>