package egovframework.example.board.web;

import java.awt.AlphaComposite;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.example.board.service.BoardPagingVO;
import egovframework.example.board.service.BoardService;
import egovframework.example.cmmn.JsonUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class BoardController {
	@Resource(name = "boardService")
	BoardService boardService;
	
	@RequestMapping(value = "libroBoardList.do")
	public void libroBoardList(HttpServletResponse response, BoardPagingVO boardPagingVO) throws Exception{
		PrintWriter out = null;
		System.out.println("??"+boardPagingVO.getPage());
		response.setCharacterEncoding("UTF-8");
		
		HashMap<String,Object> dataMap = new HashMap<String,Object>();

		List<?> pagingList = boardService.selectPagingList(boardPagingVO);
		System.out.println(pagingList);
		dataMap.put("pagingList", JsonUtil.ListToJson(pagingList));
/*
		model.addAttribute("pagingList", pagingList);*/

		EgovMap pagingListCnt = boardService.selectPagingListCnt(boardPagingVO);
		
		System.out.println("pagingListCnt" + pagingListCnt);
		
		HashMap<String, Object> resMap = new HashMap<String, Object>();

		System.out.println("page : " + boardPagingVO.getPage());
		System.out.println("totalPage : " + pagingListCnt.get("totalPage"));
		System.out.println("pageScale : " + boardPagingVO.getPageScale());

		resMap.put("page", boardPagingVO.getPage()); // ??????????????? page??????
		resMap.put("total", pagingListCnt.get("totalPage")); // ???????????? page???
		resMap.put("pageScale", boardPagingVO.getPageScale()); // ???????????? ????????? ????????? ?????????
	/*	
		// ?????????????????? ?????? ?????????. ??? ????????? ????????? ??????, ?????? ?????? ???????????? ??? ???????????? ???????????? ????????? ????????????.
		model.addAttribute("currentPage", boardPagingVO.getPage());
		*/
		/* ??????????????? = (??????) ???????????????/????????????????????? ????????? ????????? 
		  ????????? ???????????? 3?????? (1,2,3) 1?????? (4,5,6)2??????
		*/
		int pageGroup = (int) Math.ceil((double) boardPagingVO.getPage()
				/ boardPagingVO.getPageScale());

		// ??? ???????????? ?????? rowNum
		long startPage = (pageGroup - 1) * boardPagingVO.getPageScale() + 1;

		boardPagingVO.setStartPage(startPage);

		System.out.println("startPage : " + boardPagingVO.getStartPage());

		resMap.put("startPage", boardPagingVO.getStartPage());

		// ??? ???????????? ????????? rowNum
		long endPage = startPage + boardPagingVO.getPageScale() - 1;

		boardPagingVO.setEndPage(endPage);

		System.out.println("endPage : " + boardPagingVO.getEndPage());

		resMap.put("endPage", boardPagingVO.getEndPage());

		// ???????????????
		long prePage = (pageGroup - 2) * boardPagingVO.getPageScale() + 1;

		// ???????????????
		long nextPage = pageGroup * boardPagingVO.getPageScale() + 1;

		System.out.println("pageGroup : " + pageGroup);
		System.out.println("prePage : " + prePage);
		System.out.println("nextPage : " + nextPage);

		resMap.put("pageGroup", pageGroup);
		resMap.put("prePage", prePage);
		resMap.put("nextPage", nextPage);
		dataMap.put("resMap", JsonUtil.MapToJson(resMap));
/*
		model.addAttribute("resMap", resMap);

		*//*
		List<?> boardList = boardService.selectBoardList();*/
		out = response.getWriter();
		System.out.println(dataMap); 
		out.write(JsonUtil.HashMapToJson(dataMap));
	}	
	
	@RequestMapping(value = "recentLibroBoardList.do")
	public void recentlibroBoardList(HttpServletResponse response) throws Exception{
		PrintWriter out = null;
		response.setCharacterEncoding("UTF-8");
		List<?> boardList = boardService.selectRecentBoardList();
		out = response.getWriter();
		out.write(JsonUtil.ListToJson(boardList));
	}		
	
	@RequestMapping(value = "changeBoardItemInfoMain.do") 
	public String changeBoardItemInfoMain(ModelMap model,HttpServletRequest request) throws Exception {
			System.out.println("DDD");
		return "main/changeBoardItemInfoMain";
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "saveBoardItemInfoTx.do", method = RequestMethod.POST)
	public String saveCalendarInfoTx(ModelMap model,HttpServletRequest request,
			@RequestParam HashMap<String, Object> boardItemInfoMap) throws Exception {
		
		try{

			String uploadPath = "/usr/lib/apache-tomcat7/webapps/sample/uploadBoard/";
			/*String uploadPath = "C:/eGovFrameDev-3.5.1-64bit/workspace/MyLibraryWebProject/src/main/webapp/uploadBoard/";
		*/
			MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;

			Iterator fileIterator = mptRequest.getFileNames();
		
			while (fileIterator.hasNext()) {

				File file = null;
				MultipartFile mFile = mptRequest.getFile((String) fileIterator.next());
			
				String fileName = mFile.getOriginalFilename();
			
				String ext = mFile.getOriginalFilename().substring(mFile.getOriginalFilename().lastIndexOf(".") + 1);

				System.out.println(uploadPath + fileName);

				boardItemInfoMap.put("imgDes","uploadBoard/" + fileName);
			
				if (!mFile.isEmpty()) {

					mFile.transferTo(file = new File(uploadPath + fileName));

					checkImageSizeAndResize(file, ext);

					break;
				}	

			}
			boardService.saveBoardItemInfoTx(boardItemInfoMap);
			model.addAttribute("isCheck","Y");
		
			String editType = (String) boardItemInfoMap.get("editType");
			if("I".equals(editType)) {

				model.addAttribute("message","??????????????? ??????????????????.");
			} else if("U".equals(editType)) {

				model.addAttribute("message", "??????????????? ??????????????????.");
			} else if("D".equals(editType)) {

				model.addAttribute("message", "??????????????? ??????????????????.");
			}
			
			model.addAttribute("state","delete");
		} catch(Exception e) {
			
			System.out.println(e);
		}
		
		return "main/changeBoardItemInfoMain";
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static HashMap makeParamsMap(HttpServletRequest request) {
	      
		HashMap returnVal = new HashMap();
	      
	    Enumeration enums = request.getParameterNames();
	      
	    while(enums.hasMoreElements()) {
	         
	         String paramName = (String) enums.nextElement();
	         
	         String[] parameters = request.getParameterValues(paramName);
	         
	         if(paramName == "imgDes") 
	        	 continue;
	         returnVal.put(paramName, parameters);
	         /* ???????????? ?????? ??? ??????
	         if(parameters.length > 1) {
	            
	            returnVal.put(paramName, parameters);
	         } else {
	            
	            returnVal.put(paramName, parameters[0]);
	         }*/
	      }
	      
	      return returnVal;
	      
	      
	}
	private void checkImageSizeAndResize(File img, String ext) throws IOException {
		
		Image newImage = ImageIO.read(img);
		System.out.println("w: " + newImage.getWidth(null) + ", h: " + newImage.getHeight(null));
		ImageIO.write(
				resizeImage(newImage, newImage.getWidth(null),
						newImage.getHeight(null), 149), ext, img);
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
