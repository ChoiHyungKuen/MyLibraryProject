package egovframework.example.manageBooks.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import egovframework.example.cmmn.JsonUtil;
import egovframework.example.manageBooks.service.ManageBooksService;
import egovframework.example.manageBooks.service.ManageBooksVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("manageBooksService")
public class ManageBooksServiceImpl implements ManageBooksService {

	@Resource(name = "manageBooksMapper")
	private ManageBooksMapper manageBooksMapper;

	@Override
	public List<EgovMap> selectManageBooksList(ManageBooksVO manageBooksVO) throws Exception {
		return manageBooksMapper.selectManageBooksList(manageBooksVO);
	}

	@Override
	public EgovMap selectManageBooksListCnt(ManageBooksVO manageBooksVO) throws Exception {
		
		return manageBooksMapper.selectManageBooksListCnt(manageBooksVO);
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

					manageBooksMapper.insertManageBooksJqGridList(param);
				} else if ("U".equals(param.get("editType"))) {

					manageBooksMapper.updateManageBooksJqGridList(param);
				} else if ("D".equals(param.get("editType"))) {

					manageBooksMapper.deleteManageBooksJqGridList(param);
				}
			}
		} catch (Exception ex) {

			throw ex;
		}

	}

	public void insertBookInfo(ManageBooksVO manageBooksVO) throws Exception {
		/* 
		 * 책정보 추가한뒤 책의 자세한사항(청구기호, 상태 등)을 추가하기 위해 
		 * selectKey로 받은 id값을 알기위해 그 값이 저장된 VO를 받는다. 
		*/
		manageBooksMapper.insertBookInfo(manageBooksVO);
		// LIBRO_BOOKS의 id는 LIBRO_BOOKS_DETAIL의 BOOK_ID이다.(외래키), 여기서 설정해주고 LIBRO_BOOKS_DETAIL에 삽입하고 id는 덮어쓰기 한다.
		String id = manageBooksVO.getId();
		manageBooksVO.setBookId(id);
		System.out.println(manageBooksVO.getId());
		manageBooksMapper.insertBookInfoDetail(manageBooksVO);
	}
}
