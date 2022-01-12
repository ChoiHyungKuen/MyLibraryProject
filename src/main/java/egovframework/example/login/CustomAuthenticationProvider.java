package egovframework.example.login;

import java.util.ArrayList;
import java.util.Collection;

import javax.annotation.Resource;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import egovframework.example.cmmn.EgovFileScrty;
import egovframework.example.login.service.LoginService;
import egovframework.example.login.service.LoginVO;

@Component
public class CustomAuthenticationProvider implements AuthenticationProvider {

	@Resource(name = "loginService")
	private LoginService loginService;

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String id = authentication.getName(); 
		String password = (String) authentication.getCredentials();
		LoginVO loginVO = new LoginVO() ;
		Collection<? extends GrantedAuthority> authorities= new ArrayList<GrantedAuthority>(); 


		try {
			loginVO = (LoginVO) loginService.loadUserByUsername(id)	;	
			
			authorities=loginVO.getAuthorities();
			
			String enpassword = EgovFileScrty.encryptPassword(password, id);
			
			if(!loginVO.getPassword().equals(enpassword)) {
				
				throw new BadCredentialsException("비밀번호가 일치하지 않습니다."); 

			}
/*
			Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
			
			if(!isAuthenticated) {

				throw new BadCredentialsException("인증되지 않습니다."); 
				//return "main/login";
			}		loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();*/
			// 인증되면 인증된 로그인 된 정보를 LoginVO로 준다. EgovUserDetailsHelper는 LoginVO로 하는 것을 강제로 지정하고 있다.
		} catch(BadCredentialsException e) {  
		
			throw new BadCredentialsException(e.getMessage());
		} catch(UsernameNotFoundException e) { 
		
			throw new UsernameNotFoundException(e.getMessage()); 
		} catch (Exception e) {
			
			System.out.println(e);
		}
		
		return new UsernamePasswordAuthenticationToken(loginVO, password, authorities);

	}

	@Override
	public boolean supports(Class<?> authentication) {

		return true;
	}
}
