package egovframework.example.main.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("mainMapper")
public interface MainMapper {

	@SuppressWarnings("rawtypes")
	List<Map> selectLibroInfoDataList() throws Exception;

	int selectLibroBookCnt() throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectBestThreeBookList() throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectLibroInformationList() throws Exception;

}
