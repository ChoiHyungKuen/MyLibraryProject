package egovframework.example.calendar.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("calendarMapper")
public interface CalendarMapper {

	List<?> selectCalendarInfoList() throws Exception;

	void insertCalendarInfo(HashMap<String, Object> calendarInfoMap) throws Exception;

	void updateCalendarInfo(HashMap<String, Object> calendarInfoMap) throws Exception;

	void deleteCalendarInfo(HashMap<String, Object> calendarInfoMap) throws Exception;

}
