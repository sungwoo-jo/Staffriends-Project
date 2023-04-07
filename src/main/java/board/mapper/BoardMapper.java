package board.mapper;

import board.vo.BoardVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {
    List<BoardVo> selectBoardList() throws Exception;

    void insertBoard(BoardVo boardVo) throws Exception;

    void updateHitCount(int boardIdx) throws Exception;

    BoardVo selectBoardDetail(int boardIdx) throws Exception;

    void updateBoard(BoardVo boardVo) throws Exception;

    void deleteBoard(BoardVo boardVo) throws Exception;

    int getTotalRows(BoardVo boardVo);
}
