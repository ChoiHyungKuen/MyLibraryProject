<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   
<script type="text/javascript">
   
$(document).ready(function() {
   
	manageMenuJqGridTable.init();
});

var manageMenuJqGridTable = 
{
	
   init : function() {
      
      var cnames = ['아이디','메뉴이름','링크URL','메뉴클래스','사용여부','정렬번호', '내부링크여부','구분'];
      
       $("#manageMenuJqGrid").jqGrid({
          
           url: "manageMenuJqGridMain.do",
           datatype: "local",
           colNames: cnames,
           colModel:[
                  {name:'menuId',      index:'menuId',       width:55,  key:true,    align:"center"},
                  {name:'menuNm',      index:'menuNm',       width:200, edittype: "textarea",	align:"center",  sortable:true},
                  {name:'menuUrl',      index:'menuUrl',       width:200, edittype: "textarea", align:"center",sortable:true},
                  {name:'menuClass',      index:'menuClass',       width:120, edittype: "textarea", align:"center"},
                  {name:'useYn',      index:'useYn',     width:100, editable:true, edittype: "select", formatter:"select", align:"center",
                      editoptions: {
                          
                          value         :   {"Y":"사용","N":"미사용"},
                          dataEvents   :   [{
                           type   :   'change',
                           fn   : function(e) {
                           
                           }
                          }]
                      }
                  },
                  {name:'sortNo',      index:'sortNo',       width:100, align:"center"},
                  {name:'innerLinkYn',      index:'innerLinkYn',     width:100, editable:true, edittype: "select", formatter:"select", align:"center",
                     editoptions: {
                        
                        value         :   {"Y":"사용","N":"미사용"},
                        dataEvents   :   [{
                        type   :   'change',
                        fn   : function(e) {
                         
                         }
                        }]
                     }
                  },
                  {name:'btn',      index:'btn', width:100,  formatter:gridFunc.rowBtn, align:"center"}
         ],
           height         	: 400,
           rowNum         	: 10,
           rowList        	: [10,20,30],
           pager         	: '#manageMenuJqGridPager',
           cellEdit      	: true, 
           cellsubmit      	: "clientArray", // 셀 수정하고 다른 셀을 클릭하면 바로 서버를 타게되는 성격이다. 그렇게 안하기 위해서는 이놈을 추가해 줘야 한다.
           multiselect      : true,      // 저장과 삭제 용도
           rownumbers     	: true,  
          
           ondblClickRow : function(rowId, iRow, iCol, e) {
            /* if(iCol == 1) {
               
                   alert(rowId+" 째줄 입니다.");
                } */
           },
           
           onCellSelect : function(rowId, colId, val, e) {
              
              	var menuId = $("#manageMenuJqGrid").getCell(rowId, "menuId");

            	if(!CommonJsUtil.isEmpty(menuId)) {
            		
                    $("#manageMenuJqGrid").setColProp("menuId", {editable:false});
                    $("#manageMenuJqGrid").setColProp("meneNm", {editable:false});
                    $("#manageMenuJqGrid").setColProp("menuUrl", {editable:false});
                    $("#manageMenuJqGrid").setColProp("menuClass", {editable:false});
                    $("#manageMenuJqGrid").setColProp("useYn", {editable:false});
                    $("#manageMenuJqGrid").setColProp("sortNo", {editable:false});
                    $("#manageMenuJqGrid").setColProp("innerLink Yn", {editable:false});
                } else {

                    $("#manageMenuJqGrid").setColProp("menuId", {editable:true});
                    $("#manageMenuJqGrid").setColProp("meneNm", {editable:true});
                    $("#manageMenuJqGrid").setColProp("menuUrl", {editable:true});
                    $("#manageMenuJqGrid").setColProp("menuClass", {editable:true});
                    $("#manageMenuJqGrid").setColProp("useYn", {editable:true});
                    $("#manageMenuJqGrid").setColProp("sortNo", {editable:true});
                    $("#manageMenuJqGrid").setColProp("innerLink Yn", {editable:true});
                 
              }
           },
       
           viewrecords : true,
           caption:"메뉴 관리 테이블"
       });
     
	},
   	deleteData : function() {

		this.selectData('del');
	   
	},

   	goSearch : function() {
      
      var jsonObj = {};
      
      $("#manageMenuJqGrid").setGridParam({
         	
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
	
		$("#manageMenuJqGrid").editCell(0, 0, false);
	
	 	// 저장 전 validation 체크
	 	if(!this.gridValid()){  
	 		
    		return false;
    	} 
    	
	 	this.selectData('save');
   	},
   	selectData : function(gubun) {
	   
	   var gubunText = gubun == 'save' ? '저장' : '삭제';
	   
	   //체크박스의 체크된 것을가져오는것
	   var checkData = $("#manageMenuJqGrid").getGridParam("selarrrow");
	      
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
		   
		   	var menuId = $("#manageMenuJqGrid").getCell(checkData[i], "menuId");
		   
		   	var editType = "" ;
		   	if(gubun=='del') {

			   editType = "D";
		   	} else if(!CommonJsUtil.isEmpty(menuId)) {
			 
				editType = "U";
		   	} else {

				editType = "I";
		   	}
	   		jsonObj.editType = editType;
	   		jsonObj.menuId = menuId;
	   
	   		jsonObj.menuNm =		$("#manageMenuJqGrid").getCell(checkData[i], "menuNm");
	   		jsonObj.menuUrl =		$("#manageMenuJqGrid").getCell(checkData[i], "menuUrl");
	   		jsonObj.menuClass =		$("#manageMenuJqGrid").getCell(checkData[i], "menuClass");	
	   		jsonObj.useYn =			$("#manageMenuJqGrid").getCell(checkData[i], "useYn");
	   		jsonObj.sortNo =		$("#manageMenuJqGrid").getCell(checkData[i], "sortNo");
	   		jsonObj.innerLinkYn =	$("#manageMenuJqGrid").getCell(checkData[i], "innerLinkYn");
	   		
	   		jsonArray[iCnt] = jsonObj;
	   		iCnt++;
	   		
	  	}	   
	   	var param = JSON.stringify(jsonArray);

	    this.ajaxCallFn(param, gubunText);
   },
   gridValid   :   function() {

	   	var selectedObj = $("#manageMenuJqGrid").getGridParam("selarrrow");
     	
	  	/*var trObj = $("#manageInfoBoardJqGrid").find("tr");
        for(var i=0; i<trObj.length; i++) {

    	    var $this = $(trObj[i]);
    	*/       
	  	for(var i=0; i<selectedObj.length; i++) {
	  		
	        var rowId = selectedObj[i];

	    	var menuNm = $("#manageMenuJqGrid").getCell(rowId, "menuNm");
	    	var menuUrl = $("#manageMenuJqGrid").getCell(rowId, "menuUrl");
	    	var sortNo = $("#manageMenuJqGrid").getCell(rowId, "sortNo");
	    		
	    	if(!CommonJsUtil.isNumeric(sortNo)) {

	        	alert(rowId + "째 행의 정렬번호는 숫자만 입력가능합니다.");
	                 
	            return false;
	                 
	            break;
	       	} else if(CommonJsUtil.isEmpty(menuNm)) {

				alert(rowId + "째 행의 메뉴이름은 꼭 적어주셔야 합니다.");

				return false;

				break;

			} else if (CommonJsUtil.isEmpty(menuUrl)) {

				alert(rowId + "째 행의 메뉴 URL 은 꼭 적어주셔야 합니다.");

				return false;

				break;
			}

		}
		return true;

		},
		ajaxCallFn : function(param, gubunText) {

			$.ajax({
				type : "POST",
				url : "saveManageMenuJqGrid.do",
				data : {
					"param" : param
				},
				async : false,
				beforeSend : function(xhr) {

				},
				success : function(result) {

					if (result == "SUCCESS") {

						alert("성공적으로 " + gubunText + " 하였습니다.");

						var lastPage = $("#manageMenuJqGrid").getGridParam("lastpage");

						if (gubunText == "삭제" && $("#manageMenuJqGrid").getGridParam("reccount") 
								== $("#manageMenuJqGrid").getGridParam("selarrrow").length) {

							$("#manageMenuJqGrid").setGridParam({

								page : lastPage
							}).trigger("reloadGrid");
						} else {

							manageMenuJqGridTable.goSearch();
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

			if (rowObject.menuId == "") {

				return '<a href="javascript:gridFunc.delRow(' + options.rowId
						+ ');"> 행삭제 </a>';
			} else {

				return "";
			}
		},
		//행삭제
		delRow : function(rowid) {

			$("#manageMenuJqGrid").delRowData(rowid);
		},
		addRow : function() {

			var totalCnt = $("#manageMenuJqGrid").getGridParam("records");

			var addData = {
				"menuId" : "",
				"menuNm" : "",
				"menuUrl" : "",
				"menuClass" : "",
				"useYn" : "Y",
				"sortNo" : "",
				"innerLinkYn" : "Y"
			};

			// 행추가
			$("#manageMenuJqGrid").addRowData(totalCnt + 1, addData);
			// 이후 각 행들을 수정가능하게 변경
			$("#manageMenuJqGrid").setColProp("menuNm", {
				editable : true
			});
			$("#manageMenuJqGrid").setColProp("menuUrl", {
				editable : true
			});
			$("#manageMenuJqGrid").setColProp("menuClass", {
				editable : true
			});
			$("#manageMenuJqGrid").setColProp("useYn", {
				editable : true
			});
			$("#manageMenuJqGrid").setColProp("sortNo", {
				editable : true
			});
			$("#manageMenuJqGrid").setColProp("innerLinkYn", {
				editable : true
			});
		},
		clearGrid : function() {

			$("#manageMenuJqGrid").clearGridData();
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
</script>
	<form id="frm" name ="frm">
	</form> 
	<div class="row">
		<div class="col-lg-12">
		<h4 class="page-header"><i class="fa fa-bars"></i> 메뉴 관리</h4>
			<ol class="breadcrumb">
				<li><i class="fa fa-home"></i><a href="#" onclick="javascript:adminLeftFn.pageSubmitFn('admin-main')">Home</a></li>
				<li><i class="fa fa-bars"></i>메뉴 관리</li>
			</ol>
		</div>
	</div>
   	<div class="row" style="margin-left: 5px; ">
      <div>
         <span><a href="#" class ="btn btn-info" onclick="javascript:manageMenuJqGridTable.goSearch();">조회</a></span> 
         <span><a href="#" class ="btn btn-info" onclick="javascript:gridFunc.addRow();">행추가</a></span>
         <span><a href="#" class ="btn btn-info" onclick="javascript:manageMenuJqGridTable.saveData();">저장</a></span>
         <span><a href="#" class ="btn btn-info" onclick="javascript:gridFunc.clearGrid();">초기화</a></span>
         <span><a href="#" class ="btn btn-info" onclick="javascript:manageMenuJqGridTable.deleteData();">삭제</a></span>
      </div>
      <div class="space-10"></div>         
      <div>
         <table id="manageMenuJqGrid"></table>
          <div id="manageMenuJqGridPager"></div>
      </div>   
   </div> 