package egovframework.example.manageBooksDetail.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import egovframework.example.cmmn.JsonUtil;
import egovframework.example.manageBooksDetail.service.ManageBooksDetailService;
import egovframework.example.manageBooksDetail.service.ManageBooksDetailVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("manageBooksDetailService")
public class ManageBooksDetailServiceImpl implements ManageBooksDetailService {

	@Resource(name = "manageBooksDetailMapper")
	private ManageBooksDetailMapper manageBooksDetailMapper;

	@Override
	public List<EgovMap> selectManageBooksDetailList(ManageBooksDetailVO manageBooksDetailVO) throws Exception {
		return manageBooksDetailMapper.selectManageBooksDetailList(manageBooksDetailVO);
	}

	@Override
	public EgovMap selectManageBooksDetailListCnt(ManageBooksDetailVO manageBooksDetailVO) throws Exception {
		
		return manageBooksDetailMapper.selectManageBooksDetailListCnt(manageBooksDetailVO);
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

					manageBooksDetailMapper.insertManageBooksDetailJqGridList(param);
				} else if ("U".equals(param.get("editType"))) {

					manageBooksDetailMapper.updateManageBooksDetailJqGridList(param);
				} else if ("D".equals(param.get("editType"))) {

					manageBooksDetailMapper.deleteManageBooksDetailJqGridList(param);
				}
			}
		} catch (Exception ex) {

			throw ex;
		}

	}
}
