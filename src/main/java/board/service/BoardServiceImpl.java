package board.service;

import board.vo.BoardVo;
import board.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardServiceImpl implements BoardService{

    @Autowired
    private BoardMapper boardMapper;

    @Override
    public List<BoardVo> selectBoardList() throws Exception { // 게시판 목록 출력
        return boardMapper.selectBoardList();
    }

    @Override
    public void insertBoard(BoardVo boardVo) throws Exception { // 글쓰기
        boardMapper.insertBoard(boardVo);
    }

    @Override
    public BoardVo selectBoardDetail(int boardIdx) throws Exception { // 글 상세보기
        boardMapper.updateHitCount(boardIdx);

        BoardVo boardVo = boardMapper.selectBoardDetail(boardIdx);

        return boardVo;
    }

    @Override
    public void updateBoard(BoardVo boardVo) throws Exception { // 글 수정
        boardMapper.updateBoard(boardVo);
    }

    @Override
    public void deleteBoard(BoardVo boardVo) throws Exception{ // 글 삭제
        boardMapper.deleteBoard(boardVo);
    }
}
