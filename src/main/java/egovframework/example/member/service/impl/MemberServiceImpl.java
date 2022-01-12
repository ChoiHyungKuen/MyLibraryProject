package egovframework.example.member.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.cmmn.EgovFileScrty;
import egovframework.example.member.service.MemberService;
import egovframework.example.member.service.MemberVO;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("memberService")
public class MemberServiceImpl implements MemberService {

	@Resource(name="egovUsrCnfrmIdGnrService")
	private EgovIdGnrService egovIdGnrService;
	
	@Resource(name="memberMapper")
	private MemberMapper memberMapper;
	
	@Override
	public void insertLibroMemberInfo(MemberVO memberVO) throws Exception {

		String uniqId = egovIdGnrService.getNextStringId();
		
		memberVO.setUniqId(uniqId);
		
		String password = EgovFileScrty.encryptPassword(memberVO.getPassword(), memberVO.getMemberId());
		
		memberVO.setPassword(password);
		
		memberMapper.insertLibroMemberInfo(memberVO);
	}

	@Override
	public int selectDuplIdCnt(String checkId) throws Exception {
		
		return memberMapper.selectDuplIdCnt(checkId);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public Map selectMemberInfoById(String memberId) throws Exception {
		
		return memberMapper.selectMemberInfoById(memberId);
	}

	@Override
	public void updateMemberInfo(HashMap<String, Object> memberInfoMap) throws Exception {
		
		
		String password = EgovFileScrty.encryptPassword((String)memberInfoMap.get("password"), (String)memberInfoMap.get("changeMemberId"));
		System.out.println(password);		
		memberInfoMap.put("password", password);
		
		memberMapper.updateMemberInfo(memberInfoMap);
	}
}
