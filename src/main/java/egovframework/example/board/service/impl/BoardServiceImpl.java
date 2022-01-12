package egovframework.example.board.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.board.service.BoardPagingVO;
import egovframework.example.board.service.BoardService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("boardService")
public class BoardServiceImpl implements BoardService {
	@Resource(name="boardMapper")
	BoardMapper boardMapper;
	
	public List<?> selectBoardList() throws Exception {
		
		return boardMapper.selectBoardList();
	}

	@Override
	public List<?> selectRecentBoardList() throws Exception {
		
		return boardMapper.selectRecentBoardList();
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectPagingList(BoardPagingVO boardPagingVO) throws Exception {
		return boardMapper.selectPagingList(boardPagingVO);
	}

	@Override
	public EgovMap selectPagingListCnt(BoardPagingVO boardPagingVO) throws Exception {
		return boardMapper.selectPagingListCnt(boardPagingVO);
	}

	@Override
	public void saveBoardItemInfoTx(HashMap<String, Object> boardItemInfoMap) throws Exception {

		try {
			if ("I".equals(boardItemInfoMap.get("editType"))) {

				boardMapper.insertBoardItemInfo(boardItemInfoMap);
			} else if ("U".equals(boardItemInfoMap.get("editType"))) {

				boardMapper.updateBoardItemInfo(boardItemInfoMap);
			} else if ("D".equals(boardItemInfoMap.get("editType"))) {

				boardMapper.deleteBoardItemInfo(boardItemInfoMap);
			}
		} catch (Exception e) {

			throw e;
		}
	}

}
