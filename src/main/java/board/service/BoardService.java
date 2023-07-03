package board.service;

import board.vo.BoardVo;
import board.vo.PagingVo;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface BoardService {
    List<BoardVo> selectBoardList(PagingVo pagingVo) throws Exception;

    void insertBoard(BoardVo boardVo) throws Exception;

    BoardVo selectBoardDetail(int boardIdx) throws Exception;

    void updateBoard(BoardVo boardVo) throws Exception;

    void deleteBoard(int boardIdx) throws Exception;

    int getTotalRows(int bgno);

    PagingVo paging(String tempPage) throws Exception;
}
