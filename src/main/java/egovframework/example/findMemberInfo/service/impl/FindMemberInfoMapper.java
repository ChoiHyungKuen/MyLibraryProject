package egovframework.example.findMemberInfo.service.impl;

import java.util.HashMap;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("findMemberInfoMapper")
public interface FindMemberInfoMapper {

	String selectMemberIdByEmail(HashMap<String, Object> findEmailMap) throws Exception;

	@SuppressWarnings("rawtypes")
	Map selectEmailInfoById(String findMemberId) throws Exception;

	void updateMemberInfo(HashMap<String, Object> changeMemberInfoMap) throws Exception;


}
