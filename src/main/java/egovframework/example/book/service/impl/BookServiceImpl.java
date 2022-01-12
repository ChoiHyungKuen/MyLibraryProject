package egovframework.example.book.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONObject;
import org.springframework.stereotype.Service;

import egovframework.example.book.service.BookPagingVO;
import egovframework.example.book.service.BookSearchPagingVO;
import egovframework.example.book.service.BookService;
import egovframework.example.cmmn.JsonUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("bookService")
public class BookServiceImpl implements BookService {
	
	@Resource(name="bookMapper")
	private BookMapper bookMapper;
	

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectBookList() throws Exception {
	
		return bookMapper.selectBookList();
	}

	@Override
	public EgovMap selectBookContent(String bookId) throws Exception {
		
		return bookMapper.selectBookContent(bookId);
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectBookDetailContentList(String bookId) throws Exception {
		
		return bookMapper.selectBookDetailContentList(bookId);
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectBookByType(HashMap<String, Object> searchDataMap) throws Exception {
		
		return bookMapper.selectBookByType(searchDataMap);
	}

	@Override
	public void rentBookService(HashMap<String, Object> rentBookMap) throws Exception{
		// 책의 대여횟수 증가시킴
		bookMapper.updateBookState(rentBookMap);
  	  	// 책 대여일 수정 및 상태 변경
  	  	bookMapper.updateBookDetailState(rentBookMap);
		// 대여 추가
  	  	bookMapper.insertRentBook(rentBookMap);
		
	}

	@Override
	public int selectRentBookCnt(String memberId) throws Exception {
		
		return bookMapper.selectRentBookCnt(memberId);
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectRentBookList(String memberId) throws Exception {
		
		return bookMapper.selectRentBookList(memberId);
	}

	@Override
	public void returnBookService(HashMap<String, Object> returnBookMap) throws Exception {
		
  	  	// 책 대여일 수정 및 상태 변경
  	  	bookMapper.updateBookDetailState(returnBookMap);
  	  	// 대여테이블에서 현재 반납누른것 삭제
  	  	bookMapper.deleteRentBook(returnBookMap);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectBookDetailRentInfoList(String bookId) throws Exception {
		
		return bookMapper.selectBookDetailRentInfoList(bookId);
	}

	@Override
	public void renewBookService(HashMap<String, Object> renewBookMap) throws Exception {
		
  	  	// 책 대여일 수정 및 상태 변경
  	  	bookMapper.updateBookDetailState(renewBookMap);
  	  	// 대여 정보 변경(연장했다는 것을 표시하기 위해서 변경)
		bookMapper.updateRenewState(renewBookMap);
	}

	@Override
	public int selectReserveBookCnt(String rentId) throws Exception {
		
		return bookMapper.selectReserveBookCnt(rentId);
	}

	@Override
	public void reserveBookService(HashMap<String, Object> reserveBookMap) throws Exception {
		
		bookMapper.insertReserveBook(reserveBookMap);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectBookDetailReserveInfoList(String bookId) throws Exception {
		
		return bookMapper.selectBookDetailReserveInfoList(bookId);
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectReserveBookList(String memberId) throws Exception {
		
		return bookMapper.selectReserveBookList(memberId);
	}

	@Override
	public void cancelReserveService(HashMap<String, Object> reserveBookMap) throws Exception {
		// 예약한 것을 지우고
		bookMapper.deleteReserveBook(reserveBookMap);
		// 이후 사람들을 찾아서 예약순위를 1 낮춘다.
		bookMapper.updateReserveBook(reserveBookMap);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public Map selectPriorityReserveInfo(HashMap<String, Object> returnBookMap) throws Exception {
		
		return bookMapper.selectPriorityReserveInfo(returnBookMap);
	}

	@Override
	public void returnAndrentBookService(HashMap<String, Object> rentBookMap) throws Exception {

		// 책의 대여횟수 증가시킴
		bookMapper.updateBookState(rentBookMap);
	  	// 책 대여일 수정 및 상태 변경
	  	bookMapper.updateBookDetailState(rentBookMap);
	  	// 대여테이블에서 현재 반납누른것 삭제
	  	bookMapper.updateRentBook(rentBookMap);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectTodayRentUserList(String todayDate) throws Exception {
		
		return bookMapper.selectTodayRentUserList(todayDate);
	}

	@Override
	public void libroNotificationService(HashMap<String, Object> userInfoMap) throws Exception {
		
		bookMapper.insertNotification(userInfoMap);
	}

	@Override
	public String selectBookTitle(String bookDetailId) throws Exception {
		
		return bookMapper.selectBookTitle(bookDetailId);
	}
	// 페이징에서 사용하는 것들
	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectBookPagingList(BookPagingVO bookPaginVO) throws Exception {
		
		return bookMapper.selectBookPagingList(bookPaginVO);
	}

	@Override
	public EgovMap selectBookPagingListCnt(BookPagingVO bookPaginVO) throws Exception {
		
		return bookMapper.selectBookPagingListCnt(bookPaginVO);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectBookSearchPagingList(BookSearchPagingVO bookSearchPagingVO) throws Exception {
		
		return bookMapper.selectBookSearchPagingList(bookSearchPagingVO);
	}

	@Override
	public EgovMap selectBookSearchPagingListCnt(BookSearchPagingVO bookSearchPagingVO) throws Exception {
		
		return bookMapper.selectBookSearchPagingListCnt(bookSearchPagingVO);
	}
	
	/*
		여기는 책의 리뷰관련된 것들
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectBookReviewList(String bookId) throws Exception {
		
		return bookMapper.selectBookReviewList(bookId);
	}

	@Override
	public void reviewSaveAndDeleteTx(HashMap<String, Object> bookReviewMap) throws Exception {

		try {

			if ("I".equals(bookReviewMap.get("editType"))) {
				
				bookMapper.insertReviewInfo(bookReviewMap);
			} else if ("U".equals(bookReviewMap.get("editType"))) {

				bookMapper.updateReviewInfo(bookReviewMap);
			} else if ("D".equals(bookReviewMap.get("editType"))) {

				bookMapper.deleteReviewInfo(bookReviewMap);
			}
		
		} catch (Exception e) {

			throw e;
		}
	}

}
