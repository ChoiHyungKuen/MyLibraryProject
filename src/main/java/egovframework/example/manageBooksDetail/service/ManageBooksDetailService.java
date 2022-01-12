package egovframework.example.manageBooksDetail.service;

import java.util.List;

import org.json.JSONArray;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface ManageBooksDetailService {

	List<EgovMap> selectManageBooksDetailList(ManageBooksDetailVO ManageBooksDetailVO) throws Exception;

	EgovMap selectManageBooksDetailListCnt(ManageBooksDetailVO ManageBooksDetailVO) throws Exception;

	void saveJqGridTx(JSONArray jsonArray) throws Exception;

}
