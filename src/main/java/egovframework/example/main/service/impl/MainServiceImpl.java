package egovframework.example.main.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.main.service.MainService;

@Service("mainService")
public class MainServiceImpl implements MainService {
	
	@Resource(name="mainMapper")
	private MainMapper mainMapper;
	
	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectLibroInfoDataList() throws Exception {
		
		return mainMapper.selectLibroInfoDataList();
	}

	@Override
	public int selectLibroBookCnt() throws Exception {
		
		return mainMapper.selectLibroBookCnt();
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectBestThreeBookList() throws Exception {
		
		return mainMapper.selectBestThreeBookList();
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectLibroInformationList() throws Exception {
		
		return mainMapper.selectLibroInformationList();
	}

}
