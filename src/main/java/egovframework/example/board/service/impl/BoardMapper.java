package egovframework.example.board.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.example.board.service.BoardPagingVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;
@Mapper("boardMapper")
public interface BoardMapper {

	List<?> selectBoardList() throws Exception;

	List<?> selectRecentBoardList() throws Exception;

	@SuppressWarnings("rawtypes") 
	List<Map> selectPagingList(BoardPagingVO boardPagingVO) throws Exception;

	EgovMap selectPagingListCnt(BoardPagingVO boardPagingVO) throws Exception;

	void insertBoardItemInfo(HashMap<String, Object> boardItemInfoMap) throws Exception;

	void updateBoardItemInfo(HashMap<String, Object> boardItemInfoMap) throws Exception;

	void deleteBoardItemInfo(HashMap<String, Object> boardItemInfoMap) throws Exception;

}
