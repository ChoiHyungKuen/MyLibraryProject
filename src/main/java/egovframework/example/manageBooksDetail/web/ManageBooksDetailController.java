package egovframework.example.manageBooksDetail.web;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import egovframework.example.manageBooksDetail.service.ManageBooksDetailService;
import egovframework.example.manageBooksDetail.service.ManageBooksDetailVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class ManageBooksDetailController {

	@Resource(name = "manageBooksDetailService")
	private ManageBooksDetailService manageBooksDetailService;

	@RequestMapping(value = "manageBooksDetail.do")
	public String manageBooksDetail(HttpServletRequest request, ModelMap model) throws Exception{

		model.addAttribute("bookTitle", request.getParameter("bookTitle"));
		model.addAttribute("bookId", request.getParameter("bookId"));
		
		return "admin/manageBooksDetail.tiles";
	}	
	
	@RequestMapping(value = "manageBooksDetailJqGridMain.do")
	public void manageBooksDetailJqGrid(HttpServletRequest request,
			HttpServletResponse response, @ModelAttribute ManageBooksDetailVO manageBooksDetailVO,
			ModelMap model) throws Exception {
		
		PrintWriter out = null;

		response.setCharacterEncoding("UTF-8");

		String quotZero = request.getParameter("param");

		System.out.println("1. quo = " + quotZero);

		quotZero = quotZero.replaceAll("&quot;", "\"");

		System.out.println("2. quo = " + quotZero);

		Map<String, Object> castMap = new HashMap<String, Object>();

		castMap = JsonUtil.JsonToMap(quotZero);

		manageBooksDetailVO.setBookId((String) castMap.get("bookId"));
		
		System.out.println("manageBooksVO = " + manageBooksDetailVO.getId());

		List<EgovMap> manageBooksList = manageBooksDetailService.selectManageBooksDetailList(manageBooksDetailVO);

		EgovMap manageMenuBooksCnt = manageBooksDetailService.selectManageBooksDetailListCnt(manageBooksDetailVO);

		HashMap<String, Object> resMap = new HashMap<String, Object>();

		resMap.put("records", manageMenuBooksCnt.get("totaltotcnt"));
		resMap.put("rows", manageBooksList);
		resMap.put("page", request.getParameter("page"));

		System.out.println("req = " + request.getParameter("page"));

		resMap.put("total", manageMenuBooksCnt.get("totalpage"));

		out = response.getWriter();

		out.write(JsonUtil.HashMapToJson(resMap).toString());
	}
	
	@RequestMapping(value = "saveManageBooksDetailJqGrid.do")
	public @ResponseBody String saveJqgrid(@RequestParam String param)
			throws Exception { // 전역에러잡기 위해 여기도 Exception 처리를 한다.

		String result = "";

		try {
			System.out.println("파람1 :" + param);
			param = param.replaceAll("&quot;", "\"");

			JSONArray jsonArray = new JSONArray(param);
			manageBooksDetailService.saveJqGridTx(jsonArray);

			result = "SUCCESS";
		} catch (Exception e) {

			result = "FAIL";
		}

		return result;

	}

	@RequestMapping(value = "/deleteManageBooksDetailJqGrid.do")
	public @ResponseBody String deleteJqgrid(@RequestParam String param)
			throws Exception {

		String result = "";
		
		try {
			System.out.println("변경 전 "+param);
			param = param.replaceAll("&quot;", "\"");
			System.out.println(param);
			JSONArray jsonArray = new JSONArray(param);

			manageBooksDetailService.saveJqGridTx(jsonArray);

			result = "SUCCESS";

		} catch (Exception e) {

			result = "FAIL";
		}

		return result;
	}
}
