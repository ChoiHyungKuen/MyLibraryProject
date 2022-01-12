package egovframework.example.member.service.impl;

import java.util.HashMap;
import java.util.Map;

import egovframework.example.member.service.MemberVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("memberMapper")
public interface MemberMapper {

	void insertLibroMemberInfo(MemberVO memberVO) throws Exception;

	int selectDuplIdCnt(String checkId) throws Exception;

	@SuppressWarnings("rawtypes")
	Map selectMemberInfoById(String memberId) throws Exception;

	void updateMemberInfo(HashMap<String, Object> memberInfoMap) throws Exception;

}
