package egovframework.example.login;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import egovframework.example.login.service.LoginVO;
import egovframework.rte.fdl.security.userdetails.EgovUserDetails;
import egovframework.rte.fdl.security.userdetails.jdbc.EgovUsersByUsernameMapping;

public class EgovUserDetailsMapping extends EgovUsersByUsernameMapping {
	public EgovUserDetailsMapping(DataSource ds, String usersByUsernameQuery) {
		super(ds, usersByUsernameQuery);
	}
 
	@Override
	protected EgovUserDetails mapRow(ResultSet rs, int rownum) throws SQLException {
		String userid = rs.getString("id");
		String password = rs.getString("password");
		boolean enabled = rs.getBoolean("enabled");
 
		/*String username = rs.getString("user_name");
		String birthDay = rs.getString("birth_day");
		String ssn = rs.getString("ssn");*/
 
		LoginVO userVO = new LoginVO();
		userVO.setId(userid);
		userVO.setPassword(password);/*
		userVO.setUserName(username);
		userVO.setBirthDay(birthDay);
		userVO.setSsn(ssn);
 */
		return new EgovUserDetails(userid, password, enabled, userVO);
	}
}