package board.service;

import board.dto.BoardDto;
import board.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardServiceImpl implements BoardService{

    @Autowired
    private BoardMapper boardMapper;

    @Override
    public List<BoardDto> selectBoardList() throws Exception { // 게시판 목록 출력
        return boardMapper.selectBoardList();
    }

    @Override
    public void insertBoard(BoardDto boardDto) throws Exception { // 글쓰기
        boardMapper.insertBoard(boardDto);
    }

    @Override
    public BoardDto selectBoardDetail(int boardIdx) throws Exception { // 글 상세보기
        boardMapper.updateHitCount(boardIdx);

        BoardDto boardDto = boardMapper.selectBoardDetail(boardIdx);

        return boardDto;
    }

    @Override
    public void updateBoard(BoardDto boardDto) throws Exception { // 글 수정
        boardMapper.updateBoard(boardDto);
    }

    @Override
    public void deleteBoard(BoardDto boardDto) throws Exception{ // 글 삭제
        boardMapper.deleteBoard(boardDto);
    }
}
