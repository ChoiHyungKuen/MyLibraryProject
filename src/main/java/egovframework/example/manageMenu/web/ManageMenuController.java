package egovframework.example.manageMenu.web;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.cmmn.JsonUtil;
import egovframework.example.manageMenu.service.ManageMenuService;
import egovframework.example.manageMenu.service.ManageMenuVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class ManageMenuController {

	@Resource(name = "manageMenuService")
	private ManageMenuService manageMenuService;

	@RequestMapping(value = "manageMenuJqGridMain.do")
	public void manageMenuJqGrid(HttpServletRequest request,
			HttpServletResponse response, @ModelAttribute ManageMenuVO manageMenuVO,
			ModelMap model) throws Exception {
		
		PrintWriter out = null;

		response.setCharacterEncoding("UTF-8");

		System.out.println("jqgridVO = " + manageMenuVO.getRows());

		List<EgovMap> manageMenuList = manageMenuService.selectManageMenuList(manageMenuVO);

		EgovMap manageMenuListCnt = manageMenuService.selectManageMenuListCnt(manageMenuVO);

		HashMap<String, Object> resMap = new HashMap<String, Object>();

		resMap.put("records", manageMenuListCnt.get("totaltotcnt"));
		resMap.put("rows", manageMenuList);
		resMap.put("page", request.getParameter("page"));

		System.out.println("req = " + request.getParameter("page"));

		resMap.put("total", manageMenuListCnt.get("totalpage"));

		out = response.getWriter();

		out.write(JsonUtil.HashMapToJson(resMap).toString());
	}
	
	@RequestMapping(value = "saveManageMenuJqGrid.do")
	public @ResponseBody String saveJqgrid(@RequestParam String param)
			throws Exception { // 전역에러잡기 위해 여기도 Exception 처리를 한다.

		String result = "";

		try {
			System.out.println("파람1 :" + param);
			param = param.replaceAll("&quot;", "\"");

			JSONArray jsonArray = new JSONArray(param);
			manageMenuService.saveJqGridTx(jsonArray);

			result = "SUCCESS";
		} catch (Exception e) {

			result = "FAIL";
		}

		return result;

	}
/*
	@RequestMapping(value = "/deleteManageMenuJqGrid.do")
	public @ResponseBody String deleteJqgrid(@RequestParam String param)
			throws Exception {

		String result = "";
		
		try {
			System.out.println("변경 전 "+param);
			param = param.replaceAll("&quot;", "\"");
			System.out.println(param);
			JSONArray jsonArray = new JSONArray(param);

			manageMenuService.saveJqGridTx(jsonArray);

			result = "SUCCESS";

		} catch (Exception e) {

			result = "FAIL";
		}

		return result;
	}*/
}
