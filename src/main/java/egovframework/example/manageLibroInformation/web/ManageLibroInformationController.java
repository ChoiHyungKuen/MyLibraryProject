package egovframework.example.manageLibroInformation.web;

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

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.example.cmmn.JsonUtil;
import egovframework.example.manageBooks.service.ManageBooksVO;
import egovframework.example.manageLibroInformation.service.ManageLibroInformationService;
import egovframework.example.manageLibroInformation.service.ManageLibroInformationVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class ManageLibroInformationController {

	@Resource(name = "manageLibroInformationService")
	private ManageLibroInformationService manageLibroInformationService;

	@RequestMapping(value = "manageLibroInformationJqGridMain.do")
	public void manageLibroInformationJqGrid(HttpServletRequest request,
			HttpServletResponse response, @ModelAttribute ManageLibroInformationVO manageLibroInformationVO,
			ModelMap model) throws Exception {
		
		PrintWriter out = null;

		response.setCharacterEncoding("UTF-8");

		System.out.println("jqgridVO = " + manageLibroInformationVO.getRows());

		List<EgovMap> manageLibroInformationList = manageLibroInformationService.selectManageLibroInformationList(manageLibroInformationVO);

		EgovMap manageLibroInformationListCnt = manageLibroInformationService.selectManageLibroInformationListCnt(manageLibroInformationVO);

		HashMap<String, Object> resMap = new HashMap<String, Object>();

		resMap.put("records", manageLibroInformationListCnt.get("totaltotcnt"));
		resMap.put("rows", manageLibroInformationList);
		resMap.put("page", request.getParameter("page"));

		System.out.println("req = " + request.getParameter("page"));

		resMap.put("total", manageLibroInformationListCnt.get("totalpage"));

		out = response.getWriter();

		out.write(JsonUtil.HashMapToJson(resMap).toString());
	}
	
	@RequestMapping(value = "saveManageLibroInformationJqGrid.do")
	public @ResponseBody String saveJqgrid(@RequestParam String param)
			throws Exception { // 전역에러잡기 위해 여기도 Exception 처리를 한다.

		String result = "";

		try {
			System.out.println("파람1 :" + param);
			param = param.replaceAll("&quot;", "\"");

			JSONArray jsonArray = new JSONArray(param);
			manageLibroInformationService.saveJqGridTx(jsonArray);

			result = "SUCCESS";
		} catch (Exception e) {

			result = "FAIL";
		}

		return result;
		
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "changeLibroInformationBg.do",  method = RequestMethod.POST)
	public String addBookInfo(ModelMap model, HttpServletRequest request, 
			RedirectAttributes redirectAttributes) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		String uploadPath = "/usr/lib/apache-tomcat7/webapps/sample/images/";
		//String uploadPath = "C:/eGovFrameDev-3.5.1-64bit/workspace/MyLibraryWebProject/src/main/webapp/images/";
	
		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;

		Iterator fileIterator = mptRequest.getFileNames();
		
		while (fileIterator.hasNext()) {

			File file = null;
			MultipartFile mFile = mptRequest.getFile((String) fileIterator.next());
			String fileName = "libro-info-bg.jpg";	// 지정되있는 파일명
			String ext = mFile.getOriginalFilename().substring(
					mFile.getOriginalFilename().lastIndexOf(".") + 1);

			System.out.println(uploadPath + fileName);

			if (!mFile.isEmpty()) {

				mFile.transferTo(file = new File(uploadPath + fileName));

				checkImageSizeAndResize(file, ext);

				break;
			}

		}
		
	    redirectAttributes.addFlashAttribute("isCheck", "Y");
	    
		return "redirect:/manageLibroInformation.do";
	}
	
	private void checkImageSizeAndResize(File img, String ext) throws IOException {
		
		Image newImage = ImageIO.read(img);
		
		ImageIO.write(
				resizeImage(newImage, 800, 400), ext, img);
	}

	BufferedImage resizeImage(final Image image, int resizeWidth, int resizeHeight) {
		
/*
		if (width <= resizeWidth) {

			resizeWidth = width;
			resizeHeight = height;
		} else {

			float per = (float) resizeWidth / (float) width;
			System.out.println(per);
			resizeHeight = (int) (height * per);
		}

		System.out.println(resizeWidth + "," + resizeHeight);*/
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
