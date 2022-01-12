package egovframework.example.manageInfoBoard.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import egovframework.example.cmmn.JsonUtil;
import egovframework.example.manageInfoBoard.service.ManageInfoBoardVO;
import egovframework.example.manageInfoBoard.service.ManageInfoBoardService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("manageInfoBoardService")
public class ManageInfoBoardServiceImpl implements ManageInfoBoardService {

	@Resource(name = "manageInfoBoardMapper")
	private ManageInfoBoardMapper manageInfoBoardMapper;

	@Override
	public List<EgovMap> selectManageInfoBoardList(ManageInfoBoardVO manageInfoBoardVO) throws Exception {
		return manageInfoBoardMapper.selectManageInfoBoardList(manageInfoBoardVO);
	}

	@Override
	public EgovMap selectManageInfoBoardListCnt(ManageInfoBoardVO manageInfoBoardVO) throws Exception {
		
		return manageInfoBoardMapper.selectManageInfoBoardListCnt(manageInfoBoardVO);
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

					manageInfoBoardMapper.insertManageInfoBoardJqGridList(param);
				} else if ("U".equals(param.get("editType"))) {

					manageInfoBoardMapper.updateManageInfoBoardJqGridList(param);
				} else if ("D".equals(param.get("editType"))) {

					manageInfoBoardMapper.deleteManageInfoBoardJqGridList(param);
				}
			}
		} catch (Exception ex) {

			throw ex;
		}

	}
}
