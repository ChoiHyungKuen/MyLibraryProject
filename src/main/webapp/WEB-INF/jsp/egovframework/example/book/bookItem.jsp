<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
var bookFn = 
{
	rentBook : function(memberId, bookDetailId) {
		
		var rentCheck = confirm("정말로 대여하시겠습니까?");
		if(rentCheck) {
			
			var page = "<c:out value='${page}'/>";
			
			$("#itemPage").val(page);
			$("#userId").val(memberId);
			$("#bookDetailId").val(bookDetailId);
			$("#bookItemFrm").attr("action", "rentBook.do");
			$("#bookItemFrm").submit();
		}
	},
	reserveBook : function(memberId, rentId) {
		
		var rentCheck = confirm("정말로 예약하시겠습니까?");
		if(rentCheck) {
			
			var page = "<c:out value='${page}'/>";
			
			$("#itemPage").val(page);
			$("#userId").val(memberId);
			$("#rentId").val(rentId);
			$("#bookItemFrm").attr("action", "reserveBook.do");
			$("#bookItemFrm").submit();
		}
	}
}
var reviewFn = 
{
	saveReviewInfo : function(editType){
			
		<c:if test="${loginVO == null}" >
			alert("회원인 경우만 리뷰를 작성하실 수 있습니다.");
			return ;
		</c:if>
			
		if($("#reviewContent").val() == "" || $("#reviewContent").val().length <= 1) {
				
			alert("리뷰는 두 글자 이상은 작성하셔야 합니다.");
			return ;
		} else if($("#inputRating").val() == "") {
				
			alert("리뷰 별점은 0점보다 크게 줘야 합니다.");
			return; 
		}
		
		if(confirm("정말로 리뷰를 추가하시겠습니까?")) {
		
			$("#itemPage").val("<c:out value='${page}'/>");
			
			$("#reviewEditType").val(editType);
			
			$("#thisBookId").val("<c:out value="${ bookContent.id }"/>");
			
			$("#userId").val("<c:out value='${loginVO.id}'/>");
			
			$("#ratingScore").val($("#inputRating").val());
			
			$("#ratingContent").val($("#reviewContent").val());
			
			$("#bookItemFrm").attr("action", "reviewSaveAndDeleteTx.do");
			
			$("#bookItemFrm").submit();
		}
	},
	updateAndDeleteReviewInfo : function(reviewId, editType, index){
		
		if(editType == "U") {

			var content = $(".input-review"+index+" textarea").val();
			var score = $(".update-user-rating"+index).val();
			
			if(content == "" || content.length <= 1) {
					
				alert("리뷰는 두 글자 이상은 작성하셔야 합니다.");
				return ;
			} else if(score == "") {
					
				alert("리뷰 별점은 0점보다 크게 줘야 합니다.");
				return; 
			}
			
			if(confirm("정말로 수정하시겠습니까?")) {

				$("#itemPage").val("<c:out value='${page}'/>");
				
				$("#ratingScore").val(score);
					
				$("#ratingContent").val(content);
			} else {
				
				return ;
			}
		} else {

			if(!confirm("정말로 삭제하시겠습니까?")) {

				return ;
			}
			
		}

		$("#reviewEditType").val(editType);
		$("#reviewId").val(reviewId);
		$("#thisBookId").val("<c:out value="${ bookContent.id }"/>");
		
		$("#bookItemFrm").attr("action", "reviewSaveAndDeleteTx.do");
			
		$("#bookItemFrm").submit();
	},
	changeUpdateMode : function(reviewId, index) {
		
		$("#userRatingList .userReview"+index).hide();
		
		var score = $(".user-rating"+index).val();
		var content = $("#userRatingList .userReview"+index+" .review-content").text().trim();
		var strTags = '<div class="input-review'+ index + '">'
							+ '<div class="space-50"></div>'
							+ '<input name="userRating" class="rating-loading update-user-rating'+index+'" value="' + score+ '"'
							+ ' type="hidden" data-size="xs" style="display:inline;">'
							+ '<span class="user-review-counter">'+ content.length +'/150</span>'
							+ '<textarea class="user-review-content" maxlength="150"></textarea>'
							+ '<div class="space-10"></div>'
							+ '<div class="review-buttonGroup">'
								+ '<a class="btn btn-primary" onclick="javascript:reviewFn.updateAndDeleteReviewInfo(\''+reviewId+'\',\'U\','+index+')">확인</a>'	
	            				+ '<a class="btn btn-danger" onclick="javascript:reviewFn.cancelUpdateMode('+ index +')">취소</a>'
							+ '</div>'
						+'</div>'
		
		if($("#userRatingList .userReview"+(index-1)).length > 0) {

			$("#userRatingList .userReview"+(index-1)).after(strTags);
		} else if($("#userRatingList .input-review"+index-1).length > 0) {
			
			$("#userRatingList .input-review"+(index-1)).after(strTags);
		} else {
			
			$("#userRatingList").prepend(strTags);
		}
						
		$(".input-review"+index+" textarea").val(content);

		$(".update-user-rating"+index).rating({
			min: 0, max: 5, step: 0.1, stars: 5,
			starCaptions: function(val) {
			return val + "점";
			}, 
			language: 'ko'
		});

	},
	cancelUpdateMode : function(index) {

		$("#userRatingList .input-review"+index).remove();
		$("#userRatingList .userReview"+index).show();
	}	
}
$(document).ready(function(){	
	
	$("body").attr("data-spy", "spyscroll");
	$("body").attr("data-target", ".navbar-default");
	$("#mainmenu ul li.active").removeClass("active");
	$("#mainmenu ul li[name=자료검색]").addClass("active");
	
	if("<c:out value='${isCheck}'/>" == "Y") {
		
		alert("<c:out value='${message}'/>");
	}
	
	<c:if test="${loginVO == null}">
		$("#reviewContent").val("도서관 회원만 이용 가능합니다. 회원가입후에 이용해주세요.");
		$("#reviewContent").attr("disabled","true");
	</c:if>
	
	$("#inputRating").rating({min: 0, max: 5, step: 0.1, stars: 5,
		starCaptions: function(val) {
			return val + "점";
		}, language: 'ko'
	});
	
	$("input[name='userRating']").rating({
		disabled : true,
		min: 0, max: 5, step: 0.1, stars: 5,
		starCaptions: function(val) {
			return val + "점";
		}, 
		language: 'ko'
	});
	
	$(function() {
	      $('#reviewContent').keyup(function (e){
	          var content = $(this).val();
	          
	          if(content.length > 150) {
	        	  alert("서평은 150자까지만 입력가능합니다.");

	        	  content = content.substring(0, 150);
	        	  $("#reviewContent").val(content);
	          }
	          $("#reviewCounter").html(content.length + '/150');
	      });
	      $("#reviewContent").keyup();
	      
	});

	$(function() {
	      $('#user-review-content').keyup(function (e){
	          var content = $(this).val();
	          
	          if(content.length > 150) {
	        	  alert("서평은 150자까지만 입력가능합니다.");

	        	  content = content.substring(0, 150);
	        	  $("#user-review-content").val(content);
	          }
	          $("#user-review-counter").html(content.length + '/150');
	      });
	      $("#user-review-content").keyup();
	      
	});
});
</script>
<form id="bookItemFrm" name="bookItemFrm" method="POST">
	<input type="hidden" id="itemPage"  name="page" />
	<input type="hidden" id="userId"  name="userId" />
	<input type="hidden" id="bookDetailId"  name="bookDetailId" />
	<input type="hidden" id="rentId"  name="rentId" />
	<input type="hidden" id="thisBookId"  name="bookId" />
	<input type="hidden" id="ratingScore"  name="ratingScore" />
	<input type="hidden" id="ratingContent"  name="ratingContent" />
	<input type="hidden" id="reviewEditType"  name="editType" />
	<input type="hidden" id="reviewId"  name="reviewId" />
</form>
        <!-- Header-jumbotron -->
        <div class="space-100"></div>
        <div class="header-text">
            <div class="container">
                <div class="row wow fadeInUp">
                    <div class="col-xs-12 col-sm-10 col-sm-offset-1 text-center">
                        <div class="jumbotron">
                        	<h1 class="text-white">사람은 책을 만들고<br>책은 사람을 만든다</h1>
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
   </nav>
        <!-- Header-jumbotron-end -->
   <section>
         <div class="space-80"></div>
        <div class="container">
            <div class="row">
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
                    <hr>
                    <div class="space-20"></div>
                    <div class="row">
                        <div class="col-xs-12 col-md-12">
                            <div class="category-item well yellow">
                     			<div class="space-5"></div>
                                <div class="media">          
                                    <div class="media-left">     	
                                	<c:choose>
                                		<c:when test="${ bookContent.imgDes !=null }">
                                    		<img src="<c:out value='${ bookContent.imgDes }'/>"  width ="150px" class="media-object" alt="">
                                    	</c:when>
                                    	<c:otherwise>
                                    	     <img src="images/book/book_no_image.png"  width ="150px" style="height:200px;" class="media-object" alt="">
                                    	</c:otherwise>
                                	</c:choose>
                                    </div>
                                    <div class="media-body">
                                        <h2><c:out value='${ bookContent.title }'/></h2>
                                        <h5>저자 : <c:out value="${ bookContent.author }"/></h5>
                                        <h5>출판사 : <c:out value="${ bookContent.publisher }"/></h5>
                                        <h5>출판일 : <c:out value="${ bookContent.publishDate }"/></h5>
                                        <h5>분류 : <c:out value="${ bookContent.classification }"/></h5>
                                        <h5>페이지 : <c:out value="${ bookContent.bookPage }"/></h5>
                                        <div class="space-10"></div>
                                    </div>
                                   	<h4><span><i class="icofont icofont-library"></i></span>&nbsp; 도서 내용 : </h4>
                                   	<p>
                                   	<c:choose>
                                   		<c:when test="${bookContent.content!=null && bookContent.content != '' }">
                                   			<c:out value="${ bookContent.content }" />
                                   		</c:when>
                                   		<c:otherwise>
                                   			내용 없음
                                   		</c:otherwise>
                                   	</c:choose>
                                   	</p>
                                </div>
                            <div class="space-30"></div>
                            <hr>
                         	<table id="bookDetailTable" class="t-style">
	            				<thead>
	                				<tr>
	                					<th>번호</th>
	               						<th>청구기호</th>
	               						<th>상태</th>
	               						<th>반납일</th>
	               						<th>대출</th>
	               						<th>예약</th>
	            	        		</tr>
	               				</thead>
	               				<tbody>
                     				<c:forEach var="bookDetail" items="${ bookDetailContentList }" varStatus="status">
	            		        	<tr>
	    		            			<td>${ status.count }</td>
	    		            			<td>${ bookDetail.callNumber }</td>
	    		            			<td>${ bookDetail.state }</td>
	    		            			<td>
	    		            			<c:if test="${fn:contains(bookDetail.state, '대출중')}" >	
	    		            				${ bookDetail.returnTerm }
	    		            			</c:if>
	    		            			</td>		
	    		            			<td>
										<c:set var="flag" value="false"/> 
	    		            			<c:forEach var="bookDetailRentInfoList" items="${bookDetailRentInfoList}" >
	    		            				<c:if test="${bookDetail.bookDetailId == bookDetailRentInfoList.rentBookDetailId }">
	    		            				<%-- <c:out value="${ bookDetailRentInfoList.rentMemberId}"/> --%>
	    		            					<c:if test="${fn:contains(bookDetail.state, '대출중') && loginVO != null && bookDetailRentInfoList.rentMemberId == loginVO.id}">
	    		            						본인 대출중
	    		            						<c:set var="flag" value="true"/> 
	    		            					</c:if>	    				
	    		            					<c:if test="${fn:contains(bookDetail.state, '대출중') && loginVO != null && bookDetailRentInfoList.rentMemberId != loginVO.id}">
	    		            						회원 대출중<br>
	    		            						(<c:out value="${ bookDetailRentInfoList.reserveBookCnt }" />명 예약중)
	    		            						<c:set var="flag" value="true"/> 
	    		            					</c:if>
	    		            				</c:if>
	    		            			</c:forEach>
	    		            			<c:if test="${not flag}">
	    		            					<c:choose>    		
	    		            					<c:when test="${loginVO != null && bookDetail.state eq '대출가능'}">
	    		            						<a style="cursor:pointer; cursor:hand;" class="text-primary" onclick="javascript:bookFn.rentBook('<c:out value="${ loginVO.id }"/>', '<c:out value="${ bookDetail.bookDetailId }"/>' )">대출하기</a>
	    		            					</c:when>	    		  
	    		            					<c:otherwise>
	    		            						회원 이용 서비스
	    		            					</c:otherwise>
	    		            					</c:choose>
	    		            			</c:if>
	    		            			</td>
	    		            			<td>
										<c:set var="flag" value="false"/> 
	    		            			<c:forEach var="bookDetailReserveInfoList" items="${bookDetailReserveInfoList}" >
	    		            			<c:if test="${bookDetail.bookDetailId == bookDetailReserveInfoList.reserveBookDetailId }">
	    		            					
	    		            					<c:if test="${fn:contains(bookDetail.state, '대출중') && loginVO != null && bookDetailReserveInfoList.reserveMemberId == loginVO.id }">
	    		            						본인 예약 책<br>
	    		            						(<c:out value="${ bookDetailReserveInfoList.rank  }" /> 순번)
	    		            						<c:set var="flag" value="true"/> 
	    		            					</c:if>	
	    		            			</c:if>    
	    		            			</c:forEach>
	    		            		
	    		            			<c:if test="${not flag}">
	    		            				<c:forEach var="bookDetailRentInfoList" items="${bookDetailRentInfoList}" >
	    		            				<c:if test="${bookDetail.bookDetailId == bookDetailRentInfoList.rentBookDetailId }">
	    		            				<c:choose>
	    		            					<c:when test="${fn:contains(bookDetail.state, '대출중') && loginVO != null && bookDetailRentInfoList.rentMemberId == loginVO.id}">
	    		            						본인 대출중
	    		            					</c:when>           				
	    		            					<c:when test="${fn:contains(bookDetail.state, '대출중') && loginVO != null && bookDetailRentInfoList.rentMemberId != loginVO.id}">
	    		            						<a style="cursor:pointer; cursor:hand;" class="text-primary" onclick="javascript:bookFn.reserveBook('<c:out value="${ loginVO.id }"/>', '<c:out value="${ bookDetailRentInfoList.id }"/>' )">예약하기</a>
	    		            					</c:when>
	    		            					<c:when test="${bookDetail.state eq '대출가능' }">
	    		            					</c:when>
	    		            					<c:otherwise>
	    		            						회원 이용 서비스
	    		            					</c:otherwise>
	    		            				</c:choose>
	    		            				</c:if>
	    		            				</c:forEach>
	    		            			</c:if>
	    		            			</td>				
	    		            		</tr>
	    		            		</c:forEach>
	               				</tbody>
	                    	</table>
                            <hr>
                            <div class="space-50"></div>
                            <h1><span><i class="icofont icofont-pencil"></i></span>&nbsp; 150자 서평</h1>
	                    	<div class="review">
							<input id="inputRating" name="inputRating" class="rating-loading" type="hidden" data-size="xs" style="display:inline;">
    						<textarea id="reviewContent" maxlength="150"></textarea>
                            <span id="reviewCounter" >###</span>
    						<a class="btn btn-primary review a" onclick="javascript:reviewFn.saveReviewInfo('I')">등록</a>
                            </div>
                            <div class="space-20"></div>
                            <c:if test="${ !empty bookReviewList }">
                            	<div id="userRatingList">
                            	<c:forEach var="bookReviewList" items="${ bookReviewList }"  varStatus="status">
                            		<div class="userReview${ status.index }">
                            			<input name="userRating" class="rating-loading user-rating${ status.index }" value="<c:out value='${ bookReviewList.score}'/>"
											type="hidden" data-size="xs" style="display:inline;">
                            			<div class="review-content">
                            			<c:out value="${ bookReviewList.content }"/>
                            		</div>
                            		<div class="space-10"></div>
                            		<c:if test="${ loginVO.id == bookReviewList.memberId }">
                            			<div class="review-buttonGroup">
                            				<a class="btn btn-primary" onclick="javascript:reviewFn.changeUpdateMode('<c:out value="${ bookReviewList.id }"/>',${status.index})">수정</a>	
                            				<a class="btn btn-danger " onclick="javascript:reviewFn.updateAndDeleteReviewInfo('<c:out value="${ bookReviewList.id }"/>','D','')">삭제</a>
                            			</div>
                            		</c:if>
                            		<div class="review-member">
                            			<c:out value="${ bookReviewList.name }"/>님이 
                            			<c:out value="${ bookReviewList.createdDate }"/>에 작성
                            		</div>
                            	</div>
                            <div class="space-10"></div>
                            </c:forEach>
                            </div>
                          </c:if>
                          </div>
                        </div>
                    </div>
                    <div class="space-60"></div>
                    <div class="row">
                        <div class="col-xs-12">
                        </div>
                    </div>
               </div>