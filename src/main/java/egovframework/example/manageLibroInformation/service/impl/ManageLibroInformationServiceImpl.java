package egovframework.example.manageLibroInformation.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import egovframework.example.cmmn.JsonUtil;
import egovframework.example.manageLibroInformation.service.ManageLibroInformationService;
import egovframework.example.manageLibroInformation.service.ManageLibroInformationVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("manageLibroInformationService")
public class ManageLibroInformationServiceImpl implements ManageLibroInformationService {

	@Resource(name = "manageLibroInformationMapper")
	private ManageLibroInformationMapper manageLibroInformationMapper;

	@Override
	public List<EgovMap> selectManageLibroInformationList(ManageLibroInformationVO manageLibroInformationVO) throws Exception {
		return manageLibroInformationMapper.selectManageLibroInformationList(manageLibroInformationVO);
	}

	@Override
	public EgovMap selectManageLibroInformationListCnt(ManageLibroInformationVO manageLibroInformationVO) throws Exception {
		
		return manageLibroInformationMapper.selectManageLibroInformationListCnt(manageLibroInformationVO);
	}

	@Override
	public void saveJqGridTx(JSONArray jsonArray) throws Exception {

		int iLength1 = jsonArray.length();

		try {

			for (int i = 0; i < iLength1; i++) {

				JSONObject jsonObject = jsonArray.getJSONObject(i);

				Map<String, Object> param = JsonUtil.JsonToMap(jsonObject
						.toString());
				
				if ("I".equals(param.get("editType"))) {

					manageLibroInformationMapper.insertManageLibroInformationJqGridList(param);
				} else if ("U".equals(param.get("editType"))) {

					manageLibroInformationMapper.updateManageLibroInformationJqGridList(param);
				} else if ("D".equals(param.get("editType"))) {

					manageLibroInformationMapper.deleteManageLibroInformationJqGridList(param);
				}
			}
		} catch (Exception ex) {

			throw ex;
		}

	}
}
