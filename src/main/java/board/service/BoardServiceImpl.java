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
        int currentBlock; // 현재 위치한 페이지 블럭
        int pageLength = 10; // 보여줄 게시글의 갯수
        int startPage; // 페이지 블록의 시작 번호
        int endPage; // 페이지 블록의 마지막 번호
        int totalPages; // 전체 페이지의 갯수
        int offsetStartNumber; // SQL 쿼리의 LIMIT에 들어갈 변수(~번 부터 pageLength개를 출력)
        int totalRows = getTotalRows(); // 전체 게시글의 갯수

//        // cPage(현재 위치한 페이지의 번호 정하기)
//        if (tempPage == null || tempPage.length() == 0 || tempPage.equals("0")) { // 파라미터로 전달받은 페이지 정보가 없거나 0이면 1페이지로 이동
//            cPage = 1;
//        }

        try {
            cPage = Integer.parseInt(tempPage); // 파라미터로 전달받은 페이지 번호를 현재 페이지에 변환하여 담아줌
        } catch (NumberFormatException e) { // 에러 발생 시(숫자가 아닌 문자가 들어오는 경우) 1로 설정
            cPage = 1;
        }

        System.out.println("totalRows: " + totalRows);
        System.out.println("pageLength: " + pageLength);
        System.out.println("totalRows / pageLength: " + totalRows / pageLength);
        // 필요한 총 페이지의 개수는 데이터의 개수를 보여줄 게시글의 개수로 나누어 딱맞으면 0, 초과하면 1개의 페이지를 더 생성(최소 1개의 페이지 생성)
        totalPages = totalRows % pageLength == 0 ? totalRows / pageLength : (totalRows / pageLength) + 1;
        System.out.println("totalPages: " + totalPages);

        if (cPage > totalPages || cPage <= 0) { // 페이지가 최소 또는 최대 페이지 범위를 벗어난 경우 1로 설정(반드시 총 페이지의 개수가 구해진 후 연산)
            cPage = 1;
        }

        // 페이지 처음과 끝을 지정하는 부분
        currentBlock = cPage % pageLength == 0 ? cPage / pageLength : (cPage / pageLength) + 1; // 현재 위치한 페이지 블록의 순번(1~10: 1번째, 11~20: 2번째, 21~30: 3번째)
        System.out.println("currentBlock: " + currentBlock);
        startPage = (currentBlock - 1) * pageLength + 1; // 페이지 블럭의 시작 번호 구하기(1~10은 1로 시작, 11~20은 11로 시작, 21~30은 21로 시작)
        endPage = currentBlock * pageLength; // 페이지 블럭의 마지막 번호 구하기(1~10의 끝 번호는 10, 11~20의 끝 번호는 20, 21~30의 끝 번호는 30)

        // 총 페이지 갯수보다 endPage가 높으면 endPage를 총 페이지 갯수로 지정(불필요한 페이지 번호를 생성하지 않기 위함)
        if (endPage > totalPages) {
            endPage = totalPages;
        }

        offsetStartNumber = (cPage - 1) * pageLength; // 각 페이지의 첫 번째 게시글의 번호를 구하기 : (현재 페이지 - 1) * 보여줄 게시글의 갯수(ex. 1페이지=0~9, 2페이지=10~19, 3페이지=20~29)

        // 첫 번째 게시글의 번호와 보여줄 게시글의 갯수를 가지고 게시글 목록을 조회(총 pageLength개의 데이터를 가져오며, 현재 페이지 - 1 * pageLength에 해당하는 번호의 게시글들이 조회됨)
        map.put("start", offsetStartNumber);
        map.put("pageLength", pageLength);
        map.put("startPage", startPage);
        map.put("endPage", endPage);
        map.put("totalPages", totalPages);
        map.put("cPage", cPage);

        return map;
    }
}
