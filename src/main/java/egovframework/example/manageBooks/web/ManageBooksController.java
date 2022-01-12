package egovframework.example.manageBooks.web;

import java.awt.AlphaComposite;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Validator;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.example.cmmn.JsonUtil;
import egovframework.example.manageBooks.service.ManageBooksService;
import egovframework.example.manageBooks.service.ManageBooksVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class ManageBooksController {

	@Resource(name = "manageBooksService")
	private ManageBooksService manageBooksService;
	
	@Resource
	Validator validator;

	@InitBinder
	public void initBinder(WebDataBinder dataBinder) {

		dataBinder.setValidator(this.validator);
	}

	@RequestMapping(value = "bookInfoCheckAndUploadFile.do")
	public String bookInfoCheck(@Validated ManageBooksVO manageBooksVO,
			BindingResult bindingResult, HttpServletRequest request, ModelMap model) throws Exception {
		
		if (bindingResult.hasErrors()) {
			System.out.println(bindingResult.getAllErrors());
			model.addAttribute("isCheck", "N");
			return "admin/addBookInfoMain.tiles";

		} else {

			return "forward:/addBookInfo.do";
		}
	}

	@RequestMapping(value = "manageBooks.do")
	public String manageBooks(HttpServletRequest request, ModelMap model) throws Exception {

		return "admin/manageBooks.tiles";
	}

	@RequestMapping(value = "manageBooksJqGridMain.do")
	public void manageBooksJqGrid(HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute ManageBooksVO manageBooksVO, ModelMap model) throws Exception {

		PrintWriter out = null;

		response.setCharacterEncoding("UTF-8");

		String quotZero = request.getParameter("param");

		System.out.println("1. quo = " + quotZero);

		quotZero = quotZero.replaceAll("&quot;", "\"");

		System.out.println("2. quo = " + quotZero);

		Map<String, Object> castMap = new HashMap<String, Object>();

		castMap = JsonUtil.JsonToMap(quotZero);

		manageBooksVO.setId((String) castMap.get("id"));

		System.out.println("manageBooksVO = " + manageBooksVO.getId());

		List<EgovMap> manageBooksList = manageBooksService
				.selectManageBooksList(manageBooksVO);

		EgovMap manageBooksCnt = manageBooksService
				.selectManageBooksListCnt(manageBooksVO);

		HashMap<String, Object> resMap = new HashMap<String, Object>();

		resMap.put("records", manageBooksCnt.get("totaltotcnt"));
		resMap.put("rows", manageBooksList);
		resMap.put("page", request.getParameter("page"));

		System.out.println("req = " + request.getParameter("page"));

		resMap.put("total", manageBooksCnt.get("totalpage"));

		out = response.getWriter();

		out.write(JsonUtil.HashMapToJson(resMap).toString());
	}

	@RequestMapping(value = "saveManageBooksJqGrid.do")
	public @ResponseBody String saveJqgrid(@RequestParam String param)
			throws Exception { // 전역에러잡기 위해 여기도 Exception 처리를 한다.

		String result = "";

		try {
			System.out.println("파람1 :" + param);
			param = param.replaceAll("&quot;", "\"");

			JSONArray jsonArray = new JSONArray(param);
			manageBooksService.saveJqGridTx(jsonArray);

			result = "SUCCESS";
		} catch (Exception e) {

			result = "FAIL";
		}

		return result;

	}

	@RequestMapping(value = "/deleteManageBooksJqGrid.do")
	public @ResponseBody String deleteJqgrid(@RequestParam String param)
			throws Exception {

		String result = "";

		try {
			System.out.println("변경 전 " + param);
			param = param.replaceAll("&quot;", "\"");
			System.out.println(param);
			JSONArray jsonArray = new JSONArray(param);

			manageBooksService.saveJqGridTx(jsonArray);

			result = "SUCCESS";

		} catch (Exception e) {

			result = "FAIL";
		}

		return result;
	}

	@RequestMapping(value = "addBookInfoMain.do")
	public String addBookInfoMain(HttpServletRequest request, ModelMap model,  ManageBooksVO manageBooksVO)
			throws Exception {

		return "admin/addBookInfoMain.tiles";
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "addBookInfo.do",  method = RequestMethod.POST)
	public String addBookInfo(ManageBooksVO manageBooksVO, ModelMap model,
			HttpServletRequest request, RedirectAttributes redirectAttributes) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		String uploadPath = "/usr/lib/apache-tomcat7/webapps/sample/upload/";
		/*String uploadPath = "C:/eGovFrameDev-3.5.1-64bit/workspace/MyLibraryWebProject/src/main/webapp/upload/";
		*/
		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;

		Iterator fileIterator = mptRequest.getFileNames();
		
		while (fileIterator.hasNext()) {

			File file = null;
			MultipartFile mFile = mptRequest.getFile((String) fileIterator
					.next());
			String fileName = mFile.getOriginalFilename();
			String ext = mFile.getOriginalFilename().substring(
					mFile.getOriginalFilename().lastIndexOf(".") + 1);

			System.out.println(uploadPath + fileName);

			manageBooksVO.setImgDes("upload/" + fileName);
			if (!mFile.isEmpty()) {

				mFile.transferTo(file = new File(uploadPath + fileName));

				checkImageSizeAndResize(file, ext);

				break;
			}

		}

		manageBooksService.insertBookInfo(manageBooksVO);
		
	    redirectAttributes.addFlashAttribute("isCheck", "Y");
	    
		return "redirect:/addBookInfoMain.do";
	}
	
	private void checkImageSizeAndResize(File img, String ext) throws IOException {
		
		Image newImage = ImageIO.read(img);
		System.out.println("w: " + newImage.getWidth(null) + ", h: "
				+ newImage.getHeight(null));
		ImageIO.write(
				resizeImage(newImage, newImage.getWidth(null),
						newImage.getHeight(null), 300), ext, img);
	}

	BufferedImage resizeImage(final Image image, int width, int height, int resizeWidth) {
		int resizeHeight = height;

		if (width <= resizeWidth) {

			resizeWidth = width;
			resizeHeight = height;
		} else {

			float per = (float) resizeWidth / (float) width;
			System.out.println(per);
			resizeHeight = (int) (height * per);
		}

		System.out.println(resizeWidth + "," + resizeHeight);
		final BufferedImage bufferedImage = new BufferedImage(resizeWidth,
				resizeHeight, BufferedImage.TYPE_INT_RGB);

		final Graphics2D graphics2D = bufferedImage.createGraphics();
		
		graphics2D.setComposite(AlphaComposite.Src);
		graphics2D.setRenderingHint(RenderingHints.KEY_INTERPOLATION,
				RenderingHints.VALUE_INTERPOLATION_BILINEAR);
		graphics2D.setRenderingHint(RenderingHints.KEY_RENDERING,
				RenderingHints.VALUE_RENDER_QUALITY);
		graphics2D.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
				RenderingHints.VALUE_ANTIALIAS_ON);
		graphics2D.drawImage(image, 0, 0, resizeWidth, resizeHeight, null);
		graphics2D.dispose();

		return bufferedImage;
	}
}
