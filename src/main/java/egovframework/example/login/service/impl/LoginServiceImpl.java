package egovframework.example.login.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import egovframework.example.cmmn.EgovFileScrty;
import egovframework.example.login.service.LoginService;
import egovframework.example.login.service.LoginVO;

@Service("loginService")
public class LoginServiceImpl implements LoginService {

	@Resource(name = "loginMapper")
	private LoginMapper loginMapper;

	@Override
	public LoginVO actionLogin(LoginVO loginVO) throws Exception {

		String enpassword = EgovFileScrty.encryptPassword(
				loginVO.getPassword(), loginVO.getId());
		loginVO.setPassword(enpassword);

		LoginVO loginVOG = loginMapper.actionLogin(loginVO);

		if (loginVOG != null && !loginVOG.getId().equals("")
				&& !loginVOG.getPassword().equals("")) {

			return loginVOG;
		} else {

			loginVOG = new LoginVO();
		}

		return loginVOG;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectNotification(String userId) throws Exception {
		return loginMapper.selectNotification(userId);
	}

	@Override
	public LoginVO loadUserByUsername(final String id) throws UsernameNotFoundException {
		LoginVO loginVO = new LoginVO();
		try {

			loginVO = (LoginVO) loginMapper.getUserInfoById(id);

			List<String> stringAuthorities = loginMapper.getAuthoritiesById(id);

			List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
			for (String authority : stringAuthorities) {
				authorities.add(new SimpleGrantedAuthority(authority));
			}

			loginVO.setAuthorities(authorities);
			System.out.println("권한 :" + authorities);

		} catch (Exception e) {

			System.out.println(e);

			if (loginVO == null) {
			
				throw new UsernameNotFoundException("접속자 정보를 찾을 수 없습니다.");
			}
		}

		return loginVO;
	}

	@Override
	public void deleteNotification(String notificationId) throws Exception {
		
		loginMapper.deleteNotification(notificationId);
	}

	@Override
	public int isLibroMemberById(String memberId) throws Exception {
		
		return loginMapper.selectIsMemberById(memberId);
	}
}
