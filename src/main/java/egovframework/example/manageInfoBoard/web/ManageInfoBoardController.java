package egovframework.example.manageInfoBoard.web;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.cmmn.JsonUtil;
import egovframework.example.manageInfoBoard.service.ManageInfoBoardService;
import egovframework.example.manageInfoBoard.service.ManageInfoBoardVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class ManageInfoBoardController {

	@Resource(name = "manageInfoBoardService")
	private ManageInfoBoardService manageInfoBoardService;

	@RequestMapping(value = "manageInfoBoard.do")
	public String manageInfoBoard(HttpServletRequest request, ModelMap model) throws Exception {

		return "admin/manageInfoBoard.tiles";
	}

	@RequestMapping(value = "manageInfoBoardJqGridMain.do")
	public void manageMenuJqGrid(HttpServletRequest request,
			HttpServletResponse response,@ModelAttribute ManageInfoBoardVO manageInfoBoardVO,
			ModelMap model) throws Exception {
		
		PrintWriter out = null;

		response.setCharacterEncoding("UTF-8");

		System.out.println("jqgridVO = " + manageInfoBoardVO.getRows());

		List<EgovMap> manageMenuList = manageInfoBoardService.selectManageInfoBoardList(manageInfoBoardVO);

		EgovMap manageMenuListCnt = manageInfoBoardService.selectManageInfoBoardListCnt(manageInfoBoardVO);

		HashMap<String, Object> resMap = new HashMap<String, Object>();

		resMap.put("records", manageMenuListCnt.get("totaltotcnt"));
		resMap.put("rows", manageMenuList);
		resMap.put("page", request.getParameter("page"));

		System.out.println("req = " + request.getParameter("page"));

		resMap.put("total", manageMenuListCnt.get("totalpage"));
		out = response.getWriter();
		out.write(JsonUtil.HashMapToJson(resMap).toString());
	}

	@RequestMapping(value = "saveManageInfoBoardJqGrid.do")
	public @ResponseBody String saveJqgrid(@RequestParam String param) throws Exception { // 전역에러잡기 위해 여기도 Exception 처리를 한다.

		String result = "";

		try {
			System.out.println("파람1 :" + param);
			param = param.replaceAll("&quot;", "\"");

			JSONArray jsonArray = new JSONArray(param);
			manageInfoBoardService.saveJqGridTx(jsonArray);

			result = "SUCCESS";
		} catch (Exception e) {

			result = "FAIL";
		}

		return result;

	}

	@RequestMapping(value = "manageLibroInformation.do")
	public String manageLibroInforamtion(Model model) throws Exception { // 전역에러잡기 위해 여기도 Exception 처리를 한다.
		
		return "admin/manageLibroInformation.tiles";
	}
}
