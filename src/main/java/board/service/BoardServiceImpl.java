package board.service;

import board.vo.BoardVo;
import board.mapper.BoardMapper;
import board.vo.PagingVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
    private BoardMapper boardMapper;

    @Override
    public List<BoardVo> selectBoardList(PagingVo pagingVo) throws Exception { // 게시판 목록 출력
        return boardMapper.selectBoardList(pagingVo);
    }

    @Override
    public void insertBoard(BoardVo boardVo) throws Exception { // 글쓰기
        boardMapper.insertBoard(boardVo);
    }

    @Override
    public BoardVo selectBoardDetail(int boardIdx) throws Exception { // 글 상세보기(조회수 증가)
        boardMapper.updateHitCount(boardIdx);
        return boardMapper.selectBoardDetail(boardIdx);
    }

    @Override
    public void updateBoard(BoardVo boardVo) throws Exception { // 글 수정
        boardMapper.updateBoard(boardVo);
    }

    @Override
    public void deleteBoard(int boardIdx) throws Exception{ // 글 삭제
        boardMapper.deleteBoard(boardIdx);
    }

    @Override
    public int getTotalRows(int bgno) { // 전체 행 조회
        return boardMapper.getTotalRows(bgno);
    }

    @Override
    public PagingVo paging(String tempPage, int bgno) throws Exception {
        PagingVo pagingVo = new PagingVo();
        pagingVo.setBgno(bgno);
        pagingVo.setTotalRows(getTotalRows(bgno));
        try {
            pagingVo.setCPage(Integer.parseInt(tempPage)); // 파라미터로 전달받은 페이지 번호를 현재 페이지에 변환하여 담아줌
        } catch (NumberFormatException e) { // 에러 발생 시(숫자가 아닌 문자가 들어오는 경우) 1로 설정
            pagingVo.setCPage(1);
        }
        // 필요한 총 페이지의 개수는 데이터의 개수를 보여줄 게시글의 개수로 나누어 딱맞으면 몫 만큼, 초과하면 +1개의 페이지를 더 생성(최소 1개의 페이지 생성)
        if (pagingVo.getTotalRows() % pagingVo.getPageLength() == 0) {
            pagingVo.setTotalPages(pagingVo.getTotalRows() / pagingVo.getPageLength());
        } else {
            pagingVo.setTotalPages((pagingVo.getTotalRows() / pagingVo.getPageLength()) + 1);
        }

        if (pagingVo.getCPage() > pagingVo.getTotalPages() || pagingVo.getCPage() <= 0) { // 페이지가 최소 또는 최대 페이지 범위를 벗어난 경우 1로 설정(반드시 총 페이지의 개수가 구해진 후 연산)
            pagingVo.setCPage(1);
        }

        // 페이지 처음과 끝을 지정하는 부분
        // 현재 위치한 페이지 블록의 순번(1~10: 1번째, 11~20: 2번째, 21~30: 3번째)
        if(pagingVo.getCPage() % pagingVo.getPageLength() == 0) {
            pagingVo.setCurrentBlock(pagingVo.getCPage() / pagingVo.getPageLength());
        } else {
            pagingVo.setCurrentBlock((pagingVo.getCPage() / pagingVo.getPageLength()) + 1);
        }

        pagingVo.setStartPage((pagingVo.getCurrentBlock() - 1) * pagingVo.getPageLength() + 1); // 페이지 블럭의 시작 번호 구하기(1~10은 1로 시작, 11~20은 11로 시작, 21~30은 21로 시작)
        pagingVo.setEndPage(pagingVo.getCurrentBlock() * pagingVo.getPageLength()); // 페이지 블럭의 마지막 번호 구하기(1~10의 끝 번호는 10, 11~20의 끝 번호는 20, 21~30의 끝 번호는 30)

        // 총 페이지 갯수보다 endPage가 높으면 endPage를 총 페이지 갯수로 지정(불필요한 페이지 번호를 생성하지 않기 위함)
        if (pagingVo.getEndPage() > pagingVo.getTotalPages()) {
            pagingVo.setEndPage(pagingVo.getTotalPages());
        }

        pagingVo.setOffsetStartNumber((pagingVo.getCPage() - 1) * pagingVo.getPageLength()); // 각 페이지의 첫 번째 게시글의 번호를 구하기 : (현재 페이지 - 1) * 보여줄 게시글의 갯수(ex. 1페이지=0~9, 2페이지=10~19, 3페이지=20~29)

        // 첫 번째 게시글의 번호와 보여줄 게시글의 갯수를 가지고 게시글 목록을 조회(총 pageLength개의 데이터를 가져오며, 현재 페이지 - 1 * pageLength에 해당하는 번호의 게시글들이 조회됨)

        return pagingVo;
    }
}
