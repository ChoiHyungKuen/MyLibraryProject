package egovframework.example.member.service;

import java.util.HashMap;
import java.util.Map;

public interface MemberService {

	void insertLibroMemberInfo(MemberVO memberVO) throws Exception;

	int selectDuplIdCnt(String checkId) throws Exception;

	@SuppressWarnings("rawtypes")
	Map selectMemberInfoById(String memberId) throws Exception;

	void updateMemberInfo(HashMap<String, Object> memberInfoMap) throws Exception;

}
