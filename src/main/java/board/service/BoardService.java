package board.service;

import board.vo.BoardVo;

import java.util.List;

public interface BoardService {
    List<BoardVo> selectBoardList() throws Exception;

    void insertBoard(BoardVo boardVo) throws Exception;

    BoardVo selectBoardDetail(int boardIdx) throws Exception;

    void updateBoard(BoardVo boardVo) throws Exception;

    void deleteBoard(BoardVo boardVo) throws Exception;
}
