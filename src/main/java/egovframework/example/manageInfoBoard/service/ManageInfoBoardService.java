package egovframework.example.manageInfoBoard.service;

import java.util.List;

import org.json.JSONArray;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface ManageInfoBoardService {

	List<EgovMap> selectManageInfoBoardList(ManageInfoBoardVO ManageInfoBoardVO) throws Exception;

	EgovMap selectManageInfoBoardListCnt(ManageInfoBoardVO ManageInfoBoardVO) throws Exception;

	void saveJqGridTx(JSONArray jsonArray) throws Exception;
	
}
