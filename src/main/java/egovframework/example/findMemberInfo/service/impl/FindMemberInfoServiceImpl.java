package egovframework.example.findMemberInfo.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import egovframework.example.cmmn.EgovFileScrty;
import egovframework.example.findMemberInfo.service.FindMemberInfoService;

@Service("findMemberInfoService")
public class FindMemberInfoServiceImpl implements FindMemberInfoService {

	@Resource(name = "findMemberInfoMapper")
	private FindMemberInfoMapper findMemberInfoMapper;

	private JavaMailSender javaMailSender;
 
    public void setJavaMailSender(JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }
 
    @Override
    public boolean send(String subject, String text, String from, String to) {
    	
        MimeMessage message = javaMailSender.createMimeMessage();
 
        try {
            // org.springframework.mail.javamail.MimeMessageHelper
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setSubject(subject);
            helper.setText(text, true);
            helper.setFrom(from);
            helper.setTo(to);
 
            javaMailSender.send(message);
            return true;
        } catch (MessagingException e) {
        	System.out.println(e+"ㄴㄴ");
        }
        return false;
    }

	@Override
	public String selectMemberIdByEmail(HashMap<String, Object> findEmailMap) throws Exception {
		
		return findMemberInfoMapper.selectMemberIdByEmail(findEmailMap);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public Map selectEmailInfoById(String findMemberId) throws Exception {
		return findMemberInfoMapper.selectEmailInfoById(findMemberId);
	}

	@Override
	public void updateMemberInfo(HashMap<String, Object> changeMemberInfoMap) throws Exception {
		
		String password = EgovFileScrty.encryptPassword((String)changeMemberInfoMap.get("changePw"), 
				(String)changeMemberInfoMap.get("changeTargetId"));
		
		changeMemberInfoMap.put("password", password);
		
		findMemberInfoMapper.updateMemberInfo(changeMemberInfoMap);
	}
}
