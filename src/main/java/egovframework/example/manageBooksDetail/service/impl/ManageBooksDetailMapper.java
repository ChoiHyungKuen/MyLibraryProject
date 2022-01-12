package egovframework.example.manageBooksDetail.service.impl;
import java.util.List;
import java.util.Map;

import egovframework.example.manageBooksDetail.service.ManageBooksDetailVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("manageBooksDetailMapper")
public interface ManageBooksDetailMapper {

	List<EgovMap> selectManageBooksDetailList(ManageBooksDetailVO ManageBooksDetailVO) throws Exception;

	EgovMap selectManageBooksDetailListCnt(ManageBooksDetailVO ManageBooksDetailVO) throws Exception;

	void insertManageBooksDetailJqGridList(Map<String, Object> param) throws Exception;

	void updateManageBooksDetailJqGridList(Map<String, Object> param) throws Exception;

	void deleteManageBooksDetailJqGridList(Map<String, Object> param) throws Exception;
}
