package egovframework.example.findMemberInfo.service;

import java.util.HashMap;
import java.util.Map;

public interface FindMemberInfoService {

    /** 메일 전송 블로그 참조
     *  subject 제목
     *  text 내용
     *  from 보내는 메일 주소
     *  to 받는 메일 주소
     *   **/
    public boolean send(String subject, String text, String from, String to) throws Exception;
	
	String selectMemberIdByEmail(HashMap<String, Object> findEmailMap) throws Exception;

	@SuppressWarnings("rawtypes")
	public Map selectEmailInfoById(String findMemberId) throws Exception;

	public void updateMemberInfo(HashMap<String, Object> changeMemberInfoMap) throws Exception;
}
