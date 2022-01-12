package egovframework.example.member.web;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Validator;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.example.member.service.MemberService;
import egovframework.example.member.service.MemberVO;

@Controller
public class MemberController {
	
	@Resource(name="memberService")
	private MemberService memberService;

	@Resource
	Validator validator;

	@InitBinder
	public void initBinder(WebDataBinder dataBinder) {

		dataBinder.setValidator(this.validator);
	}

	@RequestMapping(value = "/memberInfoCheck.do")
	public String memberInfoCheck(@Validated MemberVO memberVO,
			BindingResult bindingResult, HttpServletRequest request, ModelMap model) throws Exception {
		System.out.println("??"+ memberVO.getMemberId());
		
		if (bindingResult.hasErrors()) {
			
			model.addAttribute("isCheck", "N");
			return "main/registerMember";

		} else {
			
			return "forward:/registerMemberInfo.do";
		}
	}
	
	@RequestMapping(value = "termsOfRegisterView.do")
	public String termsOfRegisterView(ModelMap model) throws Exception {
		
		return "main/termsOfRegister";
	}
	
	@RequestMapping(value = "registerMemberView.do")
	public String registerMemberView(ModelMap model, MemberVO memberVO) throws Exception {
		
		return "main/registerMember";
	}
	
	@RequestMapping(value = "registerMemberInfo.do")
	public String registerMemberInfo(ModelMap model, MemberVO memberVO, RedirectAttributes redirectAttributes) throws Exception {
		
		memberService.insertLibroMemberInfo(memberVO);

	    redirectAttributes.addFlashAttribute("isCheck", "Y");
		
		return "redirect:/loginView.do";
	}
	
	@RequestMapping(value = "checkDuplId.do")
	public void checkDuplId(HttpServletResponse response,  @RequestParam String checkId) throws Exception{

		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		out = response.getWriter();
        try {
        	
        	int cntDuplId = memberService.selectDuplIdCnt(checkId);
        	out.print(cntDuplId);
        } catch (Exception e) {
        	
        	System.out.println(e);
        	
    		out.print("1");
        }
        
	}	

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "myProfile.do")
	public String myProfile(ModelMap model,HttpServletRequest request, @RequestParam String memberId) throws Exception {

		Map memberInfoMap = memberService.selectMemberInfoById(memberId);
		
		model.addAttribute("memberInfoMap", memberInfoMap);
		
		return "main/myProfile";
	}

	@RequestMapping(value = "changeMemberInfo.do")
	public String changeMemberInfo(ModelMap model,HttpServletRequest request, 
			@RequestParam HashMap<String,Object> memberInfoMap, RedirectAttributes redirectAttributes) throws Exception {

		request.getSession().setAttribute("loginVO", null);

		request.getSession().setAttribute("notification", null);
		request.getSession().setAttribute("notificationCnt", 0);

		
		memberService.updateMemberInfo(memberInfoMap);
		
		redirectAttributes.addFlashAttribute("isChangeMemberInfo", "Y");

		return "redirect:/loginView.do";
	}
}
