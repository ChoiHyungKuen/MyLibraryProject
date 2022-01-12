<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
	var mainFn = {
		// 페이지를 이동시키는 메소드
		pageSubmitFn : function(param, pageName) {

			if (pageName == 'libroBookContent') {

				$("#bookId").val(param);
				
			}

			$("#mainFrm").attr("action", pageName + ".do");

			$("#mainFrm").submit();

		},
		clickWrtieBoardItem :function(memberId){
			
			var url = "changeBoardItemInfoMain.do";
			var params = "?memberId="+memberId;
			var opt = "width=600, height=560";
				
			window.open(url+params, "", opt);
		},
		clickChangeBoardItem : function(listContent, page){
			
			var url = "changeBoardItemInfoMain.do";
			var params = "?no="+ listContent.no + "&title=" + listContent.title + "&content="+ listContent.content
						+ "&eventDate=" + listContent.eventDate + "&type=" + listContent.type +"&page="+page;
			var opt = "width=600, height=560";
				
			window.open(url+params, "", opt);
		},
		setCalendar : function (data){

			//alert(data);
			var date = new Date();

			var jsonData = data;
			
			var d = date.getDate();
		 	var m = date.getMonth();
			var y = date.getFullYear();

			$("#calendar").fullCalendar({
					lang : "ko",
					header : {
						left : "prev,next today",
						center : "title",
						right : "month,basicWeek,basicDay"
					},
					views : {

						month : { // name of view
									titleFormat : "YYYY년 MMMM",
									eventLimit : 4
								// other view-specific options here
								},
						week : { // name of view
									titleFormat : "YYYY년 MMMM D(yyyy)일 "
								// other view-specific options here
								},
						day : { // name of view
									titleFormat : "YYYY년 MMM D일 dddd"
								// other view-specific options here
								}

					},
					allDayDefault : true,
					defaultView : "month",
					editable : false,
					monthNames : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월",
									"9월", "10월", "11월", "12월" ],
					monthNamesShort : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월",
									"8월", "9월", "10월", "11월", "12월" ],
					dayNames : [ "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일" ],
					dayNamesShort : [ "일", "월", "화", "수", "목", "금", "토" ],
					buttonText : {
						today : "오늘",
						month : "월별",
						week : "주별",
						day : "일별",
					},
					events: jsonData,
					dayClick:function( date, allDay, jsEvent, view ) {
				        $("#calendar").fullCalendar('gotoDate', date);

				    },
			        eventRender: function(event, element) {
			            $(element).tooltip({title: event.description,container: "body"});      
			        },
			        
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
	var libroInfoBoardFn = {

		viewLibroInfoBoardContent : function(listContent, page) {

			$("#boardListButtonGroup").hide();
			$("#boardList").hide();
			$("#boardPagination").hide();
			
			var strTags = "";
			
			strTags += '<div id="boardContent">'
			 		+ '<div class="fix">'
					+ '<a href="#sc5" class="btn btn-default pull-right hover-btn-primary" onclick="javascript:libroInfoBoardFn.viewLibroInfoBoardList()">'
					+ '리스트로 돌아가기'
					+ '<span><i class="icofont icofont-long-arrow-right"></i></span></a>'
					+ '</div>';

			if(listContent.memberId == "<c:out value='${loginVO.id}'/>") {
						
				strTags += '<div class="fix">'
						+ '<a href=\'#sc5\' class=\'btn btn-default pull-right hover-btn-primary\' onclick=\'javascript:mainFn.clickChangeBoardItem('+ JSON.stringify(listContent) + ','+ page +')\'>'
							+ '글 수정 및 삭제'
						+ '<span><i class="icofont icofont-long-arrow-right"></i></span></a>'
						+ '</div>' ;
			}			

			strTags += '<div class="event-item wow fadeInRight">'
						+ '<h4 class="show tip-left">'
							+ listContent.type +' ';

			if (listContent.eventDate != null) {
			
				strTags += ' 일정 : ' + listContent.eventDate;
			} 

				strTags += '</h4>'
						+ '<div class="well">'
							+ '<div class="media">'
								+ '<div class="media-left">';		
								
			if (listContent.imgDes != null) {

				strTags += '<img src="'+listContent.imgDes +'" class="media-object" alt="dd">';
			}

						strTags += '</div>' 
						+ '<div class="media-body">'
							+ '<div class="space-10"></div>'
							+ '<h4 class="media-heading">' + listContent.title + '</h4>' 
							+ '<div class="space-10"></div>' 
							+ '<p>' + listContent.content + '</p>' 
						+ '</div>'
					+ '</div>'
					+ '<h6><span class="pull-right">'+ listContent.createdDate+ '에 '+ listContent.name +'님이 작성(수정)</span></h6>' 
				+ '</div>'
				+ '<div class="space-20"></div>' 
			+ '</div>';

			$("#board").append(strTags);
		},
		viewLibroInfoBoardList : function() {

			$("#boardContent").remove();
			$("#boardList").show();
			$("#boardListButtonGroup").show();
			$("#boardPagination").show();

		}
	}

	// 메인에서 사용하는 AJAX를 묶어놓음
	var mainAjaxFn = {
		
		initCalendarAjaxCallFn : function() {
			  
			$.ajax({
				   
				type : "POST",
			    url : "initCalendar.do",
				success : function(result) {
					
					var jsonRes = JSON.parse(result);
					
					var resArr = [];
					
					$.each(jsonRes,function(i, item) {
						var transData = {};
						transData.title = item.title;
						transData.start = item.startDate;
						transData.end = item.endDate;
						transData.description = item.description;
						resArr[i] = transData;
					});
					 
					 mainFn.setCalendar(resArr);
					 
				 },
				 error : function(request, status, error) {
				
					 alert("달력 로딩 실패");
				 
				 }		
			});
		},
		// 게시판과 최근현황을 컨텍스트해서 동적으로 HTML을 가져오게 합니다.
		ajaxCallFn : function(options) {

			var settings = {

				url : "recentLibroBoardList.do",
				state : "load"
			}

			settings = $.extend({}, settings, options);

			$.ajax({
				
				type : "POST",
				url : settings.url,
				async : false,
				beforeSend : function(xhr) {

				},
				success : function(result) {

					var jsonRes = JSON.parse(result);

					var strTags = "";

					if (settings.url.indexOf("recent") != -1) {

						if ($("#boardListButtonGroup").length > 0) {
							
							$("#boardListButtonGroup").remove();
						}
								
						if ($("#boardList").length > 0) {
							
							$("#boardList").remove();
						}

						var strDiv = '<div id="recentBoard">'
										+ '<div class="hidden-xs hidden-sm col-md-5 inner-photo wow fadeInLeft">'
											+ '<img src="images/event-inner-image.png" class="img-responsive" alt="library">'
										+ '</div>'
										+ '<div class="col-xs-12 col-md-7 pull-right">'
										+ '</div>' 
									+ '</div>';
						
						$("#board").append(strDiv);

						} else {
							
							if ($("#recentBoard").length > 0) {
								
								$("#recentBoard").remove();
							}

							if ($("#boardList").length > 0) {
									
								$("#boardList").remove();
							}

							if ($("#boardListButtonGroup").length > 0) {
							
								$("#boardListButtonGroup").remove();
							}
							var strTags = '<div id="boardListButtonGroup" style="float:right;width:20%;margin-left:-20px;">'
									 	+ '<div class="space-50"></div>'
										+ '<div class="fix">'
											+ '<a href="#sc5" class="btn btn-default pull-right hover-btn-primary" onclick="javascript:mainAjaxFn.ajaxCallFn({ \'url\': \'recentLibroBoardList.do\' })">'
											+ '메인창 돌아가기'
											+ '<span><i class="icofont icofont-long-arrow-right"></i></span></a>'
										+ '</div>' 
										+ '<div class="space-30"></div>';
										
							<c:if test="${ loginVO != null}">										
							strTags += '<div class="fix">'
										+ '<a href="#sc5" class="btn btn-default pull-right hover-btn-primary" onclick="javascript:mainFn.clickWrtieBoardItem(\'${loginVO.id}\')">'
											+ '글 작성'
										+ '<span><i class="icofont icofont-long-arrow-right"></i></span></a>'
									+ '</div>';		
							</c:if> 
										
							strTags+='</div>';
								
							$("#board").append(strTags);
								
							var strTable = '<div id="boardList" style="width:80%;margin-left:10px;">'
											+ '<table id="boardTable" class="t-style">'
											+ '<thead>'
												+ '<tr>'
													+ '<th style="text-align:center;">번호</th>'
													+ '<th style="text-align:center;">제목</th>'
													+ '<th style="text-align:center;">종류</th>'
													+ '<th style="text-align:center;">작성자</th>'
													+ '<th style="text-align:center;">작성일(수정일)</th>'
												+ '</tr>'
											+ '</thead>'
											+ '<tbody>'
											+ '</tbody>'
										+ '</table>'
									+ '</div>';
								
							$("#board").append(strTable);
							
						}
						
						var strTr = "";
						
						if (settings.url.indexOf("recent") != -1) {

							$.each(jsonRes,function(i, item) {

								if (i == 2) {
									
									return false;
								}

								strTags += '<div class="event-item wow fadeInRight">'
											+ '<h4 class="show tip-left">'
												+ item.type +' ';

								if (item.eventDate != null) {
								
									strTags += ' 일정 : '
											+ item.eventDate;
								} 

									strTags += '</h4>'
											+ '<div class="well">'
												+ '<div class="media">'
													+ '<div class="media-left">';
								
								if (item.imgDes != null) {
														
									strTags += '<img src="'+item.imgDes +'" class="media-object" alt="dd">';
								}

											strTags += '</div>'
													+ '<div class="media-body">'
														+ '<div class="space-10"></div>'
														+ '<h4 class="media-heading">'+ item.title + '</h4>'
														+ '<div class="space-10"></div>'
														+ '<p>' + item.content + '</p>'
													+ '</div>'
												+ '</div>'
												+ '<h6><span class="pull-right">'+ item.createdDate+ '에 '+ item.name +'님이 작성(수정)</span></h6>'
												+ '</div>'
												+ '<div class="space-20"></div>';
							});
						
						} else {
							
							var testList = jsonRes.pagingList;
							
							$.each(JSON.parse(testList), function(i, item) {

							/*  item을 매개변수로 넘기기위해 object를 json string으로 변경
								그리고 밑에 a 태그 보면 다른태그와 달리 \'\' 로 속성들을 감싸는데 
								그 이유는 json 데이터의 "" 와 겹치기 때문..	
							 */

								var pageMap = JSON.parse(jsonRes.resMap);
								var jsonConvertedData = JSON.stringify(item);

								strTr = "";
								strTr += '<tr>'
											+ '<td>' + item.no + '</td>'
											+ '<td>'
												+ '<a href=\'#sc5\' onclick=\'javascript:libroInfoBoardFn.viewLibroInfoBoardContent('
													+ jsonConvertedData +',' + pageMap.page
												+ ')\'>' + item.title + '</a>' 
											+ '</td>'
											+ '<td>' + item.type + '</td>' 
											+ '<td>' + item.name + '</td>' 
											+ '<td>' + item.createdDate + '</td>' 
										+ '</tr>';
							
								$("#boardTable tbody").append(strTr);
							});

						}

						if (settings.url.indexOf("recent") != -1) {
							
							strTags += '<div class="fix">'
										+ '<a href="#sc5" class="btn btn-default pull-right hover-btn-primary" onclick="javascript:mainAjaxFn.ajaxCallFn({ \'url\': \'libroBoardList.do\' })">'
											+ '더 보기'
										+ '<span><i class="icofont icofont-long-arrow-right"></i></span></a>'
									+ '</div>'
							
							$("#recentBoard div:last-child").append(strTags);
						
						} else {

							var strTag = "";
							
							var resMap = JSON.parse(jsonRes.resMap);
							
							strTag += '<ul id="boardPagination" class="pagination-sm pagination" >';

							if (resMap.pageGroup > 1) {
								
								strTag += '<li class="page-item first" ><a href="#sc5" onclick="javascript:mainAjaxFn.ajaxCallFn({ \'url\': \'libroBoardList.do?page=1\' })>처음</a></li>'
										+ '<li class="page-item prev"><a href="#sc5" onclick="javascript:mainAjaxFn.ajaxCallFn({ \'url\': \'libroBoardList.do?page=' + resMap.prePage + '\'>)">«</a></li>';
							}
							var end = (resMap.endPage > resMap.total) ? (resMap.total) : (resMap.endPage);

							for (var i = resMap.startPage; i <= end; i++) {
								
								if (resMap.page == i) {
									
									strTag += '<li class="page-item active"><a href="#sc5" onclick="javascript:mainAjaxFn.ajaxCallFn({ \'url\': \'libroBoardList.do?page=' + i + '\'})">' + i + '</a></li>';
								
								} else {
									
									strTag += '<li class="page-item"><a href="#sc5" onclick="javascript:mainAjaxFn.ajaxCallFn({ \'url\': \'libroBoardList.do?page='+ i + '\'})">'+ i + '</a></li>';
									
								}
							}
	
							if (resMap.nextPage <= resMap.total) {

								strTags += '<li class="next"><a href="#sc5" onclick="javascript:mainAjaxFn.ajaxCallFn({ \'url\': \'libroBoardList.do?page=' + resMap.nextPage + '\'})">»</a></li>'
										+ '<li class="last"><a href="#sc5" onclick="javascript:mainAjaxFn.ajaxCallFn({ \'url\': \'libroBoardList.do?page=' + resMap.total + '\'})">끝</a></li>';
							}
								
							strTag += '</ul>';
								
							$("#boardList").append(strTag);
						}
					},
					error : function() {

						alert("게시판 조회시 Error 발생");
					}
				});
			}

	}
	function onmessage(e) {
		
		if(e.data == "manageLibroInformation") {
			$("#libroInformationDiv").hide();
			$("#libroInformationDiv").before("<input type='text'/>");
			
		}
	}
	$(document).ready(function() {

		mainAjaxFn.ajaxCallFn({
			url : "recentLibroBoardList.do",
			state : "load"
		});
		
		mainAjaxFn.initCalendarAjaxCallFn();
	});
</script>

<form id="mainFrm" name="mainFrm">
	<input type="hidden" id="bookId"  name="bookId" />
</form>
        <!-- Header-jumbotron -->
        <div class="space-100"></div>
        <div class="header-text">
            <div class="container">
                <div class="row wow fadeInUp">
                    <div class="col-xs-12 col-sm-10 col-sm-offset-1 text-center">
                        <div class="jumbotron">
                            <h1 class="text-white"><c:out value="${ libroBookCnt }" />권 의 책이 있습니다!</h1>
                            <p class="text-white">책을 통해 세상과 소통하는 공간! 정보도서관에 오신 것을 환영합니다!</p>
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
                <div class="row wow fadeInUp" data-wow-delay="0.5s">
                    <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 ">
                        <div class="panel">
                            <div class="panel-heading">
                                <ul class="nav nav-tabs">
                                    <li class="active"><a data-toggle="tab" href="#book">책 이름</a></li>
                                    <li><a data-toggle="tab" href="#author">저자</a></li>
                                    <li><a data-toggle="tab" href="#publisher">출판사</a></li>
                                </ul>
                            </div>
                            <div class="panel-body">
                                <div class="tab-content">
                                    <div class="tab-pane fade in active" id="title">
										<form action="searchBook.do">		
                                            <div class="input-group">
                                                <input type="text" class="form-control" placeholder="책 이름을 입력해주세요." name="title">
                                                <div class="input-group-btn">
                                                    <button type ="submit" class="btn btn-primary"><i class="icofont icofont-search-alt-2"></i></button>
                                                </div>
                                            </div>
                                       	</form>
                                    </div>
                                    <div class="tab-pane fade" id="author">
										<form action="searchBook.do">				
                                            <div class="input-group">
                                                <input type="text" class="form-control" placeholder="저자 이름을 입력해주세요." name="author">
                                                <div class="input-group-btn">
                                                    <button type ="submit" class="btn btn-primary"><i class="icofont icofont-search-alt-2"></i></button>
                                                </div>
                                            </div>
                                       	</form>
                                    </div>
                                    <div class="tab-pane fade" id="publisher">
										<form action="searchBook.do">				
                                            <div class="input-group">
                                                <input type="text" class="form-control" placeholder="출판사 이름을 입력해주세요" name="publisher">
                                                <div class="input-group-btn">
                                                    <button type ="submit" class="btn btn-primary"><i class="icofont icofont-search-alt-2"></i></button>
                                                </div>
                                            </div>
                                       	</form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <div class="space-100"></div>
    </nav>
    <section class="gray-bg" id="sc2">
        <div class="space-80"></div>
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 text-center">
                    <h2> <strong>도서관</strong> 안내</h2>
                    <div class="space-20"></div>
                    <div class="title-bar blue">
                        <ul class="list-inline list-unstyled">
                            <li><i class="icofont icofont-square"></i></li>
                            <li><i class="icofont icofont-square"></i></li>
                        </ul>
                    </div>
                    <div class="space-30"></div>
                   	<p style="font-size:18px;white-space:nowrap; font-weight:bold;">구립도서관 통합 시스템 홈페이지를 찾아주셔서 감사합니다.</p>
                    <p>편리하고 신속한 자료제공을 위하여 모든 구립도서관 및 동문고의 자료를 NETWORK로 연결하는 통합시스템을 운영하고 있습니다. </p>
                  	<p>앞으로 보다 나은 독서서비스 제공을 위하여 노력하겠으며, <br> 구립도서관의 많은 이용바랍니다.  </p>
         
                </div>
            </div>
            <div class="space-60"></div>
            <div class="row">
                <div class="hidden-xs hidden-sm col-sm-5 pull-right  wow fadeInRight">
                    <div class="space-60"></div>
                    <div class="my-slider">
                        <ul>
                            <li><img src="images/about-slide/about1.jpg" alt="library"></li>
                            <li><img src="images/about-slide/about2.jpg" alt="library"></li>
                            <li><img src="images/about-slide/about3.jpg" alt="library"></li>
                            <li><img src="images/about-slide/about4.jpg" alt="library"></li>
                            <li><img src="images/about-slide/about5.jpg" alt="library"></li>
                            <li><img src="images/about-slide/about6.jpg" alt="library"></li>
                        </ul>
                    </div>
                    <div class="mama"></div>
                </div>
                <div class="col-xs-12 col-md-7">
                    <ul class="list-unstyled list-inline text-yellow tip">
                        <li><i class="icofont icofont-square"></i></li>
                        <li><i class="icofont icofont-square"></i></li>
                        <li><i class="icofont icofont-square"></i></li>
                    </ul>
                    <div class="space-15"></div>
                    <p style="font-size:20px; font-weight:bold;">이용시간</p>
                    <p>일반도서관 06:00 - 22:00 <br>전자정보관 09:00 - 20:00 <br>매점 10:00 - 21:00</p>
                    <div class="space-60"></div>
                    <div class="row">
                        <div class="col-xs-12 col-sm-6 wow fadeIn">
                            <ul class="list-unstyled list-inline icon-bar">
                                <li><i class="icofont icofont-id-card"></i></li>
                            </ul>
                            <h3><strong>다양한 시설</strong></h3>
                            <p>회원님을 위한 휴게실, 매점, 강당, <br>문화교실 등을 운영하고 있습니다.
                            </p>
                            <div class="space-30"></div>
                        </div>
                        <div class="col-xs-12 col-sm-6 wow fadeIn">
                            <ul class="list-unstyled list-inline icon-bar">
                                <li><i class="icofont icofont-medal-alt"></i></li>
                            </ul>
                            <h3><strong>높은 질의 다양한 책들</strong></h3>
                            <p>회원님의 독서 질을 높이기위해 다양하고<br> 많은 책을 구비하고 있습니다. 
                            </p>
                            <div class="space-30"></div>
                        </div>
                        <div class="col-xs-12 col-sm-6 wow fadeIn">
                            <ul class="list-unstyled list-inline icon-bar">
                                <li><i class="icofont icofont-read-book-alt"></i></li>
                            </ul>
                            <h3><strong>다양한 행사</strong></h3>
                            <p>회원님을 위해 독서 뿐 아닌 <br> 다양한 행사를 주최하고 있습니다.
                            </p>
                            <div class="space-30"></div>
                        </div>
                        <div class="col-xs-12 col-sm-6 wow fadeIn">
                            <ul class="list-unstyled list-inline icon-bar">
                                <li><i class="icofont icofont-book-alt"></i></li>
                            </ul>
                            <h3><strong>빠른 책 업데이트</strong></h3>
                            <p>회원님의 즐거운 독서를 위해 <br> 빠르게 최신의 책을 구비하고 있습니다.
                            </p>
                            <div class="space-30"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-60"></div>
    </section>
    <section>
        <div class="space-80"></div>
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 text-center">
                    <h2>우리의 <strong>카테고리</strong></h2>
                    <div class="space-20"></div>
                    <div class="title-bar blue">
                        <ul class="list-inline list-unstyled">
                            <li><i class="icofont icofont-square"></i></li>
                            <li><i class="icofont icofont-square"></i></li>
                        </ul>
                    </div>
                    <div class="space-30"></div>
                    <p>우리는 많은 분야의 책을 가지고 있습니다. 원하는 분야를 선택해주세요.</p>
                </div>
            </div>
            <div class="space-40"></div>
            <div></div>
            <div class="row text-center">
                <c:forEach var="classificationList" items="${ classificationList }">
                <div class="col-xs-12 col-sm-6 col-md-3 wow fadeInLeft" data-wow-delay="0.1s">
                        	<c:choose>
                        		<c:when test="${ classificationList eq '일반' }">                   
                        			<div class="category-item well red text-cetnr">
                        			<div class="category_icon">
                            		<i class="icofont icofont-brainstorming"></i>
                            	</c:when>
                        		<c:when test="${ classificationList eq '철학' }">             
                        			<div class="category-item well orange text-cetnr">
                        			<div class="category_icon">
                            		<i class="icofont icofont-institution"></i>
                            	</c:when>
                        		<c:when test="${ classificationList eq '종교' }">             
                        			<div class="category-item well yellow text-cetnr">
                        			<div class="category_icon">
                            		<i class="icofont icofont-tree-alt"></i>
                            	</c:when>
                        		<c:when test="${ classificationList eq '과학' }">             
                        			<div class="category-item well green text-cetnr">
                        			<div class="category_icon">
                            		<i class="icofont icofont-electron"></i>
                            	</c:when>
                        		<c:when test="${ classificationList eq '예술' }">             
                        			<div class="category-item well sky text-cetnr">
                        			<div class="category_icon">
                            		<i class="icofont icofont-paint"></i>
                            	</c:when>
                        		<c:when test="${ classificationList eq '언어' }">             
                        			<div class="category-item well blue text-cetnr">
                        			<div class="category_icon">
                            		<i class="icofont icofont-abc"></i>
                            	</c:when>
                        		<c:when test="${ classificationList eq '문학' }">             
                        			<div class="category-item well violet text-cetnr">
                        			<div class="category_icon">
                            		<i class="icofont icofont-quill-pen"></i>
                            	</c:when>
                            	<c:otherwise>             
                        			<div class="category-item well purple text-cetnr">
                        			<div class="category_icon">
                            		<i class="icofont icofont-globe-alt"></i>
                            	</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="space-10"></div>
                        <div class="title-bar">
                            <ul class="list-inline list-unstyled">
                                <li><i class="icofont icofont-square"></i></li>
                            </ul>
                        </div>
                        <div class="space-10"></div>
                        <a style="cursor:pointer; cursor:hand;" onclick="javascript:nav.pageSubmitFn('<c:out value="${ classificationList }"/>', 'searchBook',1)"><c:out value="${ classificationList }"/></a>
                    </div>
                </div>
				</c:forEach>                
            </div>
            <div class="space-50"></div>
            <div class="row">
                <div class="col-xs-12 text-center">
                	<a class="btn btn-primary" onclick="javascript:nav.pageSubmitFn('','books',1)">전체 보기</a>
                </div>
            </div>
            <div class="space-50"></div>
        </div>
    </section>
    <section class="relative fix" id="sc3">
       <div class="overlay-bg blue"><!-- 
            <img src="images/blur-bg.jpg" alt="library"> -->
        </div> 
        <div class="container-fluid">
            <div class="row">
                <div class="col-xs-12 col-md-6 book-list-position padding60  ">
                    <div class="book-list-photo">
                        <div class="book-list">
                        	
                        	<c:forEach var="bestThreeBookList" items="${ bestThreeBookList }"> 
                            <div class="book_item">
                                <img src="<c:out value='${bestThreeBookList.imgDes }'/>" alt="library">
                            </div>
                            </c:forEach>
                         	<!--
                         	<div class="book_item">
                                <img src="images/book/book2.png" alt="library">
                            </div>
                            <div class="book_item">
                                <img src="images/book/book3.png" alt="library">
                            </div> 
                            <div class="book_item">
                                <img src="images/book/book1.jpg" alt="library">
                            </div>
                            <div class="book_item">
                                <img src="images/book/book1.jpg" alt="library">
                            </div>
                            <div class="book_item">
                                <img src="images/book/book2.jpg" alt="library">
                            </div>
                            <div class="book_item">
                                <img src="images/book/book3.jpg" alt="library">
                            </div>
                            <div class="book_item">
                                <img src="images/book/book1.jpg" alt="library">
                            </div> -->
                        </div>
                    </div>
                    <div class="bookslide_nav">
                        <i class="icofont icofont-long-arrow-left testi_prev"></i>
                        <i class="icofont icofont-long-arrow-right testi_next"></i>
                    </div>
                </div>
                <div class="col-xs-12 pull-right col-md-6 padding60 gray-bg wow fadeInRight">
                    <div class="space-60"></div>
                    <div class="row">
                        <div class="col-xs-12 col-sm-8 col-md-6">
                            <h2>이 달의 <strong>책</strong></h2>
                            <div class="space-10"></div>
                            <div class="title-bar left blue">
                                <ul class="list-inline list-unstyled">
                                    <li><i class="icofont icofont-square"></i></li>
                                    <li><i class="icofont icofont-square"></i></li>
                                </ul>
                            </div>
                            <div class="space-20"></div>
                        </div>
                    </div>
                    <div class="space-20"></div>
                    <div class="book-content">
                        <div class="book-details">
                        	<c:forEach var="bestThreeBookList" items="${ bestThreeBookList }"> 
                            <div class="book-details-item">
                                <h4 class="tip-left">제목</h4>
                                <p class="lead"><c:out value="${bestThreeBookList.title }"/></p>
                                <div class="space-10"></div>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-4">
                                        <h4 class="tip-left">저자</h4>
                                        <div class="media">
                                            <div class="media-body">
                                                <h5><c:out value="${bestThreeBookList.author }"/></h5>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 col-sm-4">
                                        <h4>출판사</h4>
                                        <p><c:out value="${bestThreeBookList.publisher }"/></p>
                                    </div>
                                    <div class="col-xs-12 col-sm-4">
                                        <h4>페이지</h4>
                                        <p><c:out value="${bestThreeBookList.bookPage }"/></p>
                                    </div>
                                </div>
                                <div class="space-30"></div>
                                
                                <h4 class="tip-left">내용</h4>
                                <p>   
                              	<c:choose>
                                   		<c:when test="${bestThreeBookList.content != null && bestThreeBookList.content != '' }">
                                   			<c:out value="${ bestThreeBookList.content }" />
                                	</c:when>
                                   		<c:otherwise>
                                   			내용없음
                                	</c:otherwise>
                                </c:choose>
                                </p>
                               
                                <div class="space-20"></div><!-- 
                                <h4 class="tip-left">별점</h4>
                                <ul class="list-inline list-unstyled rating-star">
                                    <li class="active"><i class="icofont icofont-star"></i></li>
                                    <li class="active"><i class="icofont icofont-star"></i></li>
                                    <li class="active"><i class="icofont icofont-star"></i></li>
                                    <li class=""><i class="icofont icofont-star"></i></li>
                                    <li><i class="icofont icofont-star"></i></li>
                                </ul> -->
                                <div class="space-20"></div>
                               	<a href="#" class="btn btn-primary hover-btn-default" onclick="javascript:nav.pageSubmitFn('<c:out value="${ bestThreeBookList.id }" />', 'libroBookContent', 1)">자세히 보기</a>
                            </div>
                            </c:forEach>
                           <!--  <div class="book-details-item">
                                <h4 class="tip-left">제목</h4>
                                <p class="lead">뇌를 자극하는 윈도우즈 시스템 프로그래밍</p>
                                <div class="space-10"></div>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-8">
                                        <h4 class="tip-left">저자</h4>
                                        <div class="media">
                                            <div class="media-left">
                                                <img src="images/client/client3.jpg" class="media-object author-photo img-thumbnail" alt="library">
                                            </div>
                                            <div class="media-body">
                                                <h5>윤성우</h5>
                                                <p>인기 개발 도서 저자</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 col-sm-4">
                                        <h4>페이지</h4>
                                        <p>410 pages</p>
                                    </div>
                                </div>
                                <div class="space-30"></div>
                                <h4 class="tip-left">설명</h4>
                                <p>이 책은 거의 모든 개발자가 궁금해 하면서도 또한 상당히 어려워하는 컴퓨터 구조, 운영체제, 시스템 프로그래밍의 내용 중 꼭 필요한 부분만 간추려서 담았다. 컴퓨터 구조와 운영체제에 대한 이야기는 시스템 프로그래밍이라는 큰 주제와 어우러져 프로그래밍 안쪽에 있는 “깊이”를 전달하며, “큰 그림”을 보여준다. 개념을 알기 쉽게 설명하기 위해 수많은 일러스트 이미지를 담았고, 정확한 이해를 돕고 응용력을 키우기 위해 명령 프롬프트 프로젝트를 적재적소에 넣었다. </p>
                                <div class="space-20"></div>
                                <h4 class="tip-left">별점</h4>
                                <ul class="list-inline list-unstyled rating-star">
                                    <li class="active"><i class="icofont icofont-star"></i></li>
                                    <li class="active"><i class="icofont icofont-star"></i></li>
                                    <li class="active"><i class="icofont icofont-star"></i></li>
                                    <li class="active"><i class="icofont icofont-star"></i></li>
                                    <li><i class="icofont icofont-star"></i></li>
                                </ul>
                                <div class="space-20"></div>
                                <a href="books.html" class="btn btn-primary hover-btn-default">See The Book</a>
                                <a href="books.html" class="btn btn-primary hover-btn-default">Read Later</a>
                            </div>
                            <div class="book-details-item">
                                <h4 class="tip-left">Title</h4>
                                <p class="lead">The Whispering mage</p>
                                <div class="space-10"></div>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-8">
                                        <h4 class="tip-left">Author</h4>
                                        <div class="media">
                                            <div class="media-left">
                                                <img src="images/client/client3.jpg" class="media-object author-photo img-thumbnail" alt="library">
                                            </div>
                                            <div class="media-body">
                                                <h5>Maikel jekson</h5>
                                                <p>23 Books Created</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 col-sm-4">
                                        <h4>Page</h4>
                                        <p>320 pages</p>
                                    </div>
                                </div>
                                <div class="space-30"></div>
                                <h4 class="tip-left">Description</h4>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla libero dui, pretium non tincidunt eget, mattis eu nunc. Aenean egestas nisi vel urna tempus aliquam. Etiam fringilla tempor risus. Nulla vitae elementum felis. Vestibulum ultricies feugiat est id ornare. Morbi non dapibus ante.</p>
                                <div class="space-20"></div>
                                <h4 class="tip-left">Rating</h4>
                                <ul class="list-inline list-unstyled rating-star">
                                    <li class="active"><i class="icofont icofont-star"></i></li>
                                    <li class=""><i class="icofont icofont-star"></i></li>
                                    <li class=""><i class="icofont icofont-star"></i></li>
                                    <li class=""><i class="icofont icofont-star"></i></li>
                                    <li><i class="icofont icofont-star"></i></li>
                                </ul>
                                <div class="space-20"></div>
                                <a href="books.html" class="btn btn-primary hover-btn-default">See The Book</a>
                                <a href="books.html" class="btn btn-primary hover-btn-default">Read Later</a>
                            </div>
                            <div class="book-details-item">
                                <h4 class="tip-left">Title</h4>
                                <p class="lead">Stream of Window</p>
                                <div class="space-10"></div>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-8">
                                        <h4 class="tip-left">Author</h4>
                                        <div class="media">
                                            <div class="media-left">
                                                <img src="images/author.jpg" class="media-object author-photo img-thumbnail" alt="library">
                                            </div>
                                            <div class="media-body">
                                                <h5>Jeck kalis</h5>
                                                <p>23 Books Created</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 col-sm-4">
                                        <h4>Page</h4>
                                        <p>320 pages</p>
                                    </div>
                                </div>
                                <div class="space-30"></div>
                                <h4 class="tip-left">Description</h4>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla libero dui, pretium non tincidunt eget, mattis eu nunc. Aenean egestas nisi vel urna tempus aliquam. Etiam fringilla tempor risus. Nulla vitae elementum felis. Vestibulum ultricies feugiat est id ornare. Morbi non dapibus ante.</p>
                                <div class="space-20"></div>
                                <h4 class="tip-left">Rating</h4>
                                <ul class="list-inline list-unstyled rating-star">
                                    <li class="active"><i class="icofont icofont-star"></i></li>
                                    <li class="active"><i class="icofont icofont-star"></i></li>
                                    <li class="active"><i class="icofont icofont-star"></i></li>
                                    <li class="active"><i class="icofont icofont-star"></i></li>
                                    <li><i class="icofont icofont-star"></i></li>
                                </ul>
                                <div class="space-20"></div>
                                <a href="books.html" class="btn btn-primary hover-btn-default">See The Book</a>
                                <a href="books.html" class="btn btn-primary hover-btn-default">Read Later</a>
                            </div>
                            <div class="book-details-item">
                                <h4 class="tip-left">Title</h4>
                                <p class="lead">The Ashes's Wizards</p>
                                <div class="space-10"></div>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-8">
                                        <h4 class="tip-left">Author</h4>
                                        <div class="media">
                                            <div class="media-left">
                                                <img src="images/client/client2.jpg" class="media-object author-photo img-thumbnail" alt="library">
                                            </div>
                                            <div class="media-body">
                                                <h5>Drean stain</h5>
                                                <p>23 Books Created</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 col-sm-4">
                                        <h4>Page</h4>
                                        <p>320 pages</p>
                                    </div>
                                </div>
                                <div class="space-30"></div>
                                <h4 class="tip-left">Description</h4>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla libero dui, pretium non tincidunt eget, mattis eu nunc. Aenean egestas nisi vel urna tempus aliquam. Etiam fringilla tempor risus. Nulla vitae elementum felis. Vestibulum ultricies feugiat est id ornare. Morbi non dapibus ante.</p>
                                <div class="space-20"></div>
                                <h4 class="tip-left">Rating</h4>
                                <ul class="list-inline list-unstyled rating-star">
                                    <li class="active"><i class="icofont icofont-star"></i></li>
                                    <li class="active"><i class="icofont icofont-star"></i></li>
                                    <li class="active"><i class="icofont icofont-star"></i></li>
                                    <li class="active"><i class="icofont icofont-star"></i></li>
                                    <li><i class="icofont icofont-star"></i></li>
                                </ul>
                                <div class="space-20"></div>
                                <a href="books.html" class="btn btn-primary hover-btn-default">See The Book</a>
                                <a href="books.html" class="btn btn-primary hover-btn-default">Read Later</a>
                            </div>
                            <div class="book-details-item">
                                <h4 class="tip-left">Title</h4>
                                <p class="lead">The Time of the Soul</p>
                                <div class="space-10"></div>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-8">
                                        <h4 class="tip-left">Author</h4>
                                        <div class="media">
                                            <div class="media-left">
                                                <img src="images/client/client2.jpg" class="media-object author-photo img-thumbnail" alt="library">
                                            </div>
                                            <div class="media-body">
                                                <h5>Robi Bopara</h5>
                                                <p>23 Books Created</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 col-sm-4">
                                        <h4>Page</h4>
                                        <p>320 pages</p>
                                    </div>
                                </div>
                                <div class="space-30"></div>
                                <h4 class="tip-left">Description</h4>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla libero dui, pretium non tincidunt eget, mattis eu nunc. Aenean egestas nisi vel urna tempus aliquam. Etiam fringilla tempor risus. Nulla vitae elementum felis. Vestibulum ultricies feugiat est id ornare. Morbi non dapibus ante.</p>
                                <div class="space-20"></div>
                                <h4 class="tip-left">Rating</h4>
                                <ul class="list-inline list-unstyled rating-star">
                                    <li class="active"><i class="icofont icofont-star"></i></li>
                                    <li class="active"><i class="icofont icofont-star"></i></li>
                                    <li class="active"><i class="icofont icofont-star"></i></li>
                                    <li class="active"><i class="icofont icofont-star"></i></li>
                                    <li><i class="icofont icofont-star"></i></li>
                                </ul>
                                <div class="space-20"></div>
                                <a href="books.html" class="btn btn-primary hover-btn-default">See The Book</a>
                                <a href="books.html" class="btn btn-primary hover-btn-default">Read Later</a>
                            </div> -->
                        </div>
                    </div>
                    <div class="space-60"></div>
                </div>
            </div>
        </div>
    </section>
    <section id="sc4">
        <div class="space-80"></div>
        <div class="container">
                <div class="col-xs-12 col-sm-8 col-sm-offset-2 text-center" style ="margin-right:25%;s">
                    <h2><strong>도서관 일정</strong></h2>
           			<div class="space-10"></div>
                    <div class="title-bar blue">
                        <ul class="list-inline list-unstyled">
                            <li><i class="icofont icofont-square"></i></li>
                            <li><i class="icofont icofont-square"></i></li>
                        </ul>
                    </div> 
                </div>
           		<div class="space-20"></div>
            	<div class="row">         	
       				 <div class="space-20"></div>
                    <div id="calendar"></div>
           		</div>
           <!--  <div class="space-60"></div>
            <div class="row team_slide text-center">
                <div class="col-xs-12">
                    <div class="well single-team">
                        <h4>Alan Walker</h4>
                        <span>Librarian</span>
                        <div class="space-10"></div>
                        <ul class="list-inline list-unstyled social-list">
                            <li><a href="#"><i class="icofont icofont-social-facebook"></i></a></li>
                            <li><a href="#"><i class="icofont icofont-social-twitter"></i></a></li>
                            <li><a href="#"><i class="icofont icofont-social-behance"></i></a></li>
                            <li><a href="#"><i class="icofont icofont-brand-linkedin"></i></a></li>
                        </ul>
                        <div class="space-20"></div>
                        <div class="title-bar">
                            <ul class="list-inline list-unstyled">
                                <li><i class="icofont icofont-square"></i></li>
                            </ul>
                        </div>
                        <div class="space-20"></div>
                        <div class="team-member-photo relative">
                            <img src="images/team/team1.jpg" alt="library">
                            <div class="team_overlay_icon">
                                <a href="books.html" class="btn btn-default">See Prolife</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-12">
                    <div class="well single-team">
                        <div class="team-member-photo relative">
                            <img src="images/team/team-2.jpg" alt="library">
                            <div class="team_overlay_icon">
                                <a href="books.html" class="btn btn-default">See Prolife</a>
                            </div>
                        </div>
                        <div class="space-20"></div>
                        <div class="title-bar">
                            <ul class="list-inline list-unstyled">
                                <li><i class="icofont icofont-square"></i></li>
                            </ul>
                        </div>
                        <div class="space-20"></div>
                        <h4>Steven William</h4>
                        <span>Director</span>
                        <div class="space-10"></div>
                        <ul class="list-inline list-unstyled social-list">
                            <li><a href="#"><i class="icofont icofont-social-facebook"></i></a></li>
                            <li><a href="#"><i class="icofont icofont-social-twitter"></i></a></li>
                            <li><a href="#"><i class="icofont icofont-social-behance"></i></a></li>
                            <li><a href="#"><i class="icofont icofont-brand-linkedin"></i></a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-xs-12">
                    <div class="well single-team">
                        <h4>Harry T Nevvit</h4>
                        <span>Manager</span>
                        <div class="space-10"></div>
                        <ul class="list-inline list-unstyled social-list">
                            <li><a href="#"><i class="icofont icofont-social-facebook"></i></a></li>
                            <li><a href="#"><i class="icofont icofont-social-twitter"></i></a></li>
                            <li><a href="#"><i class="icofont icofont-social-behance"></i></a></li>
                            <li><a href="#"><i class="icofont icofont-brand-linkedin"></i></a></li>
                        </ul>
                        <div class="space-20"></div>
                        <div class="title-bar">
                            <ul class="list-inline list-unstyled">
                                <li><i class="icofont icofont-square"></i></li>
                            </ul>
                        </div>
                        <div class="space-20"></div>
                        <div class="team-member-photo relative">
                            <img src="images/team/team-3.jpg" alt="library">
                            <div class="team_overlay_icon">
                                <a href="books.html" class="btn btn-default">See Prolife</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-12">
                    <div class="well single-team">
                        <div class="team-member-photo relative">
                            <img src="images/team/team-3.jpg" alt="library">
                            <div class="team_overlay_icon">
                                <a href="books.html" class="btn btn-default">See Prolife</a>
                            </div>
                        </div>
                        <div class="space-20"></div>
                        <div class="title-bar">
                            <ul class="list-inline list-unstyled">
                                <li><i class="icofont icofont-square"></i></li>
                            </ul>
                        </div>
                        <div class="space-20"></div>
                        <h4>Harry T Nevvit</h4>
                        <span>Manager</span>
                        <div class="space-10"></div>
                        <ul class="list-inline list-unstyled social-list">
                            <li><a href="#"><i class="icofont icofont-social-facebook"></i></a></li>
                            <li><a href="#"><i class="icofont icofont-social-twitter"></i></a></li>
                            <li><a href="#"><i class="icofont icofont-social-behance"></i></a></li>
                            <li><a href="#"><i class="icofont icofont-brand-linkedin"></i></a></li>
                        </ul>
                    </div>
                </div>
            </div> -->
        </div>
        <div class="space-80"></div>
    </section>
    <section class="gray-bg relative" id="sc5">
        <div class="space-80"></div>
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 text-center">
                    <h2><strong>정보광장</strong></h2>
                    <div class="space-20"></div>
                    <div class="title-bar blue">
                        <ul class="list-inline list-unstyled">
                            <li><i class="icofont icofont-square"></i></li>
                            <li><i class="icofont icofont-square"></i></li>
                        </ul>
                    </div>
                    <div class="space-30"></div>
                    <p>저희 도서관의 최신 정보를 확인하실 수 있습니다. <br>혹은 문의사항이 있으시면 글을 남겨주시십시오.</p>
                </div>
            </div>
            <div class="space-60"></div>
            <div class="row event-list" id ="board">
            
       <%--     <div id ="recentBoard">
            <div class="hidden-xs hidden-sm col-md-5 inner-photo wow fadeInLeft">
                    <img src="images/event-inner-image.png" class="img-responsive" alt="library">
                </div>
                <div class="col-xs-12 col-md-7 pull-right">
                <c:forEach items="${libroInfoDataList}" var = "libroInfoDataList"  varStatus="status">
                	<c:if test="${status.index <=1 }">
                	<div class="event-item wow fadeInRight">	
                        <h4 class="show tip-left">
                        	<c:choose>
                        		<c:when test="${libroInfoDataList.type == '행사' }">
                        			<c:out value="행사 시작일 : ${libroInfoDataList.eventDate}" />
                        		</c:when>
                        		<c:otherwise>
                        			<c:out value="정보" />
                        		</c:otherwise>
                        	</c:choose>
                        </h4>
                       	<div class="well">
                            <div class="media">
                                	<div class="media-left">
                                    	<img src="${libroInfoDataList.imgDes}" class="media-object" alt="">
                                	</div>
                                <div class="media-body">
                                    <div class="space-10"></div>
                                    <a href="books.html"><h4 class="media-heading"><c:out value="${libroInfoDataList.title} " /></h4></a>
                                    <div class="space-10"></div>
                                    <p><c:out value="${libroInfoDataList.content}" /></p>
                                </div>
                            </div>
                            
                    <h6><span class="pull-right"><c:out value="${libroInfoDataList.createdDate}에 작성됨" /></span></h6>
                        
                        </div>
                    </div> 
                    <div class="space-20"></div>
                    </c:if>
                    </c:forEach>
                <!-- 
                    <div class="event-item wow fadeInRight">
                        <h4 class="show tip-left">2017년 2월 17일 화요일<span class="pull-right">오후 12시30분</span></h4>
                        <div class="well">
                            <div class="media">
                                <div class="media-left">
                                    <img src="images/evemt/event1.jpg" class="media-object" alt="library">
                                </div>
                                <div class="media-body">
                                    <div class="space-10"></div>
                                    <a href="books.html"><h4 class="media-heading">네트워킹 데이&amp; 강의</h4></a>
                                    <div class="space-10"></div>
                                    <p>이 날은 많은 멘토 분들이 참가하여 여러가지 강의도 하고 다양한 조언도 들을 수 있습니다. <br>많은 참여바랍니다.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="space-20"></div>
                    <div class="event-item wow fadeInRight">
                        <h4 class="show tip-left">2017년 4월 15일 금요일<span class="pull-right">오후 2시</span></h4>
                        <div class="well">
                            <div class="media">
                                <div class="media-left">
                                    <img src="images/evemt/event2.jpg" class="media-object" alt="library">
                                </div>
                                <div class="media-body">
                                    <div class="space-10"></div>
                                    <a href="books.html"><h4 class="media-heading">독서 경진 대회</h4></a>
                                    <div class="space-10"></div>
                                    <p>책을 많이 읽는 독서인을 양성하기 위한 취지로 독서대회가 개최됩니다. 푸짐한 상품이 여러분을 기다립니다. 많은 참여바랍니다. </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="space-20"></div> 
                    <div class="fix">
                        <a href="#" class="btn btn-default pull-right hover-btn-primary">View More <span><i class="icofont icofont-long-arrow-right"></i></span></a>
                    </div>
                  </div>
                </div>
                  --%>
                  
            </div>
        </div>
        <div class="space-80"></div>
    </section>
    <section class="relative" id="sc6">
        <div class="overlay-bg">
            <img src="images/libro-info-bg.jpg" alt="library">
        </div>
        <div class="space-80"></div>
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 text-center">
                    <h2 class="text-white">이용시 <strong>주의사항</strong></h2>
                    <div class="space-20"></div>
                    <div class="title-bar white">
                        <ul class="list-inline list-unstyled">
                            <li><i class="icofont icofont-square"></i></li>
                            <li><i class="icofont icofont-square"></i></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="space-60"></div>
            <div class="row text-white testimonial-slide">
                <c:forEach var="libroInformationList" items="${libroInformationList }">
                <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 text-center">
                    
                    <h5 class="text-white"><c:out value="${ libroInformationList.title }" /></h5>
                    <span class="show"><c:out value="${ libroInformationList.content }" /></span>
                    <div class="space-30"></div>
                    <c:if test="${ libroInformationList.explanation != null }">
                    <q><c:out value="${ libroInformationList.explanation }" /></q>
                    </c:if>
                    <div class="space-30"></div>
                </div>
                </c:forEach>
                <!-- 
                <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 text-center">
                    <h5 class="text-white">대여 가능 권수를 확인하세요.</h5>
                    <span class="show">일반회원은 최대 2권, 우수회원은 최대 4권 대여 가능합니다.</span>
                    <div class="space-30"></div>
                    <q>원할한 독서 활동을 위해 개인 대여 권수가 지정되어있습니다. </q>
                    <div class="space-30"></div>
                    <img src="images/client/client1.jpg" class="img-thumbnail img-circle" alt="library">
                </div>
                <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 text-center">
                    <h5 class="text-white">더 즐거운 독서를! 우수회원에 대해..</h5>
                    <span class="show">도서 대여를 30회 이상하고, 대여기한을 3회이상 어기지 않은 회원이 우수회원이 됩니다.</span>
                    <div class="space-30"></div>
                    <q>저희 도서관은 우수회원제도를 통해 즐거운 독서 활동을 장려합니다.<br>우수회원에게는 저희 도서관의 많은 혜택을 드립니다.(매점 할인, 많은 대여 등) </q>
                    <div class="space-30"></div>
                    <img src="images/client/client3.jpg" class="img-thumbnail img-circle" alt="library">
                </div> -->
            </div>
        </div>
        <div class="space-60"></div>
        <div class="space-80"></div>
    </section>
    <section class="bg-primary relative">
        <div class="space-80"></div>
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-7">
                    <h2 class="text-white">즐기세요! <strong>당신의 책을</strong></h2>
                    <div class="space-20"></div>
                    <div class="title-bar left white">
                        <ul class="list-inline list-unstyled">
                            <li><i class="icofont icofont-square"></i></li>
                            <li><i class="icofont icofont-square"></i></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="space-60"></div>
            <div class="row">
                <div class="col-xs-12 col-sm-7">
                    <form action="#">
                        <div class="row">
                            <div class="col-xs-12 col-sm-6">
                                <div class="form-group">
                                    <label for="name">이름</label>
                                    <input type="text" id="registerName" class="form-control bg-none" placeholder="이름을 입력해주세요.">
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6">
                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="email" id="registerEmail" class="form-control bg-none" placeholder="이메일을 입력해주세요.">
                                </div>
                            </div>
                            <div class="space-20"></div>
                            <div class="col-xs-12 col-sm-6">
                                <a class="btn btn-default" onclick="javascript:nav.clickRegisterMember()">새 계정 생성<i class="fa fa-long-arrow-right"></i></a>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="hidden-xs col-sm-5 outer-image wow fadeInRight">
                    <img src="images/register-member-image.png" alt="library">
                </div>
            </div>
        </div>
        <div class="space-80"></div>
    </section>