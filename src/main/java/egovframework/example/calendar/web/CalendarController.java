package egovframework.example.calendar.web;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.example.calendar.service.CalendarService;
import egovframework.example.cmmn.JsonUtil;

@Controller
public class CalendarController {

	@Resource(name = "calendarService")
	private CalendarService calendarService;

	@RequestMapping(value = "initCalendar.do") 
	public void initCalendar(ModelMap model,HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		out = response.getWriter();
			
		List<?> calendarInfoList = calendarService.selectCalendarInfoList();
		
		out.write(JsonUtil.ListToJson(calendarInfoList));
	
	}

	@RequestMapping(value = "manageCalendar.do") 
	public String manageCalendar(ModelMap model,HttpServletRequest request) throws Exception {
			
		return "admin/manageCalendar.tiles";
	}


	@RequestMapping(value = "changeCalendarInfoMain.do") 
	public String addCalendarInfoMain(ModelMap model,HttpServletRequest request) throws Exception {
			
		return "admin/changeCalendarInfoMain";
	}

	@RequestMapping(value = "saveCalendarInfoTx.do") 
	public String saveCalendarInfoTx(ModelMap model,HttpServletRequest request,
			 @RequestParam HashMap<String, Object> calendarInfoMap) throws Exception {

		calendarService.saveCalendarInfoTx(calendarInfoMap);
		
		model.addAttribute("isCheck","Y");
		String editType = (String) calendarInfoMap.get("editType");
		if("I".equals(editType)) {

			model.addAttribute("message","성공적으로 추가했습니다.");
		} else if("U".equals(editType)) {

			model.addAttribute("message", "성공적으로 변경했습니다.");
		} else if("D".equals(editType)) {

			model.addAttribute("message", "성공적으로 삭제했습니다.");
		}
		
		return "admin/changeCalendarInfoMain";
	}
	
}

