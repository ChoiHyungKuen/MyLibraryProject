package egovframework.example.libroSchedule;


import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.quartz.QuartzJobBean;

import egovframework.example.book.service.BookService;
import egovframework.rte.psl.dataaccess.util.EgovMap;


public class LibroSchedulingJob extends QuartzJobBean{

	private ApplicationContext ctx;
	
	private BookService bookService;
	
	@Override
	protected void executeInternal(JobExecutionContext exctx) throws JobExecutionException {

	     ctx = (ApplicationContext)exctx.getJobDetail().getJobDataMap().get("applicationContext");   
	     executeJob(exctx);
	}

	@SuppressWarnings({ "rawtypes" })
	private void executeJob(JobExecutionContext exctx) { 

		bookService = (BookService) ctx.getBean("bookService"); 

		// 오늘 날짜를 가져온다.
		Date date = new Date();
		// 포맷변경 (저장하기 쉽게 변경)
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

		String todayDate = dateFormat.format(date);
		System.out.println(bookService);
		try {
			List<Map> todayRentUserList = bookService.selectTodayRentUserList(todayDate);
			
			System.out.println("오늘 반납해야 하는 사람" + todayRentUserList.size());
			for (int i = 0; i < todayRentUserList.size(); i++) {
				
				HashMap<String, Object> rentUserMap = convertEgovMapToHashMap((EgovMap) todayRentUserList.get(i));
				
				Map nextReserveInfo = bookService.selectPriorityReserveInfo(rentUserMap);
	
				
				if (nextReserveInfo==null || nextReserveInfo.isEmpty()) {
					
					rentUserMap.put("state","대출가능");
					
					bookService.returnBookService(rentUserMap);
				} else {

					HashMap<String, Object> priorityReserveInfo = convertEgovMapToHashMap((EgovMap) nextReserveInfo);
					System.out.println(priorityReserveInfo.get("rentId"));
					int reserveBookCnt = bookService.selectReserveBookCnt((String) priorityReserveInfo.get("rentId"));
					System.out.println("예약수 "+ reserveBookCnt);
					for (int j = 0; j < reserveBookCnt; j++) {

						// 예약취소
						bookService.cancelReserveService(priorityReserveInfo);
						
						String userId = (String) priorityReserveInfo.get("reserveMemberId");
						System.out.println("이름"+userId);
						int rentBookCnt = bookService.selectRentBookCnt(userId);

						if (rentBookCnt >= 2) {

							// 여기는 예약대상자인데 가진 책을 초과했기 때문에 예약취소 되고 다음사람한테 넘긴다.
							System.out.println("책이 많아서 다른사람한테 넘김" + userId);
							HashMap<String, Object> notificationMap = new HashMap<String, Object>();

							notificationMap.put("userId", userId);

							notificationMap.put("content", "현재 예약 우선순위 대상자 분이지만 대여하신 『"+ priorityReserveInfo.get("title") +"』책이 보유권수를 넘었습니다. "
									+ "그래서 현재 예약자에게 대여기회를 넘겼습니다. 다른 책 반납하고 다음에 이용해주세요. 죄송합니다 ㅠㅠ");

							bookService.libroNotificationService(notificationMap);

							bookService.libroNotificationService(notificationMap);
							
							
							nextReserveInfo = bookService.selectPriorityReserveInfo(priorityReserveInfo);
							
							if(nextReserveInfo !=null && !nextReserveInfo.isEmpty()) {
							
								priorityReserveInfo = convertEgovMapToHashMap((EgovMap)nextReserveInfo);
							}
						} else {
							// 예약자가 있는 경우
							// DB 쿼리실행을 위해 쿼리문에 사용하는 이름으로 유저 id를 넣어서 한개더 생성
							priorityReserveInfo.put("memberId", userId);

							date = new Date();
							dateFormat = new SimpleDateFormat("yyyy.MM.dd");
							Calendar cal = Calendar.getInstance();
							cal.setTime(date);
							String rentDate = dateFormat.format(cal.getTime());
							// 대여기간은 14일
							cal.add(Calendar.DATE, 14);
							String returnTerm = dateFormat.format(cal.getTime());			
							
							priorityReserveInfo.put("state", "대출중");
							priorityReserveInfo.put("returnTerm", returnTerm);
							priorityReserveInfo.put("rentDate", rentDate);
							// 예약자의 이름으로 대출하고
							bookService.returnAndrentBookService(priorityReserveInfo);

							HashMap<String, Object> notificationMap = new HashMap<String, Object>();

							notificationMap.put("userId", userId);

							notificationMap.put("content","대출한 사람이 『"+ priorityReserveInfo.get("title") +"』책을 반납해서 책 대여를 완료했습니다.");
							
							bookService.libroNotificationService(notificationMap);
							
							break;
						}

					}
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		}

		System.out.println(todayDate);

		System.out.println("도서관 스케줄러 동작중");

		
	}
	/*
	 EgovMap을 HashMap으로 변환하는 함수
	 서비스에서 사용할때 반환값은 egovmap, 파라미터값은 hashmap으로 넘겼었다.
	 보통은 EgovMap을 바로 뷰로 넘겨서 편하게 사용하기 위한 방법이었다.
	 근데 여기서는 EgovMap을 받아서 바로 서비스의 다른 메소드를 부르는 파라미터로 사용하기 때문에
	 이 함수가 필요함
 	 */	
	@SuppressWarnings("rawtypes")
	private HashMap<String, Object>  convertEgovMapToHashMap(EgovMap egovMap) {
		HashMap<String, Object> resultHashMap = new HashMap<String,Object>();
		
		Set set = egovMap.keySet();
		
		Iterator iterator = set.iterator();
		
		while(iterator.hasNext()) {
			
			String key = (String) iterator.next();
			
			if(egovMap.get(key) instanceof BigDecimal) {
				
				egovMap.put(key,egovMap.get(key).toString());
			}
			
			Object value = egovMap.get(key);
			
			resultHashMap.put(key, value);
		}
		return resultHashMap;
	}


}
