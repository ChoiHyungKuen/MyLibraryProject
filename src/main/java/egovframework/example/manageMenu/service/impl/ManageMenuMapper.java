package egovframework.example.manageMenu.service.impl;
import java.util.List;
import java.util.Map;
import egovframework.example.manageMenu.service.ManageMenuVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("manageMenuMapper")
public interface ManageMenuMapper {

	List<EgovMap> selectManageMenuList(ManageMenuVO manageMenuVO) throws Exception;

	EgovMap selectManageMenuListCnt(ManageMenuVO manageMenuVO) throws Exception;

	void insertManageMenuJqGridList(Map<String, Object> param) throws Exception;

	void updateManageMenuJqGridList(Map<String, Object> param) throws Exception;

	void deleteManageMenuJqGridList(Map<String, Object> param) throws Exception;
}
