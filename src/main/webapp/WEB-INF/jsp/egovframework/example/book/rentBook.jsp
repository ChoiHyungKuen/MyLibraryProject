<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="space-20"></div>
<div class="row">
	<c:choose>
		<c:when test="${empty rentBookList }">
			<h1>대출하신 책이 없습니다.</h1>
			<h1>대출 서비스를 이용해주세요.</h1>
			<div class="space-30"></div>
			<img src="images/NoMyBook.jpg" />
		</c:when>
		<c:otherwise>
			<c:forEach var="rentBookList" items="${rentBookList }">
				<div class="col-xs-12 col-md-12">
					<div class="category-item well yellow">
						<div class="space-5"></div>
						<div class="media">

							<div class="media-left">
								<img src="<c:out value='${ rentBookList.imgDes }'/>"
									width="150px" height="250px" class="media-object" alt=""
									style="margin-right: 50px;">
							</div>
							<div class="media-body">
								<h2>
									<c:out value='${ rentBookList.title }' />
								</h2>
								<div class="space-30"></div>
								<h5>
									저자 :
									<c:out value='${ rentBookList.author }' />
								</h5>
								<h5>
									출판사 :
									<c:out value='${ rentBookList.publisher }' />
								</h5>
								<h5>
									출판일 :
									<c:out value='${ rentBookList.publishDate }' />
								</h5>
								<h5>
									분류 :
									<c:out value='${ rentBookList.classification }' />
								</h5>
								<h5>
									페이지 :
									<c:out value='${ rentBookList.bookPage }' />
								</h5>
								<div class="space-10"></div>
							</div>
						</div>

						<div class="space-10"></div>
						<div>
							<table class="t-style">
								<thead>
									<tr>
										<th>청구기호</th>
										<th>대출일</th>
										<th>반납일</th>
										<th>대출 상태</th>
										<th>연장하기</th>
										<th>반납하기</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><c:out value="${ rentBookList.callNumber }" /></td>
										<td><c:out value="${ rentBookList.rentDate }" /></td>
										<td><c:out value="${ rentBookList.returnTerm }" /></td>
										<td><c:out value="${ rentBookList.rentState }" /></td>
										<td>
										<c:choose>
											<c:when test="${ rentBookList.renewCnt >= 1 }">
											연장횟수 초과, 연장불가
											</c:when>
											<c:otherwise>
												<a style="cursor:pointer; cursor:hand;" class="text-primary" onclick="javascript:myBook.renewBook('<c:out value="${ loginVO.id }"/>', '<c:out value="${ rentBookList.rentBookDetailId }"/>' )">연장</a>
											</c:otherwise>
										</c:choose>
										</td>
										<td><a style="cursor: pointer; cursor: hand;" class="text-primary"
											onclick="javascript:myBook.returnBook('<c:out value="${ rentBookList.id }"/>', '<c:out value="${ rentBookList.rentBookDetailId }"/>' )">반납</a></td>
										<%-- 
	    		            			<td>
	    		            			<c:choose>
	    		            				
	    		            				<c:when test="${loginVO != null && bookDetail.state eq '대출가능'}">
	    		            					<a style="cursor:pointer; cursor:hand;" class="text-primary" onclick="javascript:bookFn.rentBook('<c:out value="${ loginVO.id }"/>', '<c:out value="${ bookDetail.bookDetailId }"/>' )">대출하기</a>
	    		            				</c:when>	    		            				
	    		            				<c:when test="${loginVO != null && bookDetail.state eq '대출중'}">
	    		            					회원 대출중
	    		            				</c:when>
	    		            				<c:otherwise>
	    		            					회원 이용 서비스
	    		            				</c:otherwise>
	    		            			</c:choose>
	    		            			</td>		 --%>
									</tr>
								</tbody>
							</table>

							<div class="space-10"></div>
						</div>
					</div>
				</div>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</div>