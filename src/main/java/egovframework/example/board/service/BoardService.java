package egovframework.example.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface BoardService {

	List<?> selectBoardList() throws Exception;

	List<?> selectRecentBoardList() throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectPagingList(BoardPagingVO boardPagingVO) throws Exception;

	EgovMap selectPagingListCnt(BoardPagingVO boardPagingVO) throws Exception;

	void saveBoardItemInfoTx(HashMap<String, Object> boardItemInfoMap) throws Exception;

}
