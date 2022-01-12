package egovframework.example.parsingBookInfoFromNaver.web;

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.example.cmmn.JsonUtil;

@Controller
public class ParsingBookInfoFromNaverController {
	
	@RequestMapping(value = "parsingBookInfoFromNaver.do")
	public void parsingBookInfoFromNaver(HttpServletResponse response,  @RequestParam String searchStr) throws Exception{

		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		out = response.getWriter();
		
		HashMap<String, Object> bookInfoMap = new HashMap<String, Object>();
		
        try {
        	
         String utf8= URLEncoder.encode(searchStr,"UTF-8");//쿼리문에들어갈 한글인코딩

         String url = "http://book.naver.com/search/search.nhn?sm=sta_hty.book&sug=&where=nexearch&query="+utf8;

         Document naverSearchBooksDoc = Jsoup.connect(url)
        		 //헤더삽입			
        		 .header("Accept","image/gif, image/xxbitmap, image/jpeg,"
        		 		+ "image/pjpeg,application/xshockwaveflash, application/vnd.msexcel,"
        		 		+ "application/vnd.mspowerpoint, application/msword, */*").get();

         Element searchDiv = naverSearchBooksDoc.getElementById("searchBiblioList");	// 검색된 목록들의 div id
         Elements searchLinks = searchDiv.getElementsByTag("a");  //a태그를 불러온다.
         url = searchLinks.get(0).attr("abs:href");		// 맨 처음걸 가져온다.
         
         Document naverSearchBookInfoDoc = Jsoup.connect(url)
        		 //헤더삽입			
        		 .header("Accept","image/gif, image/xxbitmap, image/jpeg,"
        		 		+ "image/pjpeg,application/xshockwaveflash, application/vnd.msexcel,"
        		 		+ "application/vnd.mspowerpoint, application/msword, */*").get();
         
         Elements naverSearchBookInfoInnerElements = naverSearchBookInfoDoc.getElementsByClass("book_info_inner");  //책 정보가 들어가 있는 div class
     	
         Elements infoDiv = naverSearchBookInfoInnerElements.get(0).getElementsByTag("div");		// 작가, 출판사, 출판일 정보가 담겨있는 div

         StringTokenizer stz = new StringTokenizer(infoDiv.get(3).text(), "|");	// |를 자르기 위한 StringTokenizer
    
         int tokenCnt = stz.countTokens();
         int getPageDivNum = 4;	// 페이지 추출하는 Div의 번째 수, 영어원서면 4번째의 div를 추출해야한다.
         
         Elements naverSearchBookInfoElements = naverSearchBookInfoDoc.getElementsByClass("book_info");
         
         bookInfoMap.put("title", naverSearchBookInfoElements.get(0).getElementsByTag("h2").text());
         
         // 작가 추출
         String author = stz.nextToken().trim();
         
         bookInfoMap.put("author", author.replaceFirst("저자 ", ""));
         
         if(tokenCnt == 4) {
        	 
        	getPageDivNum=5;
        	stz.nextToken();
         }
         
         // 출판사 추출
         bookInfoMap.put("publisher", stz.nextToken());
         
         // 출판일 추출
         bookInfoMap.put("publishDate", stz.nextToken().trim());
         
         // 페이지 추출
         stz = new StringTokenizer(infoDiv.get(getPageDivNum).text(), "|");

         String page = stz.nextToken().trim();
         
         bookInfoMap.put("page", page.replaceFirst("페이지 ", ""));
         
         // 내용 추출
         Element contentElement = naverSearchBookInfoDoc.getElementById("bookIntroContent");
         bookInfoMap.put("content", contentElement.text());
         Iterator<String> iterator = bookInfoMap.keySet().iterator();
         // 반복자를 이용해서 출력
         while (iterator.hasNext()) { 
        	 
        	 String key = (String)iterator.next(); // 키 얻기
        	 System.out.print("key="+key+" / value="+bookInfoMap.get(key));  // 출력
         }
         
        } catch (Exception e) {
        	bookInfoMap.put("error", "책을 검색하지 못 했습니다.");
        	System.out.println(e);
        }
        
		out.write(JsonUtil.HashMapToJson(bookInfoMap));
	}	
}
