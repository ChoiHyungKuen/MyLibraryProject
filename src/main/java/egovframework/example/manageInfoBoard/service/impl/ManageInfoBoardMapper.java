package egovframework.example.manageInfoBoard.service.impl;
import java.util.List;
import java.util.Map;

import egovframework.example.manageInfoBoard.service.ManageInfoBoardVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("manageInfoBoardMapper")
public interface ManageInfoBoardMapper {

	List<EgovMap> selectManageInfoBoardList(ManageInfoBoardVO manageInfoBoardVO) throws Exception;

	EgovMap selectManageInfoBoardListCnt(ManageInfoBoardVO manageInfoBoardVO) throws Exception;

	void insertManageInfoBoardJqGridList(Map<String, Object> param) throws Exception;

	void updateManageInfoBoardJqGridList(Map<String, Object> param) throws Exception;

	void deleteManageInfoBoardJqGridList(Map<String, Object> param) throws Exception;

}
