package egovframework.example.manageBooks.service;

import java.util.List;
import java.util.Map;

import org.json.JSONArray;

import egovframework.example.manageMenu.service.ManageMenuVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface ManageBooksService {

	List<EgovMap> selectManageBooksList(ManageBooksVO manageBooksVO) throws Exception;

	EgovMap selectManageBooksListCnt(ManageBooksVO manageBooksVO) throws Exception;

	void saveJqGridTx(JSONArray jsonArray) throws Exception;
	
	void insertBookInfo(ManageBooksVO manageBooksVO) throws Exception;

}
