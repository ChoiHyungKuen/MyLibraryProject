package egovframework.example.findMemberInfo.web;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.example.findMemberInfo.service.FindMemberInfoService;

@Controller
public class FindMemberInfoController {

	@Resource(name = "findMemberInfoService")
	private FindMemberInfoService findMemberInfoService;

	@RequestMapping(value = "findMemberInfo.do") 
	public String findMemberInfo(ModelMap model,HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return "main/findMemberInfo";
	}
	
	@RequestMapping(value = "findMemberIdByEmail.do") 
	public String findMemberIdByEmail(ModelMap model,HttpServletRequest request,
			@RequestParam HashMap<String,Object> findEmailMap, RedirectAttributes redirectAttributes) throws Exception {
		
		String findId = findMemberInfoService.selectMemberIdByEmail(findEmailMap);
		
		if(findId != null) {

			redirectAttributes.addFlashAttribute("resultForFindId", "회원님의 아이디를 찾았습니다. 회원님의 ID는 " + findId + "입니다. 다시 로그인해주세요.");
		} else {

			redirectAttributes.addFlashAttribute("resultForFindId", "회원님의 아이디를 찾지 못 했습니다. 다시 확인해주세요.");
		}
		
		return "redirect:/findMemberInfo.do";
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "findMemberPwByEmailAuth.do") 
	public String findMemberPwByAuthEmail(ModelMap model,HttpServletRequest request,
			@RequestParam String findMemberId, RedirectAttributes redirectAttributes) throws Exception {
		
		Map emailMap = findMemberInfoService.selectEmailInfoById(findMemberId);
		 
		if(emailMap == null) {
			redirectAttributes.addFlashAttribute("resultForFindPw", "N");

			return "redirect:/findMemberInfo.do";
		}
		
		String sendEmail = (String) emailMap.get("emailId") + "@" + (String) emailMap.get("emailAddress");
		
		String emailId = (String) emailMap.get("emailId");
		
		// 아이디 뒤에 위치를 자른다. (보안상 일부분만 보여주게한다.)
		String returnEmailToUser = emailId.replace(emailId.substring(emailId.length()-3, emailId.length()),"***") + "@" + (String) emailMap.get("emailAddress");
		
		int random = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
	    
		String authCode = String.valueOf(random);
	    
		request.getSession().setAttribute("authCode", authCode);
	 
	    String subject = "[정보도서관에서 보낸 메일] 회원님의 비밀번호 찾기 관련 메일입니다.";
	    String content = "안녕하세요. 정보도서관 관리자입니다. 회원님의 비밀번호 찾기를 위한 인증과정을 진행합니다."
	    		+ " 비밀번호 찾기 인증 코드는 " +  authCode + " 입니다. 인증코드를 입력하시고 비밀번호를 변경해주세요.";

	    findMemberInfoService.send(subject, content, "gudrms1592@naver.com", sendEmail);
		
		redirectAttributes.addFlashAttribute("findMemberId", findMemberId);
		redirectAttributes.addFlashAttribute("returnEmailToUser", returnEmailToUser);
		redirectAttributes.addFlashAttribute("resultForFindPw", "Y");
		redirectAttributes.addFlashAttribute("findMemberId", findMemberId);
		
		return "redirect:/findMemberInfo.do";
	}

	@RequestMapping(value = "changeMemberPwByEmailAuth.do") 
	public String  changeMemberPwByEmailAuth(ModelMap model,HttpServletRequest request,
			@RequestParam HashMap<String,Object> changeMemberInfoMap, RedirectAttributes redirectAttributes) throws Exception {
		
		findMemberInfoService.updateMemberInfo(changeMemberInfoMap);
		
		redirectAttributes.addFlashAttribute("isChangeMemberInfo", "Y");
		
		return "redirect:/loginView.do";
	}
}
