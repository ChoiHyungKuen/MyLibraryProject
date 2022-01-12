package egovframework.example.manageMenu.service;

import java.util.List;

import org.json.JSONArray;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface ManageMenuService {

	List<EgovMap> selectManageMenuList(ManageMenuVO manageMenuVO) throws Exception;

	EgovMap selectManageMenuListCnt(ManageMenuVO manageMenuVO) throws Exception;

	void saveJqGridTx(JSONArray jsonArray) throws Exception;

}
