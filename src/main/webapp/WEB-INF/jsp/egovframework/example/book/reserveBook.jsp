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
		<c:when test="${empty reserveBookList }">
			<h1>예약하신 책이 없습니다.</h1>
			<h1>예약 서비스를 이용해주세요.</h1>
			<div class="space-30"></div>
			<img src="images/NoMyBook.jpg" />
		</c:when>
		<c:otherwise>
			<c:forEach var="reserveBookList" items="${reserveBookList }">
				<div class="col-xs-12 col-md-12">
					<div class="category-item well yellow">
						<div class="space-5"></div>
						<div class="media">
							<div class="media-left">
								<img src="<c:out value='${ reserveBookList.imgDes }'/>"
									width="150px" height="250px" class="media-object" alt=""
									style="margin-right: 50px;">
							</div>
							<div class="media-body">
								<h2>
									<c:out value='${ reserveBookList.title }' />
								</h2>
								<div class="space-30"></div>
								<h5>
									저자 :
									<c:out value='${ reserveBookList.author }' />
								</h5>
								<h5>
									출판사 :
									<c:out value='${ reserveBookList.publisher }' />
								</h5>
								<h5>
									출판일 :
									<c:out value='${ reserveBookList.publishDate }' />
								</h5>
								<h5>
									분류 :
									<c:out value='${ reserveBookList.classification }' />
								</h5>
								<h5>
									페이지 :
									<c:out value='${ reserveBookList.bookPage }' />
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
										<th>예약 순번</th>
										<th>비고</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><c:out value="${ reserveBookList.callNumber }" /></td>
										<td><c:out value="${ reserveBookList.rentDate }" /></td>
										<td><c:out value="${ reserveBookList.returnTerm }" /></td>
										<td><c:out value="${ reserveBookList.rentState }" /></td>
										<td><c:out value="${ reserveBookList.rank }" /></td>
										<td><a style="cursor: pointer; cursor: hand;"
											class="text-primary"
											onclick="javascript:myBook.cancelReserveBook('<c:out value="${ reserveBookList.reserveId }"/>','<c:out value="${ reserveBookList.rentId }"/>')">예약취소</a>
										</td>
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