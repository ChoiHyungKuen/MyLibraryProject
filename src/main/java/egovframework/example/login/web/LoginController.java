package egovframework.example.login.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.example.cmmn.EgovMessageSource;
import egovframework.example.cmmn.EgovUserDetailsHelper;
import egovframework.example.cmmn.service.Globals;
import egovframework.example.login.service.LoginService;
import egovframework.example.login.service.LoginVO;

@Controller
public class LoginController {

	@Resource(name = "loginService")
	private LoginService loginService;

	@Resource(name = "egovMessageSource")
	private EgovMessageSource egovMessageSource;
	
	/** log */
	private static final Logger LOGGER = LoggerFactory.getLogger(LoginController.class);
	

	@RequestMapping(value="/denied.do")
	public String accessDenied(LoginVO loginVO) throws Exception {
	     
	      return "main/denied";
	}
	@RequestMapping(value="/loginView.do")
	public String loginView(LoginVO loginVO) throws Exception {
	     
	      return "main/login";
	}


	@RequestMapping(value="/loginAdminView.do")
	public String loginAdminView(LoginVO loginVO) throws Exception {
	     
	      return "main/loginAdmin";
	}
	
	@RequestMapping(value = "actionLogin.do")
	public String actionLogin(LoginVO loginVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		// 회원인지 아이디로 검색
		int isLibroMember = loginService.isLibroMemberById(loginVO.getId());
		
		if(isLibroMember == 0)	{ // 아이디없으면 회원이 아니기때문에 아이디 확인하라고 메시지를 보낸다.
			
			model.addAttribute("isLogin", "N");
			model.addAttribute("message", "아이디가 존재하지 않습니다. 회원가입 먼저 해주세요.");
			
			return "main/login";
		}
		
		LoginVO resultVO = loginService.actionLogin(loginVO);
		
		if(resultVO !=null && resultVO.getId() != null && !resultVO.getId().equals("")) {
			
			request.getSession().setAttribute("loginVO", resultVO);

			return "redirect:/actionMain.do";
		} else {

			model.addAttribute("isLogin", "N");
			model.addAttribute("message", "비밀번호가 틀리셨습니다. 다시 한 번 확인해주세요.");
			
			return "main/login";
		}
	}
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "actionMain.do")
	public String actionMain(ModelMap model, HttpServletRequest request) throws Exception {
		
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if(!isAuthenticated) {
			
			model.addAttribute("message", "로그인에 실패했습니다.(인증실패)");
			
			return "main/login";
		}
		// 인증되면 인증된 로그인 된 정보를 LoginVO로 준다. EgovUserDetailsHelper는 LoginVO로 하는 것을 강제로 지정하고 있다.
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		// LOGGER는 보안 권고 사항이다. 누가 들어왔는지 알아야 한다. (보안)
		LOGGER.debug("User Id : {}", user.getId());
		// 메인페이지 같이 변하지 않는 것은 Globas에 저장하고 불러온다.
		String main_page = Globals.MAIN_PAGE;
		LOGGER.debug("Globals.MAIN_PAGE >  " + Globals.MAIN_PAGE);
		LOGGER.debug("main_page > {}" + main_page);
		
		model.addAttribute("isLogin", "Y");
		model.addAttribute("message", "로그인 되었습니다.");
		
		List<Map> notification = loginService.selectNotification(user.getId());
		
		int notificationCnt = notification.size();
		
		request.getSession().setAttribute("notification", notification);
		request.getSession().setAttribute("notificationCnt", notificationCnt);
		
		return "main/login";
	}

	@RequestMapping(value = "logout.do")
	public String logoutGo(HttpServletRequest request, ModelMap model) throws Exception {
		
		request.getSession().setAttribute("loginVO", null);

		request.getSession().setAttribute("notification", null);
		request.getSession().setAttribute("notificationCnt", 0);

		return "redirect:/main.do";
	}
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "removeNotification.do")
	public String removeNotification(HttpServletRequest request, @RequestParam String notificationId, 
			@RequestParam String memberId, RedirectAttributes redirectAttributes, ModelMap model) throws Exception {
		
		loginService.deleteNotification(notificationId);

		List<Map> notification = loginService.selectNotification(memberId);
		
		int notificationCnt = notification.size();
		
		redirectAttributes.addFlashAttribute("notification", notification);
		redirectAttributes.addFlashAttribute("notificationCnt", notificationCnt);
		redirectAttributes.addFlashAttribute("isCheck", "Y");
		redirectAttributes.addFlashAttribute("message", "메시지를 제거했습니다.");	
		

		request.getSession().setAttribute("notification", notification);
		request.getSession().setAttribute("notificationCnt", notificationCnt);
		
		return "redirect:/notificationView.do";
	}
}
