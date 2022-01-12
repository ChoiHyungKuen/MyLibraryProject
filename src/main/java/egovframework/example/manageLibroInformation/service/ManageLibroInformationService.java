package egovframework.example.manageLibroInformation.service;

import java.util.List;

import org.json.JSONArray;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface ManageLibroInformationService {

	List<EgovMap> selectManageLibroInformationList(ManageLibroInformationVO manageMenuVO) throws Exception;

	EgovMap selectManageLibroInformationListCnt(ManageLibroInformationVO manageMenuVO) throws Exception;

	void saveJqGridTx(JSONArray jsonArray) throws Exception;

}
