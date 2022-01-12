package egovframework.example.book.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.example.book.service.BookPagingVO;
import egovframework.example.book.service.BookSearchPagingVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("bookMapper")
public interface BookMapper {
	
	@SuppressWarnings("rawtypes")
	List<Map> selectBookList() throws Exception;

	EgovMap selectBookContent(String bookId) throws Exception;
	
	@SuppressWarnings("rawtypes")
	List<Map> selectBookDetailContentList(String bookId) throws Exception;
	
	@SuppressWarnings("rawtypes")
	List<Map> selectBookByType(HashMap<String, Object> searchDataMap) throws Exception;

	void updateBookState(HashMap<String, Object> rentBookMap)throws Exception;
	
	void updateBookDetailState(HashMap<String, Object> rentBookMap) throws Exception;

	void insertRentBook(HashMap<String, Object> rentBookMap) throws Exception;
	
	int selectRentBookCnt(String memberId) throws Exception;
	
	// 회원의 이름으로 대여 정보를 가져온다
	@SuppressWarnings("rawtypes")
	List<Map> selectRentBookList(String memberId) throws Exception;

	void deleteRentBook(HashMap<String, Object> returnBookMap) throws Exception;
	
	// 책 정보보기할 때 이 책을 빌린 사람을 가져온다.
	@SuppressWarnings("rawtypes")
	List<Map> selectBookDetailRentInfoList(String bookId) throws Exception;

	void updateRenewState(HashMap<String, Object> renewBookMap) throws Exception;

	int selectReserveBookCnt(String rentId) throws Exception;

	void insertReserveBook(HashMap<String, Object> reserveBookMap) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectBookDetailReserveInfoList(String bookId) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectReserveBookList(String memberId) throws Exception;

	void deleteReserveBook(HashMap<String, Object> reserveBookMap) throws Exception;

	void updateReserveBook(HashMap<String, Object> reserveBookMap) throws Exception;

	@SuppressWarnings("rawtypes")
	Map selectPriorityReserveInfo(HashMap<String, Object> returnBookMap)  throws Exception;

	void updateRentBook(HashMap<String, Object> returnBookMap) throws Exception;

	void insertNotification(HashMap<String, Object> userInfoMap)throws Exception;
	// 스케줄러에서 사용하는 것들..
	@SuppressWarnings("rawtypes")
	List<Map> selectTodayRentUserList(String todayDate) throws Exception;

	// 페이징에서 사용하는 것들..
	@SuppressWarnings("rawtypes")
	List<Map> selectBookPagingList(BookPagingVO bookPaginVO) throws Exception;

	EgovMap selectBookPagingListCnt(BookPagingVO bookPaginVO) throws Exception;

	String selectBookTitle(String bookDetailId) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectBookSearchPagingList(BookSearchPagingVO bookSearchPagingVO) throws Exception;

	EgovMap selectBookSearchPagingListCnt(BookSearchPagingVO bookSearchPagingVO) throws Exception;

	/*
		여기는 책의 리뷰관련된 것들
	 */
	@SuppressWarnings("rawtypes")
	List<Map> selectBookReviewList(String bookId) throws Exception;

	void insertReviewInfo(HashMap<String, Object> bookReviewMap) throws Exception;

	void updateReviewInfo(HashMap<String, Object> bookReviewMap) throws Exception;

	void deleteReviewInfo(HashMap<String, Object> bookReviewMap) throws Exception;
}
