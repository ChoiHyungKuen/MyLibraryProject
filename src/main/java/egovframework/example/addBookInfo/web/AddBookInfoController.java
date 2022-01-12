package egovframework.example.addBookInfo.web;

import java.awt.AlphaComposite;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.example.addBookInfo.service.AddBookInfoService;

@Controller
public class AddBookInfoController {
	@Resource(name="addBookInfoService")
	private AddBookInfoService addBookInfoService;
	/*
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "addBookInfo.do")
	public String addBookInfo(HttpServletRequest request, ModelMap model) throws Exception {
		
		String uploadPath = request.getSession().getServletContext()
				.getRealPath("/images/book-img/");
		// 파일이 저장될 path 설정//파일 업로드
		
		Map bookInfoMap = makeParamsMap(request);
		
		MultipartHttpServletRequest mptRequest = (MultipartHttpServletRequest) request;

		Iterator fileIterator = mptRequest.getFileNames();

		while (fileIterator.hasNext()) {
			File file =null;
			MultipartFile mFile = mptRequest.getFile((String) fileIterator.next());
			String fileName = mFile.getOriginalFilename();
			String ext = mFile.getOriginalFilename().substring(mFile.getOriginalFilename().lastIndexOf(".")+1);
			
			System.out.println(uploadPath+"\\"+fileName);
			
			bookInfoMap.put("imgDes", uploadPath+"\\"+fileName);
			
			if (!mFile.isEmpty()) {

				mFile.transferTo(file = new File(uploadPath +"\\"+fileName));
				
				confirmImageSizeAndResize(file, ext);

				break;
			}

		}
		
		addBookInfoService.insertBookInfo(bookInfoMap);
		return "admin/addBookInfo.tiles";
	}

	 @SuppressWarnings({ "rawtypes", "unchecked" })
	 public static HashMap makeParamsMap(HttpServletRequest request) {
	      
	      HashMap returnVal = new HashMap();
	      
	      Enumeration enums = request.getParameterNames();
	      
	      while(enums.hasMoreElements()) {
	         
	         String paramName = (String) enums.nextElement();
	         
	         if(paramName.equals("inputBookImg")) {
	        	 
	        	 System.out.println("파일도 탄다?");
	        	 continue;
	         }
	         
	         String[] parameters = request.getParameterValues(paramName);
	         
	         if(parameters.length > 1) {
	            
	            returnVal.put(paramName, parameters);
	         } else {
	            
	            returnVal.put(paramName, parameters[0]);
	         }
	      }
	      
	      return returnVal;
	      
	      
	   }

	private void confirmImageSizeAndResize(File img, String ext) throws IOException {
		System.out.println(ext);
		Image newImage = ImageIO.read(img);
		System.out.println("w: "+newImage.getWidth(null)+", h: "+newImage.getHeight(null));
		ImageIO.write(
				resizeImage(newImage,newImage.getWidth(null), newImage.getHeight(null), 300), 
				ext, img);
	}

	BufferedImage resizeImage(final Image image, int width, int height, int resizeWidth) {
		int resizeHeight = height;
		
	    if (width <= resizeWidth) {
	    	
	    	resizeWidth = width;
	    	resizeHeight = height;
	    } else {
	    	
	    	float per = (float) resizeWidth/ (float)width;
	    	System.out.println(per);
	        resizeHeight = (int)(height * per);
	    }

	    System.out.println(resizeWidth+","+resizeHeight);
	    final BufferedImage bufferedImage = new BufferedImage(resizeWidth, resizeHeight, BufferedImage.TYPE_INT_RGB);
	  
	    final Graphics2D graphics2D = bufferedImage.createGraphics();
	    graphics2D.setComposite(AlphaComposite.Src);
	    graphics2D.setRenderingHint(RenderingHints.KEY_INTERPOLATION,RenderingHints.VALUE_INTERPOLATION_BILINEAR);
	    graphics2D.setRenderingHint(RenderingHints.KEY_RENDERING,RenderingHints.VALUE_RENDER_QUALITY);
	    graphics2D.setRenderingHint(RenderingHints.KEY_ANTIALIASING,RenderingHints.VALUE_ANTIALIAS_ON);
	    graphics2D.drawImage(image, 0, 0, resizeWidth,resizeHeight, null);
	    graphics2D.dispose();

	    return bufferedImage;
	}*/
}
