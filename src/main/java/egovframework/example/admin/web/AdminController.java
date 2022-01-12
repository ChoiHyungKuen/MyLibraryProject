package egovframework.example.admin.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminController {
	
	@RequestMapping(value = "manageMenu.do")
	public String manageMenu(HttpServletRequest request, ModelMap model) throws Exception{

		request.setCharacterEncoding("UTF-8");
		System.out.println("컨트롤러 탐");
		return "admin/manageMenu.tiles";
	}	
	
}
