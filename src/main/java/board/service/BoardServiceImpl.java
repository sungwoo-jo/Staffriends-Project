package board.service;

import board.vo.BoardVo;
import board.mapper.BoardMapper;
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
    public List<BoardVo> selectBoardList(Map<String, Integer> map) throws Exception { // 게시판 목록 출력
        return boardMapper.selectBoardList(map);
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
    public int getTotalRows() { // 전체 행 조회
        return boardMapper.getTotalRows();
    }

    @Override
    public Map<String, Integer> paging(String tempPage) throws Exception {
        Map<String, Integer> map = new HashMap<>();
        int cPage; // 현재 위치한 페이지의 번호
        int currentBlock; // 페이지 블록의 갯수
        int pageLength = 10; // 보여줄 게시글의 갯수
        int startPage; // 페이지 블록의 시작 번호
        int endPage; // 페이지 블록의 마지막 번호
        int totalPages; // 전체 페이지의 갯수
        int start; // SQL 쿼리의 LIMIT에 들어갈 변수



//        // cPage(현재 위치한 페이지의 번호 정하기)
//        if (tempPage == null || tempPage.length() == 0 || tempPage.equals("0")) { // 파라미터로 전달받은 페이지 정보가 없거나 0이면 1페이지로 이동
//            cPage = 1;
//        }

        try {
            cPage = Integer.parseInt(tempPage); // 파라미터로 전달받은 페이지 번호를 현재 페이지에 변환하여 담아줌
        } catch (NumberFormatException e) { // 에러 발생 시(숫자가 아닌 문자가 들어오는 경우) 1로 설정
            cPage = 1;
        }

        int totalRows = getTotalRows(); // 전체 게시글의 갯수

        totalPages = totalRows % pageLength == 0 ? totalRows / pageLength : (totalRows / pageLength) + 1; // 필요한 총 페이지의 개수는 데이터의 개수를 보여줄 게시글의 개수로 나누어 딱맞으면 0, 초과하면 1개의 페이지를 더 생성
        if (totalPages == 0) { // 현재 게시글 데이터의 수가 페이지 최소 단위보다 적은 경우 최소 1개의 페이지를 생성
            totalPages = 1;
        }

        if (cPage > totalPages || cPage <= 0) { // 페이지가 최소 또는 최대 페이지 범위를 벗어난 경우 1로 설정
            cPage = 1;
        }

        // currentBlock: 현재 위치한 페이지 블럭
        // cPage: 현재 페이지
        // pageLength: 전체 페이지 길이
        // startPage: 페이지 블럭의 가장 첫번째 번호
        // endPage: 페이지 블럭의 가장 마지막 번호

        // 페이지 처음과 끝을 지정하는 부분
        currentBlock = cPage % pageLength == 0 ? cPage / pageLength : (cPage / pageLength) + 1; // 현재 위치한 페이지 블록 구하기(ex. cPage=1, pageLength=10 -> 1)
        startPage = (currentBlock - 1) * pageLength + 1; // 페이지 블럭의 시작 번호 구하기(ex. currentBlock=1, pageLength=10 -> 1)
        endPage = startPage + pageLength - 1; // 페이지 블럭의 마지막 번호 구하기(ex. startPage=1, pageLength=10 -> 10)

        // 마지막 페이지 묶음에서 총 페이지수를 넘어가면 끝 페이지를 마지막 페이지 숫자로 지정
        if (endPage > totalPages) {
            endPage = totalPages;
        }

        start = (cPage - 1) * pageLength; // 각 페이지의 첫 번째 게시글의 번호를 구하기 : (현재 페이지 - 1) * 보여줄 게시글의 갯수(ex. 1페이지=0~9, 2페이지=10~19, 3페이지=20~29)

        // 첫 번째 게시글의 번호와 보여줄 게시글의 갯수를 가지고 게시글 목록을 조회(총 pageLength개의 데이터를 가져오며, 현재 페이지 - 1 * pageLength에 해당하는 번호의 게시글들이 조회됨)
        map.put("start", start);
        map.put("pageLength", pageLength);
        map.put("startPage", startPage);
        map.put("endPage", endPage);
        map.put("totalPages", totalPages);
        map.put("cPage", cPage);

        return map;
    }
}
