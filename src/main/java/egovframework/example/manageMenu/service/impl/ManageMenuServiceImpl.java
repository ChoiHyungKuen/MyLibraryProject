package egovframework.example.manageMenu.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import egovframework.example.cmmn.JsonUtil;
import egovframework.example.manageMenu.service.ManageMenuService;
import egovframework.example.manageMenu.service.ManageMenuVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("manageMenuService")
public class ManageMenuServiceImpl implements ManageMenuService {

	@Resource(name = "manageMenuMapper")
	private ManageMenuMapper manageMenuMapper;

	@Override
	public List<EgovMap> selectManageMenuList(ManageMenuVO manageMenuVO) throws Exception {
		return manageMenuMapper.selectManageMenuList(manageMenuVO);
	}

	@Override
	public EgovMap selectManageMenuListCnt(ManageMenuVO manageMenuVO) throws Exception {
		
		return manageMenuMapper.selectManageMenuListCnt(manageMenuVO);
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

					manageMenuMapper.insertManageMenuJqGridList(param);
				} else if ("U".equals(param.get("editType"))) {

					manageMenuMapper.updateManageMenuJqGridList(param);
				} else if ("D".equals(param.get("editType"))) {

					manageMenuMapper.deleteManageMenuJqGridList(param);
				}
			}
		} catch (Exception ex) {

			throw ex;
		}

	}
}
