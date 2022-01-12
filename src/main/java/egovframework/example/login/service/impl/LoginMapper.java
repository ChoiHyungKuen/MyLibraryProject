package egovframework.example.login.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.security.core.userdetails.UserDetails;

import egovframework.example.login.service.LoginVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("loginMapper")
public interface LoginMapper {

	LoginVO actionLogin(LoginVO loginVO) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectNotification(String userId) throws Exception;

	UserDetails getUserInfoById(String id) throws Exception;

	List<String> getAuthoritiesById(String id) throws Exception;

	void deleteNotification(String notificationId) throws Exception;
	
	int selectIsMemberById(String memberId) throws Exception;

}
