<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<script type="text/javascript">
function checkSearchBooks() {
	var $searchInput = $("#searchBarInput");
	
	if($searchInput.val() == '') {
		
		alert("검색어 1글자이상은 입력하셔야 합니다.");
		
		return false;
	} else {
		var searchType = $("#searchTypeSelect").val();
		
		if(searchType == '제목') {
			
			$searchInput.attr("name","title");
		} else if(searchType =='저자') {
			
			$searchInput.attr("name","author");			
		} else {
			
			$searchInput.attr("name","publisher");
		}
		
		return true;
	}
}

function pageGoFn(page) {
	/*
	 	서치하는 url도 이 jsp를 공용 하는데 url이 달라 에러가 났음
	 	그래서 page부분만 추출해서 그 앞부분을 잘라서 이동하기 위한 페이지를 다시 붙여준다.
	 	page를 마지막으로 들어가게 하기위해 nav의 form에 끝에 input page를 넣었음.
	*/
   	var url = location.href;
   	var idx = url.indexOf("page=");   
 	var frontUrl = url.substring(0, idx);
 	location.href = frontUrl+"page="+page
/*    location.href = "http://localhost:8080/sample/books.do?page="+page
 */}
/* //이 jsp 페이지에서 사용하는 함수들을 모아놓는 객체
var bookFn = {
	
	// 페이지를 이동시키는 메소드
	pageSubmitFn : function(param, pageName) {
		
		if(pageName == 'libroBookContent') {
			
			$("#bookId").val(param);
		} else if(pageName == 'searchBook') {
			

			$("#classification").val(param);
		}

		$("#bookFrm").attr("action", pageName+".do");	
		
		$("#bookFrm").submit();

	}
}
 */

$(document).ready(function(){	

	var state = "<c:out value='${state}'/>";
	
	if(state == 'SUCCESS' || state == 'FAIL') {
		
		alert("<c:out value='${message}'/>");
	}
		
	
	$("body").attr("data-spy", "spyscroll");
	$("body").attr("data-target", ".navbar-default");
	$("#mainmenu ul li.active").removeClass("active");
	$("#mainmenu ul li[name=자료검색]").addClass("active");
		
	
});
</script>
<%-- 
<form id="bookFrm" name="bookFrm">
	<input type="hidden" id="bookId"  name="bookId" />
	<input type="hidden" id="classification"  name="classification" />
</form> --%>
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
            <div class="row" >
                <div class="col-xs-12 col-md-10 pull-right">
                    <h4>Search Box</h4>
                    <div class="space-5"></div>
                    <form action="searchBook.do" onsubmit="return checkSearchBooks()">
                        	<div class="col-md-2 ">
                        		<div class="form-group">
                    			<select class="form-control" id="searchTypeSelect" name="searchTypeSelect">
                    				<option>제목</option>
                    				<option>저자</option>
                    				<option>출판사</option>
                    			</select>
                    			</div>
                            </div>
                        <div class="input-group">
                        	<div class="col-md-14">
                            <input type="text" class="form-control" placeholder="키워드를 입력해주세요." id="searchBarInput">
                            </div>
                            <div class="input-group-btn">
                                <button type="submit" class="btn btn-primary"><i class="icofont icofont-search-alt-2"></i></button>
                            </div>
                        </div>
                    </form>
                    <div class="space-30"></div>
                    <c:if test="${ state eq 'search' }">
                    	<div class="row">
                        	<div class="pull-left col-xs-12 col-sm-5 col-md-6">
                            	<p><c:out value="${type}" /> 검색으로 <strong>키워드 '<c:out value="${keyword}" />' </strong>로 찾은 결과 </p>
                        	    <p><strong><c:out value="${findBookCnt}" /> 건</strong> 의 결과를 찾았습니다.</p>
                        	</div>
                    	</div>
                    </c:if>
                    <hr>
                    <div class="row">
                     	<c:forEach var="pagingList" items="${ pagingList }">
                        <div class="col-xs-12 col-md-6">
                            <div class="category-item well yellow">
                     			<div class="space-5"></div>
                                <div class="media">
                                    <div class="media-left">    	
                                	<c:choose>
                                		<c:when test="${ pagingList.imgDes !=null }">
                                    		<img src="<c:out value='${ pagingList.imgDes }'/>"  width ="150px" style="height:200px;" class="media-object" alt="">
                                    	</c:when>
                                    	<c:otherwise>
                                    	     <img src="images/book/book_no_image.png"  width ="150px" style="height:200px;" class="media-object" alt="">
                                    	</c:otherwise>
                                	</c:choose>
                                    </div>
                                    <div class="media-body">
                                        <h5 class="text-overflow" title="<c:out value='${ pagingList.title }'/>"><strong ><c:out value='${ pagingList.title }'/></strong></h5>
                                        <h6 class="text-overflow" title="<c:out value='${ pagingList.author }'/>">저자 : <c:out value='${ pagingList.author }'/></h6>
                                        <h6>출판사 : <c:out value='${ pagingList.publisher }'/></h6>
                                        <h6>출판일 : <c:out value='${ pagingList.publishDate }'/></h6>
                                        <h6>분류 : <c:out value='${ pagingList.classification }'/></h6>
                                        <h6>페이지 : <c:out value='${ pagingList.bookPage }'/></h6>
                                        <a href="#" class="text-primary" onclick="javascript:nav.pageSubmitFn('<c:out value="${ pagingList.id }" />', 'libroBookContent', '<c:out value="${ currentPage }" />')">자세히 보기</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </c:forEach>
                    </div>
                    <div class="space-60"></div>
                    <div class="row">
                        <div class="col-xs-12">
							<ul id="pagination" class="pagination-sm pagination">
								<c:if test="${resMap.pageGroup > 1}">
									<li class="page-item first"><a href="javascript:pageGoFn('1')">처음</a></li>
									<li class="page-item prev"><a href="javascript:pageGoFn(<c:out value='${resMap.prePage}'/>)">«</a></li>
								</c:if>
								<c:forEach var="i" begin="${resMap.startPage}" end="${resMap.endPage > resMap.total ? resMap.total : resMap.endPage}"
									varStatus="status">
									<c:choose>
										<c:when test="${resMap.page eq i}">
											<li class="page-item active"><a href="javascript:pageGoFn(${i});">${i}</a></li>
										</c:when>
										<c:otherwise>
											<li class="page-item"><a href="javascript:pageGoFn(${i});">${i}</a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:if test="${resMap.nextPage <= resMap.total}">
									<li class="next"><a href="javascript:pageGoFn(<c:out value='${resMap.nextPage}'/>)">»</a></li>
									<li class="last"><a href="javascript:pageGoFn(<c:out value='${resMap.total}'/>)">끝</a></li>
								</c:if>
							</ul>
					</div>
                </div>
          </div>