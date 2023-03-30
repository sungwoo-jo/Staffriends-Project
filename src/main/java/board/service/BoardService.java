package board.service;

import board.dto.BoardDto;

import java.util.List;

public interface BoardService {
    List<BoardDto> selectBoardList() throws Exception;

    void insertBoard(BoardDto boardDto) throws Exception;

    BoardDto selectBoardDetail(int boardIdx) throws Exception;

    void updateBoard(BoardDto boardDto) throws Exception;

    void deleteBoard(BoardDto boardDto) throws Exception;
}
