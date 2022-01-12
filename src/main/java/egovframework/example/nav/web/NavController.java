package egovframework.example.nav.web;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.example.cmmn.JsonUtil;
import egovframework.example.nav.service.NavService;

@Controller
public class NavController {
	
	@Resource(name = "navService")
	private NavService navService;

	@RequestMapping(value = "/mainMenuList.do")
	public void mainMenuList(HttpServletResponse response) throws Exception {
		PrintWriter out = null;
		response.setCharacterEncoding("UTF-8");
		
		List<?> menuList = navService.selectMainMenu();
		
		out = response.getWriter();
		
		out.write(JsonUtil.ListToJson(menuList));
	}
}
