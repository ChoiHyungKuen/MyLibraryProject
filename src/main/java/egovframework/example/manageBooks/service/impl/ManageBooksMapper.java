package egovframework.example.manageBooks.service.impl;
import java.util.List;
import java.util.Map;

import egovframework.example.manageBooks.service.ManageBooksVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("manageBooksMapper")
public interface ManageBooksMapper {

	List<EgovMap> selectManageBooksList(ManageBooksVO manageBooksVO) throws Exception;

	EgovMap selectManageBooksListCnt(ManageBooksVO manageBooksVO) throws Exception;

	void insertManageBooksJqGridList(Map<String, Object> param) throws Exception;

	void updateManageBooksJqGridList(Map<String, Object> param) throws Exception;

	void deleteManageBooksJqGridList(Map<String, Object> param) throws Exception;

	void insertBookInfo(ManageBooksVO manageBooksVO) throws Exception;

	void insertBookInfoDetail(ManageBooksVO returnVO) throws Exception;
}
