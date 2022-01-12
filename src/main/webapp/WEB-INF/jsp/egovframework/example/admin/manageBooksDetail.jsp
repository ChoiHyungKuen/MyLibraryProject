<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

   
<script type="text/javascript">
   
$(document).ready(function() {
   
	manageBooksDetailJqGridTable.init();
});

var manageBooksDetailJqGridTable = 
{
	
   init : function() {
      
      var cnames = ['아이디','분류기호','상태','반납기한','연결된 책 아이디', '구분'];
      
       $("#manageBooksDetailJqGrid").jqGrid({
          
           url: "manageBooksDetailJqGridMain.do",
           datatype: "local",
           colNames: cnames,
           colModel:[
                  {name:'id',      			index:'id',       		width:55,  key:true,    align:"center"},
                  {name:'callNumber',      	index:'callNumber',       	width:400,            align:"center"}, 
                  {name:'state',   index:'state',     width:100, editable:true, align:"center", edittype: "select", formatter:"select",
                      editoptions: {
                          
                          value         :   {"대출가능":"대출가능","대출중":"대출중", "대출불가":"대출불가"},
                          dataEvents   :   [{
                           type   :   'change',
                           fn   : function(e) {
                           
                           }
                          }]
                      }
                  },
                  {name:'returnTerm',      	index:'returnTerm',      	width:100,align:"center"},
                  {name:'bookId',      		index:'bookId',       	width:100,            align:"center"}, 
                  {name:'btn',      		index:'btn', 			width:100,  formatter:gridFunc.rowBtn}
         ],
           height         	: 400,
           rowNum         	: 10,
           rowList        	: [10,20,30],
           pager         	: '#manageBooksDetailJqGridPager',
           cellEdit      	: true, 
           cellsubmit      	: "clientArray", // 셀 수정하고 다른 셀을 클릭하면 바로 서버를 타게되는 성격이다. 그렇게 안하기 위해서는 이놈을 추가해 줘야 한다.
           multiselect      : true,      // 저장과 삭제 용도
           rownumbers     	: true,  
           
           onCellSelect : function(rowId, colId, val, e) {
              
              	var id = $("#manageBooksDetailJqGrid").getCell(rowId, "id");

            	if(!CommonJsUtil.isEmpty(id)) {

                    $("#manageBooksDetailJqGrid").setColProp("id", {editable:false});
                    $("#manageBooksDetailJqGrid").setColProp("callNumber", {editable:false});
                    $("#manageBooksDetailJqGrid").setColProp("state", {editable:false});
                    $("#manageBooksDetailJqGrid").setColProp("returnTerm", {editable:false});
                    $("#manageBooksDetailJqGrid").setColProp("bookId", {editable:false});
                } else {

                    $("#manageBooksDetailJqGrid").setColProp("id", {editable:true});
                    $("#manageBooksDetailJqGrid").setColProp("callNumber", {editable:true});
                    $("#manageBooksDetailJqGrid").setColProp("state", {editable:true});
                    $("#manageBooksDetailJqGrid").setColProp("returnTerm", {editable:true});
                    $("#manageBooksDetailJqGrid").setColProp("bookId", {editable:true});
              }
           },
       
           viewrecords : true,
           caption: "도서 '"+"<c:out value='${bookTitle}' />"+"' 내용 테이블"
       });

       var jsonObj = {"bookId":"<c:out value='${bookId}' />"};
    
       $("#manageBooksDetailJqGrid").setGridParam({
          		
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
   deleteData : function() {

	   var param = this.selectData('del');
	   
	   this.ajaxCallFn(param, "deletemanageBooksDetailJqGrid.do");
	},
 	saveData   :   function() {
	
	   	$("#manageBooksDetailJqGrid").editCell(0, 0, false);
	
       	// 저장 전 validation 체크
	   	if(!this.gridValid()){   
    	
	   		return false; 
    	}
     	
       	this.selectData('save');
     	
   	},
   	selectData : function(gubun) {
	   
	   var gubunText = gubun == 'save' ? '저장' : '삭제';
	      //체크박스의 체크된 것?을가져오는것
	   var checkData = $("#manageBooksDetailJqGrid").getGridParam("selarrrow");
	   
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
		   
		   var jsonObj = {};
		   
		   var id = $("#manageBooksDetailJqGrid").getCell(checkData[i], "id");
		   
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
	   
	   		jsonObj.callNumber =	$("#manageBooksDetailJqGrid").getCell(checkData[i], "callNumber");
	   		jsonObj.state =			$("#manageBooksDetailJqGrid").getCell(checkData[i], "state");
	   		jsonObj.returnTerm =	$("#manageBooksDetailJqGrid").getCell(checkData[i], "returnTerm");	
	   		jsonObj.bookId =		$("#manageBooksDetailJqGrid").getCell(checkData[i], "bookId");
	   		
	   		jsonArray[iCnt] = jsonObj;
	   		iCnt++;
	   		
	  	}	   
	   	var param = JSON.stringify(jsonArray);

     	this.ajaxCallFn(param,gubunText);
   },
   gridValid   :   function() {

	   	var selectedObj = $("#manageBooksDetailJqGrid").getGridParam("selarrrow");
    	
	  	//var trObj = $("#manageInfoBoardJqGrid").find("tr");
      
	  	for(var i=0; i<selectedObj.length; i++) {
	  		
	        var rowId = selectedObj[i];

	    	var callNumber = $("#manageBooksDetailJqGrid").getCell(rowId, "callNumber");
	    	var returnTerm = $("#manageBooksDetailJqGrid").getCell(rowId, "returnTerm");
	    		
	    	if(CommonJsUtil.isEmpty(callNumber)) {

	        	alert(rowId + "째 행의 분류기호는 꼭 적어주셔야 합니다.");
	                 
	          	return false;
	                
	            break;
	                 
	       	} else if(!CommonJsUtil.isEmpty(callNumber) && !CommonJsUtil.isDate(returnTerm)) {

	        	alert(rowId + "째 행의 반납기한은 YYYY/MM/DD 형식으로 날짜를 적어주셔야 합니다.");
	                 
	            return false;
	                 
	        	break;
	     	}
    	
        }
        return true; 
      
	},
	ajaxCallFn : function(param, gubunText) {
		
		$.ajax({
    		type			:	"POST",
    		url				: 	"saveManageBooksDetailJqGrid.do",
    		data			: 	{"param":param},
    		async			:	false,
    		beforeSend	:	function(xhr) {
    			
    		},
    		success		:	function(result) {
  				if(result == "SUCCESS") {
  						
  					alert("성공적으로 "+ gubunText +"하였습니다." );
  			
  					var lastPage = $("#manageBooksDetailJqGrid").getGridParam("lastpage");
					
  					if(gubunText == "삭제" && $("#manageBooksDetailJqGrid").getGridParam("reccount") 
  							== $("#manageBooksDetailJqGrid").getGridParam("selarrrow").length) {
								
						$("#manageBooksDetailJqGrid").setGridParam({
			                         
			                         page: lastPage 
			                      }).trigger("reloadGrid");
					} else {
						manageBooksDetailJqGridTable.goSearch();
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
    	  
         if(rowObject.id == "") {
            
               return '<a href="javascript:gridFunc.delRow('+options.rowId+');"> 행삭제 </a>';
         } else {
            
            return "";
         }
      },
      //행삭제
      delRow : function(rowid) {
       
         $("#manageBooksDetailJqGrid").delRowData(rowid);   
      },
      addRow : function() {
         
        var totalCnt = $("#manageBooksDetailJqGrid").getGridParam("records");
       		 
        var addData = {"id" : "", "callNumber" : "", "state" : "대출가능", "returnTerm" : "", "bookId" : "<c:out value='${bookId}' />"};
         
         // 행추가
        $("#manageBooksDetailJqGrid").addRowData(totalCnt + 1, addData);
         // 이후 각 행들을 수정가능하게 변경
        $("#manageBooksDetailJqGrid").setColProp("callNumber", {editable:true}); 
        $("#manageBooksDetailJqGrid").setColProp("state", {editable:true});   
        $("#manageBooksDetailJqGrid").setColProp("returnTerm", {editable:true});  
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

  	<div class="row" style="margin-left: 5px;">
      <div>
         <span><a href="#" class ="btn btn-info" onclick="javascript:gridFunc.addRow();">행추가</a></span>
         <span><a href="#" class ="btn btn-info" onclick="javascript:manageBooksDetailJqGridTable.saveData();">저장</a></span>
         <span><a href="#" class ="btn btn-info" onclick="javascript:manageBooksDetailJqGridTable.deleteData();">삭제</a></span>
      </div>
      <div class="space-10"></div>         
      <div>
         <table id="manageBooksDetailJqGrid"></table>
          <div id="manageBooksDetailJqGridPager"></div>
      </div>   
   </div>