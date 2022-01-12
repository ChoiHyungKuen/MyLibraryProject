package egovframework.example.main.service;

import java.util.List;
import java.util.Map;

public interface MainService {

	@SuppressWarnings("rawtypes")
	List<Map> selectLibroInfoDataList() throws Exception;

	int selectLibroBookCnt() throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectBestThreeBookList() throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectLibroInformationList() throws Exception;

}
