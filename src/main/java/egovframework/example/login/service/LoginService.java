package egovframework.example.login.service;

import java.util.List;
import java.util.Map;

import org.springframework.security.core.userdetails.UserDetailsService;

public interface LoginService extends UserDetailsService{

	LoginVO actionLogin(LoginVO loginVO) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectNotification(String userId) throws Exception;

	void deleteNotification(String notificationId) throws Exception;

	int isLibroMemberById(String memberId) throws Exception;

}
