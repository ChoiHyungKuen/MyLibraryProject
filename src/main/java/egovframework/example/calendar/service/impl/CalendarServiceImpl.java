package egovframework.example.calendar.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONObject;
import org.springframework.stereotype.Service;

import egovframework.example.calendar.service.CalendarService;
import egovframework.example.cmmn.JsonUtil;

@Service("calendarService")
public class CalendarServiceImpl implements CalendarService {

	@Resource(name = "calendarMapper")
	private CalendarMapper calendarMapper;

	@Override
	public List<?> selectCalendarInfoList() throws Exception {
		
		return calendarMapper.selectCalendarInfoList();
	}

	@Override
	public void insertCalendarInfo(HashMap<String, Object> calendarInfoMap) throws Exception {
		calendarMapper.insertCalendarInfo(calendarInfoMap);
	}

	@Override
	public void saveCalendarInfoTx(HashMap<String, Object> calendarInfoMap) throws Exception {
		
		try {
			if ("I".equals(calendarInfoMap.get("editType"))) {

				calendarMapper.insertCalendarInfo(calendarInfoMap);
			} else if ("U".equals(calendarInfoMap.get("editType"))) {

				calendarMapper.updateCalendarInfo(calendarInfoMap);
			} else if ("D".equals(calendarInfoMap.get("editType"))) {

				calendarMapper.deleteCalendarInfo(calendarInfoMap);
			}
		} catch (Exception e) {

			throw e;
		}
	}

}
