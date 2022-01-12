<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <meta charset="utf-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

// 이 jsp 페이지에서 사용하는 함수들을 모아놓는 객체
var bookFn = {
	
	// 페이지를 이동시키는 메소드
	pageSubmitFn : function(searchParam, pageName) {
		
		$("#classification").val(searchParam);

		$("#bookFrm").attr("action", pageName+".do");	
		
		$("#bookFrm").submit();

	},
	// 아이템 혹은 리스트로 돌아가는 버튼을 눌렀을 때 화면 전환을 하게 해주는 메소드
	changeView : function(data) {
		
		var pageTitle = "";
		var pageUrl ="";
		
		if (History.enabled) {
			
			data.pageIndex =  History.getCurrentIndex();
			
			if(data.url.indexOf("List") != -1) {
				  
				pageTitle = "구립도서관 - 도서 리스트";
				pageUrl = "books.do";
			} else {

				pageTitle = "구립도서관 - 도서 정보";
				pageUrl = "libroBookContent";
			}	

        	bookAjaxFn.ajaxCallFn(data);
        		
	        History.pushState(data, pageTitle, pageUrl);
	            
	        return false;
		} else {
			
			return true;
	    }
	},
	rentBooks : function(memberId, bookDetailId){ 
		
		alert(memberId+"?"+bookDetailId);
	}
	
}

var bookAjaxFn = 
{
	ajaxCallFn : function(options) {
		
	    var settings = {
		         
		         url 	: "libroBookList.do",
		         index  : ""
		      }
		      
		      settings = $.extend({}, settings, options);
		   
		      $.ajax({
		         
		           type          : "POST",
		           url           : settings.url,
		           data      	 : {"index" : settings.index },
		           async         : false,
		           beforeSend    : function(xhr) {           
		         
		           },
		           success    : function(result) {
		              
		            var jsonRes = JSON.parse(result);

            		var strTags ="";
            		
	            	if(settings.url.indexOf("Content") !=-1) {
	            		

	            		if($("#searchBookList").length > 0) {
	            			
	            			$("#searchBookList").hide();
	            		}
	            		
	            		if($("#bookList").length > 0) {
	            			
	            			$("#bookList").remove();
	            		}
	            		
	            		
	            		
	            		var strDiv ='<div id="bookContent">'
		            					+'<div class="col-xs-12 col-md-10 pull-right">'				
		                    				+'<div class="space-20"></div>'
		                    				+'<div id="content">'
	            							+'</div>'
	            						+'</div>'
	            					+'</div>';
	            		$("#bookDiv").append(strDiv);
	            	} else {

	            		if($("#bookContent").length > 0) {
	            		
	            			$("#bookContent").remove();
	            		}
	            		
	            		if($("#searchBookList").length > 0) {
	            			
	            			$("#searchBookList").hide();
	            		}
	            		
	            		var strListDiv = '<div id="bookList">'
	            							+'<div class="col-xs-12 col-md-10 pull-right">'
	            								+'<h4>Search Box</h4>'
	                    						+'<div class="space-5"></div>'
	                    						+'<form action="#">'
	                        						+'<div class="input-group">'
	                            						+'<input type="text" class="form-control" placeholder="Enter book name">'
	                           							+'<div class="input-group-btn">'
	                                						+'<button type="submit" class="btn btn-primary"><i class="icofont icofont-search-alt-2"></i></button>'
	                            						+'</div>'
	                        						+'</div>'
	                    						+'</form>'
	                    						+'<div class="space-30"></div>'/* 
	                    						+'<div class="row">'
	                        						+'<div class="pull-left col-xs-12 col-sm-5 col-md-6">'
	                           							+'<p>Result For <a href="" class="text-primary">"How To Be a Designer"</a></p>'
	                            						+'<p><strong>6</strong> of <strong>76</strong> Book Found</p>'
	                       							+'</div>'
	                        						+'<div class="pull-right col-xs-12 col-sm-7 col-md-6">'
	                            						+'<form class="form-horizontal">'
	                                						+'<div class="form-group">'
	                                    						+'<label class="control-label col-xs-4" for="sort">Sont By : </label>'
	                                    						+'<div class="col-xs-8">'
	                                        						+'<div class="form-group">'
	                                            						+'<select name="sort" id="sort" class="form-control">'
	                                               							+'<option value="">Best Match</option>'
	                                               							+'<option value="">Best Book</option>'
	                                               							+'<option value="">Latest Book</option>'
	                                               							+'<option value="">Old Book</option>'
	                                            						+'</select>'
	                                        						+'</div>'
	                                   							+'</div>'
	                                						+'</div>'
	                            						+'</form>'
	                        						+'</div>'
	                   					 		+'</div>' */
	                    					+'<hr>'
	                    					+'<div class="space-20"></div>'
	                    					+'<div class="row">'
            								+'</div>'
            								+'</div>'
            							+'</div>';
            			$("#bookDiv").append(strListDiv);
	            	}
               		   	
		            $.each(jsonRes, function (i, item) {
		            	
		            	if(settings.url.indexOf("Content") != -1) {
		            		if(i==0) {
			            		strTags += '<div class="col-xs-12 col-md-12">'
			            					+'<div class="category-item well">'
	                        				+'<div class="media">'
	                            				+'<div class="media-left">'
	                                				+'<img src="' + item.imgDes + '" width ="150px" height="243px" class="media-object" alt="">'
	                            				+'</div>'
	                            				+'<div class="media-body">'
	                                				+'<h4>제목 : ' + item.title + '</h5>'
	                                				+'<h5>작가 : ' + item.author +'</h6>'
	                                				+'<h5>출판년도 : ' + item.publishDate + '</h6>'
	                                				+'<h5>페이지 : ' + item.bookPage + '</h6>'
	                                				+'<h5>분류 : '+ item.classification + '</h6>'
	                								+'<div class="space-10"></div>'
	                                				//+'<a href="#bookList" class="text-primary" >리스트로 가기</a>'
	                            				+'</div>'
	                            			+'</div>'
	                    					+'<div class="space-50"></div>';
                            				if(item.content) {
                            					
                            					strTags+='<p>'+ item.content + '</p>';
                            				} else {

                            					strTags+='<p> 내용 없음 </p>';
                            				}
                            	strTags+= '<div class="space-50"></div>'
                            				+'<table id="bookDetailTable" class="t-style">'
	            								+'<thead>'
	                								+'<tr>'
	                									+'<th style="text-align:center;">번호</th>'
	               										+'<th style="text-align:center;">청구기호</th>'
	               										+'<th style="text-align:center;">상태</th>'
	               										+'<th style="text-align:center;">반납일</th>'
	               										+'<th style="text-align:center;">대출</th>'
	            	        						+ '</tr>'
	               								+'</thead>'
	               								+'<tbody>'
	            		            				+'<tr>'
	    		            							+'<td>' + i + '</td>'
	    		            							+'<td>' + item.callNumber + '</td>'
	    		            							+'<td>' + item.state + '</td>';
	    		            							
	    		            	if(item.state != '대출가능') {

	    		            		strTags += '<td>' + item.returnTerm + '</td>';
	    		            	} else {

	    		            		strTags += '<td></td>'
	    		            				+'<td>'
												+'<c:if test="${loginVO != null }">'
													+ '<a style="cursor:pointer; cursor:hand;" class="text-primary" onclick="javascript:bookFn.rentBooks(\'<c:out value="${loginVO.id}" />\',\''+ item.bookDetailId +'\')">대출하기</a>'
												+'</c:if>'
												+'<c:if test="${loginVO == null }">'
													+ '회원 이용 서비스' 
												+'</c:if>'
											+ '</td>';
	    		            	}					 
	    		            			strTags += '</tr>'
	               								+'</tbody>'
	                            			+'</table>'
	                					+'</div>'
	                					+'</div>'
	                				+'</div>';
	                				
			                	$("#bookContent #content").append(strTags);
			                	strTags="";
			                	
		            		} else {
		            			strTags='<tr>'
		            						+'<td>' + i + '</td>'
		            						+'<td>' + item.callNumber + '</td>'
		            						+'<td>' + item.state + '</td>';
		    	    		    if(item.state != '대출가능') {
		    	    		           		
		    	    		    	strTags += '<td>' + item.returnTerm + '</td>';
		    	    		   	} else {

		    	    		    	strTags += '<td></td>';
		    	    		    }					 		
		            					+'</tr>';
		            					
		            			$("#bookContent #content table tbody").append(strTags);
		            		
		            		}

		            	} else {    
		            		
		            		strTags += '<div class="col-xs-12 col-md-6">'
                            			+'<div class="category-item well yellow">'
                                			+'<div class="media">'
                                    			+'<div class="media-left">'
                                        			+'<img src="'+ item.imgDes +'" width ="150px" height="243px" class="media-object" alt="dd">'
                                    			+'</div>'
                                    			+'<div class="media-body">'
                                        			+'<h5>제목 : ' + item.title + '</h5>'
                                        			+'<h6>작가 : ' + item.author +'</h6>'
                                        			+'<h6>출판년도 : ' + item.publishDate + '</h6>'
                                        			+'<h6>페이지 : ' + item.bookPage + '</h6>'
                                        			+'<h6>분류 : '+ item.classification + '</h6>'
                        							+'<div class="space-10"></div>'
                                        			+'<a style="cursor:pointer; cursor:hand;" class="text-primary"  onclick="javascript:bookFn.changeView({ \'url\': \'libroBookContent.do\' , \'index\' : \'' + item.id  +  '\'})" >상세히 보기</a>'
                                    			+'</div>'
                                			+'</div>'
                            			+'</div>'
                        			+'</div>';
		            	}

		            });

		            if(settings.url.indexOf("List")!=-1) {
		            	
		            	strTags += '<div class="space-60"></div>'
                    				+'<div class="row">'
                        				+'<div class="col-xs-12">'
                            				+'<div class="shop-pagination pull-right">'
                               					+'<ul id="pagination-demo" class="pagination-sm pagination">'
                                    				+'<li class="page-item first"><a href="#" class="page-link">First</a></li>'
                                    				+'<li class="page-item prev"><a href="#" class="page-link">Previous</a></li>'
                                    				+'<li class="page-item active"><a href="#" class="page-link">1</a></li>'
                                    				+'<li class="page-item"><a href="#" class="page-link">2</a></li>'
                                    				+'<li class="page-item"><a href="#" class="page-link">3</a></li>'
                                    				+'<li class="page-item"><a href="#" class="page-link">4</a></li>'
                                   					+'<li class="page-item"><a href="#" class="page-link">5</a></li>'
                                    				+'<li class="page-item"><a href="#" class="page-link">6</a></li>'
                                    				+'<li class="page-item"><a href="#" class="page-link">7</a></li>'
                                    				+'<li class="page-item next"><a href="#" class="page-link">Next</a></li>'
                                    				+'<li class="page-item last"><a href="#" class="page-link">Last</a></li>'
                                				+'</ul>'
                            				+'</div>'
                            			+'</div>'
                        			+'</div>'
                				+'</div>';
	                	$("#bookList .row:last-child").append(strTags);

		            } else {
		            	
		            	window.scrollTo(0,100);
		            }
		           },
		           error      : function() {
		              
		              alert("책 조회시 Error 발생");
		           }
		       }); 
		}
		   
}

$(document).ready(function(){	
	
    (function(window){
    	
		// History 객체를 초기화 해준다.
        var History = window.History;

        if ( !History.enabled ) {
        	
            return false;

        }
		/* 
			jquery.history.js 라이브러리에서 제공하는 함수
        	history.js는 굉장히 다양한 버전이 있는데 
	        https://github.com/browserstate/history.js <- 이 사이트를 이용해
	        html4와 html5 둘다 지원하는 것을 다운로드 받는 것이 좋은 것 같다.
	       	만약 html5만 지원하면 일부 브라우저에서 돌아가지 않는다.
			
	       	statechange는 앞으로가기 혹은 뒤로가기를 눌렀을 때 발생하는 이벤트이다.
	       	여기에서는 pushState를 했던 정보를 기반으로 페이지를 로드해준다.
	       	즉, ajax를 이용했을 때 뒤로가기, 앞으로가기가 가능한 것이다!
 		*/
		History.Adapter.bind(window,'statechange',function(){
			/*
				아래 internal이라는 변수를 사용하는 이유는 중복을 피하기 위해서이다.(여로개의 같은 url을 실행시키지 않기 위해서)
			*/
			
            var currentIndex = History.getCurrentIndex(); 
            
            var internal = (History.getState().data.pageIndex == (currentIndex - 1));
            
            if (!internal) {
            	// History에 저장된 ajax url을 불러온다.	
                ajaxUrl = History.getState().data.url;
                
            	// 저장된 url이 없다면 ajax를 이용한 페이지가 아닌 검색 페이지이다. 
                if(ajaxUrl != null) {
                	
                	// ajax 링크에 List가 포함되면 리스트를 동적으로 실행
                	if(ajaxUrl.indexOf("List") != -1) {
                		
                        bookAjaxFn.ajaxCallFn({url : ajaxUrl});
                    // Content가 포함되면 index(클릭한 아이템의 번호) 파라미터도 같이 넘겨준다.
                	} else if(ajaxUrl.indexOf("Content") != -1){

                        bookAjaxFn.ajaxCallFn({url : ajaxUrl, index : History.getState().data.index});
                	}	
            	} else {
            		
            		/* 
            			저장된 url이 없는경우는 검색 화면 혹은 리스트 화면에서 뒤로가기를 누른 경우로 나눌 수 있다.
            			만약 bookList의 id가 있는 경우는 리스트 화면에서 뒤로가기를 누른 상황이다.
            			그게 아니면 검색을 통해 들어온 경우이다.(이는 else문으로 따로 처리해준다.)
            		*/
            		if($("#bookList").length > 0) {
	        			// 두번 뒤로간다. History에 맨처음 url과 ajax로 만든 url이 두개가 겹쳐져서 뒤로가기 안되는 것을 방지
            			History.back();
            			History.back();
	        		} else {
					/*
						검색을 통해 온 페이지의 경우
						리스트는 원래 생성된 것을 그대로 사용하고
						아이템을 보는경우는 ajax로 동적 페이지를 만든다. 
						그렇기 때문에 기존에 아이템페이지에서 리스트로 돌아가는 경우이면 
						#bookContent를 제거 해야 한다.
					*/
            			if($("#bookContent").length > 0) {
            				
            				$("#bookContent").remove();
            			}
            		
            			if($("#searchBookList").length > 0) {
            				
            				$("#searchBookList").show();
            			}
	        		}
            	}
            	
            }
        });

        

    })(window);
    
	if("<c:out value='${state}' />" != 'search') {

		// 히스토리를 사용할 수 있다면
	  	if (History.enabled) {
	    	
	  		//pushState함수를 이용해 현재 페이지를 저장한다.
	  		History.pushState({ pageIndex: History.getCurrentIndex(), url: "libroBookList.do" }, "구립도서관 - 도서 리스트", "books.do" );
 		
	  	} else {
		
	  		return false;
		}
		// 검색으로 들어온 경우가 아니면 기존에 있던 것을 잠시 숨겨놓는다.
	  	$("#searchBookList").hide();
		// 그리고 ajax를 이용해 전체 도서 페이지를 불러온다.
    	bookAjaxFn.ajaxCallFn({url : "libroBookList.do"});
	} else {
		
		// 검색페이지는 링크를 눌러서 (nav페이지에서 누름) 온 것이 아니기 때문에 하이라이트 처리가 안 되있어서 여기서 처리해준다.
		$("body").attr("data-spy", "spyscroll");
		$("body").attr("data-target", ".navbar-default");
		$("#mainmenu ul li.active").removeClass("active");
		$("#mainmenu ul li:last-child").addClass("active");
		// 검색 페이지는 파라미터로 현재 페이지 인덱스만 넘겨주면 된다. 그리고 url은 현재 url 그대로 사용한다.
	  	if (History.enabled) {
	  		
			History.pushState({ pageIndex: History.getCurrentIndex() }, "구립도서관 - 도서 리스트", window.location.href);
	  		
			return true;
	  	} else {
	  		return false;
	  	}
	}
	
});
</script>

<form id="bookFrm" name="bookFrm">
	<input type="hidden" id="classification"  name="classification" />
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
        <!-- Header-jumbotron-end -->
	</nav>    
	<section>
        <div class="space-80"></div>
        <div class="container">
            <div class="row" id="bookDiv">
			<div id="searchBookList">
                <div class="col-xs-12 col-md-10 pull-right">
                    <h4>Search Box</h4>
                    <div class="space-5"></div>
                    <form action="searchBook.do">
                        	<div class="col-md-2 ">
                        		<div class="form-group">
                    			<select class="form-control" name="searchSelect">
                    				<option>제목</option>
                    				<option>작가</option>
                    				<option>출판사</option>
                    			</select>
                    			</div>
                            </div>
                        <div class="input-group">
                        	<div class="col-md-14">
                            <input type="text" class="form-control" placeholder="키워드를 입력해주세요." name="title">
                            </div>
                            <div class="input-group-btn">
                                <button type="submit" class="btn btn-primary"><i class="icofont icofont-search-alt-2"></i></button>
                            </div>
                        </div>
                    </form>
                    <div class="space-30"></div>
                    <div class="row">
                        <div class="pull-left col-xs-12 col-sm-5 col-md-6">
                            <p><c:out value="${searchDataMap.type}" /> 검색으로 <strong>키워드 '<c:out value="${searchDataMap.keyword}" />' </strong>로 찾은 결과 </p>
                            <p><strong><c:out value="${findBookCnt}" /> 건</strong> 의 결과를 찾았습니다.</p>
                        </div>
                        <div class="pull-right col-xs-12 col-sm-7 col-md-6">
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <label class="control-label col-xs-4" for="sort">Sont By : </label>
                                    <div class="col-xs-8">
                                        <div class="form-group">
                                            <select name="sort" id="sort" class="form-control">
                                                <option value="">Best Match</option>
                                                <option value="">Best Book</option>
                                                <option value="">Latest Book</option>
                                                <option value="">Old Book</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <hr>
                    <div class="space-20"></div>
                    <div class="row">
                    <c:forEach var="bookList" items ="${searchBookList}">
                    <div class="col-xs-12 col-md-6">
                            <div class="category-item well yellow">
                                <div class="media">
                                    <div class="media-left">
                                        <img src="<c:out value="${ bookList.imgDes }" />" width ="150px" height="243px" class="media-object" alt="">
                                    </div>
                                    <div class="media-body">
                                        <h5>제목 : <c:out value="${ bookList.title }" /></h5>
                                        <h6>작가 : <c:out value="${ bookList.author }" /></h6>
                                        <h6>출판년도 : <c:out value="${ bookList.publishYear }" /></h6>
                                        <h6>페이지 : <c:out value="${ bookList.page }" /></h6>
                                        <h6>분류 : <c:out value="${ bookList.classification }" /></h6>
                                        <div class="space-10"></div>
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor</p>
                                        <a class="text-primary"onclick="javascript:bookFn.changeView({ 'url': 'libroBookContent.do' , 'index' : '<c:out value= '${ bookList.id }' />' })" >상세히 보기</a>                                       
                                    </div>
                                </div>
                            </div>
                        </div>
                        </c:forEach>
                   </div> 
                    <div class="space-60"></div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="shop-pagination pull-right">
                                <ul id="pagination-demo" class="pagination-sm pagination">
                                    <li class="page-item first"><a href="#" class="page-link">First</a></li>
                                    <li class="page-item prev"><a href="#" class="page-link">Previous</a></li>
                                    <li class="page-item"><a href="#" class="page-link">1</a></li>
                                    <li class="page-item"><a href="#" class="page-link">2</a></li>
                                    <li class="page-item active"><a href="#" class="page-link">3</a></li>
                                    <li class="page-item"><a href="#" class="page-link">4</a></li>
                                    <li class="page-item"><a href="#" class="page-link">5</a></li>
                                    <li class="page-item"><a href="#" class="page-link">6</a></li>
                                    <li class="page-item"><a href="#" class="page-link">7</a></li>
                                    <li class="page-item next"><a href="#" class="page-link">Next</a></li>
                                    <li class="page-item last"><a href="#" class="page-link">Last</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div> 
                </div> 
                <!-- Sidebar-Start -->
                <div class="col-xs-12 col-md-2">
                    <aside>
                        <h3><i class="icofont icofont-filter"></i> Filter By</h3>
                        <div class="space-30"></div>
                        <div class="sigle-sidebar">
                            <h4>카테고리</h4>
                            <hr>
                            <ul class="list-unstyled menu-tip">
                                <li><a style="cursor:pointer; cursor:hand;" onclick="javascript:bookFn.pageSubmitFn('일반', 'searchBook')">일반</a></li>
                                <li><a style="cursor:pointer; cursor:hand;" onclick="javascript:bookFn.pageSubmitFn('철학', 'searchBook')">철학</a></li>
                                <li><a style="cursor:pointer; cursor:hand;" onclick="javascript:bookFn.pageSubmitFn('종교', 'searchBook')">종교</a></li>
                                <li><a style="cursor:pointer; cursor:hand;" onclick="javascript:bookFn.pageSubmitFn('사회과학', 'searchBook')">사회과학</a></li>
                                <li><a style="cursor:pointer; cursor:hand;" onclick="javascript:bookFn.pageSubmitFn('자연과학', 'searchBook')">자연과학</a></li>
                                <li><a style="cursor:pointer; cursor:hand;" onclick="javascript:bookFn.pageSubmitFn('기술과학', 'searchBook')">기술과학</a></li>
                                <li><a style="cursor:pointer; cursor:hand;" onclick="javascript:bookFn.pageSubmitFn('예술', 'searchBook')">예술</a></li>
                                <li><a style="cursor:pointer; cursor:hand;" onclick="javascript:bookFn.pageSubmitFn('언어',' searchBook')">언어</a></li>
                                <li><a style="cursor:pointer; cursor:hand;" onclick="javascript:bookFn.pageSubmitFn('문학', 'searchBook')">문학</a></li>
                                <li><a style="cursor:pointer; cursor:hand;" onclick="javascript:bookFn.pageSubmitFn('역사', 'searchBook')">역사</a></li>
                            </ul>
                            <a class="btn btn-primary btn-xs" onclick="javascript:bookFn.changeView({ url: 'libroBookList.do'})">See All</a>
                        </div>
                        <div class="space-20"></div>
                        <div class="sigle-sidebar">
                            <h4>다양하게 자료 보기</h4>
                            <hr>
                            <ul class="list-unstyled menu-tip">
                                <li><a href="#">신착자료</a></li>
                                <li><a href="#">대출베스트</a></li>
                            </ul>
                           <!--  <h4>Rating</h4>
                            <hr>
                            <ul class="list-inline list-unstyled rating-star">
                                <li class="active"><i class="icofont icofont-star"></i></li>
                                <li class="active"><i class="icofont icofont-star"></i></li>
                                <li class="active"><i class="icofont icofont-star"></i></li>
                                <li class="active"><i class="icofont icofont-star"></i></li>
                                <li class="active"><i class="icofont icofont-star"></i></li>
                            </ul> -->
                        </div>
                    </aside>
                </div>
                <!-- Sidebar-End -->
            </div>
        </div>
        <div class="space-80"></div>
        </section>