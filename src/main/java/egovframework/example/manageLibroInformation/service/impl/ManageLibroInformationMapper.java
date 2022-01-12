package egovframework.example.manageLibroInformation.service.impl;
import java.util.List;
import java.util.Map;

import egovframework.example.manageLibroInformation.service.ManageLibroInformationVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("manageLibroInformationMapper")
public interface ManageLibroInformationMapper {

	List<EgovMap> selectManageLibroInformationList(ManageLibroInformationVO manageLibroInformationVO) throws Exception;

	EgovMap selectManageLibroInformationListCnt(ManageLibroInformationVO manageLibroInformationVO) throws Exception;

	void insertManageLibroInformationJqGridList(Map<String, Object> param) throws Exception;

	void updateManageLibroInformationJqGridList(Map<String, Object> param) throws Exception;

	void deleteManageLibroInformationJqGridList(Map<String, Object> param) throws Exception;
}
