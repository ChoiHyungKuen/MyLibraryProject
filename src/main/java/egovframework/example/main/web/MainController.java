package egovframework.example.main.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.example.main.service.MainService;

@Controller
public class MainController {
	

	@Resource(name = "mainService")
	private MainService mainService;
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "main.do")
	public String initMain(ModelMap model) throws Exception {

		int bookCnt = mainService.selectLibroBookCnt();
		/* 미리 분류를 넣어놓고 jsp에서 반복시킨다. 최대한 코드 단순화를 위해서 사용해봄 */
		List<String> classificationList = new ArrayList<String>();
		
		classificationList.add("일반");
		classificationList.add("철학");
		classificationList.add("종교");
		classificationList.add("과학");
		classificationList.add("예술");
		classificationList.add("언어");
		classificationList.add("문학");
		classificationList.add("역사");
		
		List<Map> bestThreeBookList = mainService.selectBestThreeBookList();
		
		List<Map> libroInformationList = mainService.selectLibroInformationList();
		
		model.addAttribute("libroBookCnt", bookCnt);
		model.addAttribute("classificationList", classificationList);
		model.addAttribute("bestThreeBookList", bestThreeBookList);
		model.addAttribute("libroInformationList", libroInformationList);
		
		return "main/main.tiles";
	}

	@RequestMapping(value = "admin-main.do")
	public String initAdmin(ModelMap model) throws Exception {
		
		return "admin/admin-main.tiles";
	}

	@RequestMapping(value = "notificationView.do")
	public String notificationView(ModelMap model) throws Exception {
		
		return "main/notification";
	}

}