package board.service;

import board.vo.BoardVo;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface BoardService {
    List<BoardVo> selectBoardList(Map<String, Integer> map) throws Exception;

    void insertBoard(BoardVo boardVo) throws Exception;

    BoardVo selectBoardDetail(int boardIdx) throws Exception;

    void updateBoard(BoardVo boardVo) throws Exception;

    void deleteBoard(BoardVo boardVo) throws Exception;

    int getTotalRows();

    Map<String, Integer> paging(String tempPage) throws Exception;
}
