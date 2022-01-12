package egovframework.example.book.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface BookService {
	
	@SuppressWarnings("rawtypes")
	List<Map> selectBookList() throws Exception;

	EgovMap selectBookContent(String bookId) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectBookDetailContentList(String bookId) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectBookByType(HashMap<String, Object> searchDataMap)  throws Exception;

	void rentBookService(HashMap<String, Object> rentBookMap) throws Exception;

	int selectRentBookCnt(String memberId) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectRentBookList(String memberId) throws Exception;

	void returnBookService(HashMap<String, Object> returnBookMap) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectBookDetailRentInfoList(String bookId) throws Exception;

	void renewBookService(HashMap<String, Object> renewBookMap) throws Exception ;
	
	int selectReserveBookCnt(String rentId) throws Exception;

	void reserveBookService(HashMap<String, Object> rentBookMap)throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectBookDetailReserveInfoList(String bookId) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectReserveBookList(String memberId) throws Exception;

	void cancelReserveService(HashMap<String, Object> reserveBookMap) throws Exception;

	@SuppressWarnings("rawtypes")
	Map selectPriorityReserveInfo(HashMap<String, Object> returnBookMap)throws Exception;

	void returnAndrentBookService(HashMap<String, Object> rentBookMap)throws Exception;
	
	void libroNotificationService(HashMap<String, Object> userInfoMap) throws Exception;

	String selectBookTitle(String bookDetailId) throws Exception;
	
	//스케줄러가 사용하는 것들
	@SuppressWarnings("rawtypes")
	List<Map> selectTodayRentUserList(String todayDate) throws Exception;
	// 페이징 하는데 사용하는 것들
	@SuppressWarnings("rawtypes")
	List<Map> selectBookPagingList(BookPagingVO bookPaginVO) throws Exception;

	EgovMap selectBookPagingListCnt(BookPagingVO bookPaginVO) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectBookSearchPagingList(BookSearchPagingVO bookSearchPagingVO) throws Exception;

	EgovMap selectBookSearchPagingListCnt(BookSearchPagingVO bookSearchPagingVO) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectBookReviewList(String bookId) throws Exception;

	void reviewSaveAndDeleteTx(HashMap<String, Object> bookReviewMap) throws Exception;

}
