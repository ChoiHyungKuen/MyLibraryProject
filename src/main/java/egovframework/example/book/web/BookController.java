package egovframework.example.book.web;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.example.book.service.BookPagingVO;
import egovframework.example.book.service.BookSearchPagingVO;
import egovframework.example.book.service.BookService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class BookController {
	
	@Resource(name = "bookService")
	private BookService bookService;
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "books.do")
	public String initBooks(ModelMap model,HttpServletRequest request, BookPagingVO bookPagingVO,
			RedirectAttributes redirectAttributes) throws Exception {
		/*
		List<Map> bookList = bookService.selectBookList();
		
		model.addAttribute("libroBookList", bookList);*/
		request.setCharacterEncoding("UTF-8");

		if(request.getParameter("order")!=null) {
			
			bookPagingVO.setOrder(request.getParameter("order"));
		}
		
		List<Map> pagingList = bookService.selectBookPagingList(bookPagingVO);

		model.addAttribute("pagingList", pagingList);

		EgovMap pagingListCnt = bookService.selectBookPagingListCnt(bookPagingVO);
		
		System.out.println("pagingListCnt" + pagingListCnt);
		
		HashMap<String, Object> resMap = new HashMap<String, Object>();

		System.out.println("page : " + bookPagingVO.getPage());
		System.out.println("totalPage : " + pagingListCnt.get("totalPage"));
		System.out.println("pageScale : " + bookPagingVO.getPageScale());

		resMap.put("page", bookPagingVO.getPage()); // 현재보여질 page번호
		resMap.put("total", pagingListCnt.get("totalPage")); // 총보여질 page수
		resMap.put("pageScale", bookPagingVO.getPageScale()); // 한화면당 보여질 페이지 사이즈
		
		// 현재페이지를 따로 담는다. 이 변수는 나중에 예약, 대출 등의 작업하고 이 페이지로 돌아오기 위해서 사용한다.
		model.addAttribute("currentPage", bookPagingVO.getPage());
		
		/* 페이지그룹 = (올림) 현재페이지/한화면당보여질 페이지 사이즈 
		  페이지 스케일이 3이면 (1,2,3) 1그룹 (4,5,6)2그룹
		*/
		int pageGroup = (int) Math.ceil((double) bookPagingVO.getPage()
				/ bookPagingVO.getPageScale());

		// 한 페이지의 시작 rowNum
		long startPage = (pageGroup - 1) * bookPagingVO.getPageScale() + 1;

		bookPagingVO.setStartPage(startPage);

		System.out.println("startPage : " + bookPagingVO.getStartPage());

		resMap.put("startPage", bookPagingVO.getStartPage());

		// 한 페이지의 마지막 rowNum
		long endPage = startPage + bookPagingVO.getPageScale() - 1;

		bookPagingVO.setEndPage(endPage);

		System.out.println("endPage : " + bookPagingVO.getEndPage());

		resMap.put("endPage", bookPagingVO.getEndPage());

		// 이전페이지
		long prePage = (pageGroup - 2) * bookPagingVO.getPageScale() + 1;

		// 다음페이지
		long nextPage = pageGroup * bookPagingVO.getPageScale() + 1;

		System.out.println("pageGroup : " + pageGroup);
		System.out.println("prePage : " + prePage);
		System.out.println("nextPage : " + nextPage);

		resMap.put("pageGroup", pageGroup);
		resMap.put("prePage", prePage);
		resMap.put("nextPage", nextPage);

		model.addAttribute("resMap", resMap);

		return "book/books.tiles";
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "searchBook.do")
	public String searchBook(HttpServletRequest request, ModelMap model,BookSearchPagingVO bookSearchPagingVO) throws Exception{
		System.out.println("컨트롤러 탐");
		request.setCharacterEncoding("UTF-8");
		//HashMap<String, Object> searchDataMap = new HashMap<String,Object>();
		//List<Map> searchBookList;
		
		if(request.getParameter("title") !=null) {
			
			bookSearchPagingVO.setType("제목");
			bookSearchPagingVO.setKeyword(request.getParameter("title"));
		} else if(request.getParameter("author") !=null) {
			
			bookSearchPagingVO.setType("저자");
			bookSearchPagingVO.setKeyword(request.getParameter("author"));
		} else if(request.getParameter("publisher") !=null) {

			bookSearchPagingVO.setType("출판사");
			bookSearchPagingVO.setKeyword(request.getParameter("publisher"));
		} else {
			
			bookSearchPagingVO.setType("분야");
			bookSearchPagingVO.setKeyword(request.getParameter("classification"));	
		}

		List<Map> pagingList = bookService.selectBookSearchPagingList(bookSearchPagingVO);

		model.addAttribute("pagingList", pagingList);

		EgovMap pagingListCnt = bookService.selectBookSearchPagingListCnt(bookSearchPagingVO);
		
		System.out.println("pagingListCnt" + pagingListCnt);
		
		HashMap<String, Object> resMap = new HashMap<String, Object>();

		System.out.println("page : " + bookSearchPagingVO.getPage());
		System.out.println("totalPage : " + pagingListCnt.get("totalPage"));
		System.out.println("pageScale : " + bookSearchPagingVO.getPageScale());

		resMap.put("page", bookSearchPagingVO.getPage()); // 현재보여질 page번호
		resMap.put("total", pagingListCnt.get("totalPage")); // 총보여질 page수
		resMap.put("pageScale", bookSearchPagingVO.getPageScale()); // 한화면당 보여질 페이지 사이즈
		
		// 현재페이지를 따로 담는다. 이 변수는 나중에 예약, 대출 등의 작업하고 이 페이지로 돌아오기 위해서 사용한다.
		model.addAttribute("currentPage", bookSearchPagingVO.getPage());
		
		/* 페이지그룹 = (올림) 현재페이지/한화면당보여질 페이지 사이즈 
		  페이지 스케일이 3이면 (1,2,3) 1그룹 (4,5,6)2그룹
		*/
		int pageGroup = (int) Math.ceil((double) bookSearchPagingVO.getPage()
				/ bookSearchPagingVO.getPageScale());

		// 한 페이지의 시작 rowNum
		long startPage = (pageGroup - 1) * bookSearchPagingVO.getPageScale() + 1;

		bookSearchPagingVO.setStartPage(startPage);

		System.out.println("startPage : " + bookSearchPagingVO.getStartPage());

		resMap.put("startPage", bookSearchPagingVO.getStartPage());

		// 한 페이지의 마지막 rowNum
		long endPage = startPage + bookSearchPagingVO.getPageScale() - 1;

		bookSearchPagingVO.setEndPage(endPage);

		System.out.println("endPage : " + bookSearchPagingVO.getEndPage());

		resMap.put("endPage", bookSearchPagingVO.getEndPage());

		// 이전페이지
		long prePage = (pageGroup - 2) * bookSearchPagingVO.getPageScale() + 1;

		// 다음페이지
		long nextPage = pageGroup * bookSearchPagingVO.getPageScale() + 1;

		System.out.println("pageGroup : " + pageGroup);
		System.out.println("prePage : " + prePage);
		System.out.println("nextPage : " + nextPage);

		resMap.put("pageGroup", pageGroup);
		resMap.put("prePage", prePage);
		resMap.put("nextPage", nextPage);

		model.addAttribute("resMap", resMap);
		model.addAttribute("type", bookSearchPagingVO.getType());
		model.addAttribute("keyword", bookSearchPagingVO.getKeyword());
		/*
		searchBookList = bookService.selectBookByType(searchDataMap);
		*//*
		model.addAttribute("searchDataMap", searchDataMap);
		model.addAttribute("libroBookList", searchBookList);*/
		model.addAttribute("findBookCnt", pagingList.size());
		model.addAttribute("state", "search");
		
		return "book/books.tiles";
	}	
	/*
	@RequestMapping(value = "libroBookList.do")
	public void libroBookList(HttpServletResponse response) throws Exception{
		
		PrintWriter out = null;
		response.setCharacterEncoding("UTF-8");
		List<?> bookList = bookService.selectBookList();
		out = response.getWriter();
		out.write(JsonUtil.ListToJson(bookList));
	}	*/

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "libroBookContent.do")
	public String libroBookContent(HttpServletRequest request, @RequestParam String bookId, ModelMap model) throws Exception{
		
		EgovMap bookContent = bookService.selectBookContent(bookId);

		List<Map> bookDetailContentList = bookService.selectBookDetailContentList(bookId);
		
		List<Map> bookDetailRentInfoList = bookService.selectBookDetailRentInfoList(bookId);
		System.out.println(bookDetailRentInfoList.size()+"개의 대여");
		for(int i=0; i<bookDetailRentInfoList.size(); i++) {
			// id는 bigdecimal로 가져옴 그렇기때문에 String으로 변경해서 넘긴다.
			int reserveBookCnt = bookService.selectReserveBookCnt(bookDetailRentInfoList.get(i).get("id")+"");
			System.out.println(reserveBookCnt);
			bookDetailRentInfoList.get(i).put("reserveBookCnt", reserveBookCnt);
			System.out.println(bookDetailRentInfoList.get(i).get("memberId"));
		}
		List<Map> bookDetailReserveInfoList = bookService.selectBookDetailReserveInfoList(bookId);
		
		List<Map> bookReviewList = bookService.selectBookReviewList(bookId);
		
		model.addAttribute("bookContent", bookContent);
		
		model.addAttribute("bookDetailContentList", bookDetailContentList);
		
		model.addAttribute("bookDetailRentInfoList", bookDetailRentInfoList);
		
		model.addAttribute("bookDetailReserveInfoList", bookDetailReserveInfoList);
		
		model.addAttribute("bookReviewList", bookReviewList);
		
		System.out.println("컨텐트 페이지="+request.getParameter("page"));
		model.addAttribute("page", request.getParameter("page"));
		
		return "book/bookItem.tiles";
	}	
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "cancelReserveBook.do")
	public String cancelReserveBookMain(HttpServletRequest request, @RequestParam HashMap<String, Object> reserveBookMap, 
			RedirectAttributes redirectAttributes, SessionStatus status, ModelMap model) throws Exception{
		
		bookService.cancelReserveService(reserveBookMap);
		
		if(request.getParameter("bookDetailId")!=null && request.getParameter("bookDetailId").equals("")) {
			System.out.println("예약 취소");
			model.addAttribute("state", "SUCCESS");
			model.addAttribute("message", "예약이 취소되었습니다.");
			
		} else {
			System.out.println("예약한 사람이 책이 많음");
			// 반납하고 예약자 있는 경우 그사람으로 대여한 걸로 수정해서 예약취소 된 경우에 여기를 탄다.
			// 그래서 이 메시지는 반납한 사람한테 최종적으로 보여주는 메시지이다.
			// hasOverBook에 값이 있다는 것은 예약자인데 가진책이 보유 권수를 넘어서 그 다음사람에게 예약 권수를 넘기는 상황이다.
			if(request.getParameter("hasOverBook") != null &&  !request.getParameter("hasOverBook").equals("")) {
				System.out.println("책이 많아서 ㅎㅎ..");
				status.setComplete();
				// 우선순위인 사람을 찾고
				Map priorityReserveInfo = bookService.selectPriorityReserveInfo(reserveBookMap);
				
				if(priorityReserveInfo != null && !priorityReserveInfo.isEmpty()) {
					System.out.println("그다음사람"+(String)priorityReserveInfo.get("reserveMemberId"));
					// 그사람것으로 다시 시도
					return "redirect:/rentBook.do?userId="+priorityReserveInfo.get("reserveMemberId")
							+"&bookDetailId="+priorityReserveInfo.get("bookDetailId")
							+"&rentId="+priorityReserveInfo.get("rentId")+"&reserveId="+priorityReserveInfo.get("reserveId");
				} else {	// 우선 순위인 사람이 없다는 것은 예약리스트가 빈것.. 즉
					System.out.println("???");
					return "redirect:/returnBook.do?bookDetailId="+reserveBookMap.get("bookDetailId")
							+"&rentId="+reserveBookMap.get("rentId");
				}
			}
			
			model.addAttribute("state", "SUCCESS");
			model.addAttribute("message", "반납되었습니다.");
		}
		
		status.setComplete();
		return "book/myBook.tiles";
	}
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "myBook.do")
	public String myBookMain(HttpServletRequest request, @RequestParam String memberId, 
			 RedirectAttributes redirectAttributes,ModelMap model) throws Exception{
		
		List<Map> rentBookList = bookService.selectRentBookList(memberId);
		
		List<Map> reserveBookList = bookService.selectReserveBookList(memberId);
		
		model.addAttribute("rentBookList", rentBookList);
		
		model.addAttribute("reserveBookList", reserveBookList);
		
		return "book/myBook.tiles";
	}	

	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value = "returnBook.do")
	public String returnBookMain(HttpServletRequest request,
			@RequestParam HashMap<String, Object> returnBookMap, ModelMap model, SessionStatus status) throws Exception{
		
		returnBookMap.put("state", "대출가능");
		
		Map priorityReserveInfo = bookService.selectPriorityReserveInfo(returnBookMap);
		
		if(priorityReserveInfo == null || priorityReserveInfo.isEmpty()) {

			model.addAttribute("state", "SUCCESS");
			model.addAttribute("message", "반납되었습니다.");
			System.out.println("반납");
			
			bookService.returnBookService(returnBookMap);

			status.setComplete();
			
			return "book/myBook.tiles";
		} else {
/*
			model.addAttribute("returnState", "dd");
			model.addAttribute("isReserve", "Y");
			System.out.println("예약자 있음1"+priorityReserveInfo.get("reserveMemberId"));
			request.setAttribute("userId", (String)priorityReserveInfo.get("reserveMemberId"));
			System.out.println("예약자 있음2"+priorityReserveInfo.get("bookDetailId"));
			request.setAttribute("bookDetailId", priorityReserveInfo.get("bookDetailId")+"");
			System.out.println("예약자 있음3");
			request.setAttribute("rentId", priorityReserveInfo.get("rentId")+"");*/

			return "forward:/rentBook.do?userId="+ priorityReserveInfo.get("reserveMemberId")
						+"&rentId="+priorityReserveInfo.get("rentId")+"&reserveId="+priorityReserveInfo.get("reserveId")
						+"&title="+priorityReserveInfo.get("title");
		}
	}
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "renewBook.do")
	public String renewBookMain(@RequestParam String memberId, @RequestParam String bookDetailId, HttpServletRequest request,
			ModelMap model, SessionStatus status) throws Exception {

		System.out.println("연장하는 사람 :" + bookDetailId +","+memberId);

		List<Map> rentBookList = bookService.selectRentBookList(memberId);
		
		for(int i=0; i<rentBookList.size(); i++) {
			
			Map rentBookInfoMap = rentBookList.get(i);
			
			System.out.println(rentBookInfoMap.get("memberId").getClass());
			
			if(memberId.equals(rentBookInfoMap.get("memberId"))
					&& bookDetailId.equals(rentBookInfoMap.get("rentBookDetailId")+"")) {
				
				System.out.println("여기가 안되나;;");
				if(((BigDecimal)rentBookInfoMap.get("renewCnt")).intValue() >= 1 ) {

					model.addAttribute("state", "FAIL");
					model.addAttribute("message", "연장 가능 횟수를 초과하셨습니다. 반납하시고 이용해주세요.");
					
					status.setComplete();

					return "book/myBook.tiles";
				}
				
				int renewCnt = ((BigDecimal)rentBookInfoMap.get("renewCnt")).intValue();
				HashMap<String, Object> rentBookMap = new HashMap<String, Object>();
				System.out.println("머지"+rentBookInfoMap.get("otherTypeReturnTerm").getClass()+"?");
				
				// 대여일을 가져온다.
		  	  	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		  	  	Date rentDate = dateFormat.parse((String) rentBookInfoMap.get("otherTypeReturnTerm"));
		  	  	System.out.println("대여"+rentDate);
		  	  	Calendar cal = Calendar.getInstance();
		  	  	cal.setTime(rentDate);
				cal.add(Calendar.DATE, 14);	// 연장은 14일로
		  	  	String returnTerm = dateFormat.format(cal.getTime());
		  	  	System.out.println("최종"+returnTerm);
		  	  	rentBookMap.put("returnTerm", returnTerm);
				rentBookMap.put("memberId", memberId);
				rentBookMap.put("bookDetailId", bookDetailId);
				rentBookMap.put("state", (renewCnt+1)+"회 연장 대출중");
				System.out.println(((BigDecimal)rentBookInfoMap.get("renewCnt")).intValue()+"회 연장 대출중");
				rentBookMap.put("rentState", "대출 "+ (renewCnt+1) + "회 연장, 1회까지 가능");
					
				bookService.renewBookService(rentBookMap);
				
				model.addAttribute("state", "SUCCESS");
				model.addAttribute("message", "대출일이 연장되었습니다. 반납일은 " + returnTerm +" 입니다.");
				
				break;
			}
		}
		status.setComplete();
		return "book/myBook.tiles";
	}	
	
	@RequestMapping(value = "rentBook.do")
	public String rentBookMain(@RequestParam String userId, @RequestParam String bookDetailId,
			HttpServletRequest request, ModelMap model, RedirectAttributes redirectAttributes, SessionStatus status) throws Exception{
		
		System.out.println("빌리는 사람 :" + bookDetailId +","+userId);
		
		
		int rentBookCnt = bookService.selectRentBookCnt(userId);
		System.out.println(request.getParameter("rentId"));
		System.out.println(rentBookCnt);
		if(rentBookCnt >= 2) {
			/*
			 * 	request.getParameter("rentId") != null로 안 한 이유는
			 * 	이걸 사용하는 폼에 기본적으로 rentId라는 이름으로 된 input hidden으로 보낸다.
			 	rentBook.do를 타게 하는 것은 bookItem의 폼으로 이동하거나 
			 	returnBook.do에서 forward로 ?변수 = 값 으로 추가해서 넘어오는 경우밖에 없다. 
			 */
			if(request.getParameter("rentId").equals("") ) {
				
				redirectAttributes.addFlashAttribute("state", "FAIL");
				redirectAttributes.addFlashAttribute("message", "대출 가능 권수를 초과하셨습니다. 반납하시고 이용해주세요.");
				
				status.setComplete();
				
				return "redirect:/books.do?page="+request.getParameter("page");
			} else {
				// 여기는 예약대상자인데 가진 책을 초과했기 때문에 예약취소 되고 다음사람한테 넘긴다.
				System.out.println("책이 많아서 다른사람한테 넘김"+userId);
				HashMap<String, Object> notificationMap = new HashMap<String, Object>();
				
				notificationMap.put("userId", userId);
				notificationMap.put("content", "현재 예약 우선순위 대상자 분이지만 대여하신 『"+ request.getParameter("title") +"』책이 보유권수를 넘었습니다. "
						+ "그래서 현재 예약자에게 대여기회를 넘겼습니다. 다른 책 반납하고 다음에 이용해주세요. 죄송합니다 ㅠㅠ");

				bookService.libroNotificationService(notificationMap);
				return "forward:/cancelReserveBook.do?hasOverBook=ok&bookDetailId="+bookDetailId
						+"&rentId="+request.getParameter("rentId");
			}
		} else {
			
			HashMap<String, Object> rentBookMap = new HashMap<String, Object>();
			
			rentBookMap.put("memberId", userId);
			rentBookMap.put("bookDetailId", bookDetailId);
			// 책의 대출횟수를 위해 책 id로 제목검색
			String title = bookService.selectBookTitle(bookDetailId);
			rentBookMap.put("title", title);
			
			// 오늘 날짜를 가져온다.
			Date date = new Date();
			// 포맷변경 (저장하기 쉽게 변경)
	  	  	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd"); 
	  	  	// 가져온 날짜를 Calendar객체에 넣는다.(계산하기 쉽게하기 위해)
	  	  	Calendar cal = Calendar.getInstance();
	  	  	cal.setTime(date);
			// 대여한 날짜 - 오늘날짜를 포맷으로 지정해서 저장
	  	  	String rentDate = dateFormat.format(cal.getTime()); 
	  	  	// 대여기간은 14일
			cal.add(Calendar.DATE, 14);
	  	  	String returnTerm = dateFormat.format(cal.getTime()); 

	  	  	rentBookMap.put("state", "대출중");
	  	  	rentBookMap.put("returnTerm", returnTerm);
	  	  	rentBookMap.put("rentDate", rentDate);
			
			if(request.getParameter("rentId").equals("")) {

				bookService.rentBookService(rentBookMap);
				
				redirectAttributes.addFlashAttribute("state", "SUCCESS");
				redirectAttributes.addFlashAttribute("message", "대출되었습니다. 반납일은 " + returnTerm +" 입니다.");
				status.setComplete();
				System.out.println("페이지"+request.getParameter("page"));
				return "redirect:/books.do?page="+request.getParameter("page");
			} else {
				rentBookMap.put("rentId", request.getParameter("rentId"));
				
				bookService.returnAndrentBookService(rentBookMap);
				
				System.out.println("대여완료");
				rentBookMap.put("userId", rentBookMap.get("memberId"));
				
				rentBookMap.put("content","대출한 사람이 『"+ request.getParameter("title") +"』책을 반납해서 책 대여를 완료했습니다.");
				
				bookService.libroNotificationService(rentBookMap);
				
				return "forward:/cancelReserveBook.do";
			}
		}
	}	

	@RequestMapping(value = "reserveBook.do")
	public String reserveBookMain(@RequestParam String userId, @RequestParam String rentId, HttpServletRequest request,
			ModelMap model, RedirectAttributes redirectAttributes, SessionStatus status) throws Exception{

		System.out.println("예약하는 사람 :" + rentId +","+userId);
		
		int reserveBookCnt = bookService.selectReserveBookCnt(rentId);
		
		if(reserveBookCnt >= 3) {

			redirectAttributes.addFlashAttribute("state", "FAIL");
			redirectAttributes.addFlashAttribute("message", "예약은 3명까지 가능합니다. 다른 책을 이용해주세요.");
			
		} else {
			
			HashMap<String, Object> rentBookMap = new HashMap<String, Object>();
			
			rentBookMap.put("reserveMemberId", userId);
			rentBookMap.put("rentId", rentId);
			rentBookMap.put("rank", reserveBookCnt+1);
			
			
			bookService.reserveBookService(rentBookMap);
			redirectAttributes.addFlashAttribute("state", "SUCCESS");
			redirectAttributes.addFlashAttribute("message", "예약 되었습니다." + "당신의 순번은 "+(reserveBookCnt+1)+"");
			
		}
		
		status.setComplete();
		
		return "redirect:/books.do?page="+request.getParameter("page");
	}	
	
	// 리뷰 관련 된 것
	@RequestMapping(value = "reviewSaveAndDeleteTx.do")
	public String reviewSaveAndDeleteTx(@RequestParam HashMap<String, Object> bookReviewMap, HttpServletRequest request,
			ModelMap model, RedirectAttributes redirectAttributes) throws Exception {
		
		bookService.reviewSaveAndDeleteTx(bookReviewMap);
		
		redirectAttributes.addFlashAttribute("isCheck", "Y");
		if("I".equals(bookReviewMap.get("editType"))) {
			
			redirectAttributes.addFlashAttribute("message", "리뷰가 추가되었습니다.");
		} else if("U".equals(bookReviewMap.get("editType"))) {
			
			redirectAttributes.addFlashAttribute("message", "리뷰가 수정되었습니다.");
		} else {
			
			redirectAttributes.addFlashAttribute("message", "리뷰가 삭제되었습니다.");
		}
				
		return "redirect:/libroBookContent.do?page="+request.getParameter("page")+"&bookId="+bookReviewMap.get("bookId");
	}

}