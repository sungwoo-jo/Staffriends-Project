package board.mapper;

import board.vo.BoardVo;
import board.vo.PagingVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface BoardMapper {
    List<BoardVo> selectBoardList(PagingVo pagingVo) throws Exception;

    void insertBoard(BoardVo boardVo) throws Exception;

    void updateHitCount(int boardIdx) throws Exception;

    BoardVo selectBoardDetail(int boardIdx) throws Exception;

    void updateBoard(BoardVo boardVo) throws Exception;

    void deleteBoard(int boardIdx) throws Exception;

    int getTotalRows(int bgno);
}
