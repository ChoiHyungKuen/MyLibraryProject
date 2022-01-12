package egovframework.example.calendar.service;

import java.util.HashMap;
import java.util.List;

public interface CalendarService {

	List<?> selectCalendarInfoList() throws Exception;

	void insertCalendarInfo(HashMap<String, Object> calendarInfoMap) throws Exception;

	void saveCalendarInfoTx(HashMap<String, Object> calendarInfoMap) throws Exception; 

}
