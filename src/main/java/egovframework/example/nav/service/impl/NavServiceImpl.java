package egovframework.example.nav.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.main.service.impl.MainMapper;
import egovframework.example.nav.service.NavService;

@Service("navService")
public class NavServiceImpl implements NavService {
	
	@Resource(name="navMapper")
	private NavMapper navMapper;

	@Override
	public List<?> selectMainMenu() throws Exception {
		return navMapper.selectMainMenu();
	}

}
