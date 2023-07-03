package board.vo;

import lombok.Data;

@Data
public class PagingVo {
    private int cPage; // 현재 위치한 페이지의 번호
    private int currentBlock; // 현재 위치한 페이지 블럭
    private int pageLength = 10; // 보여줄 게시글의 갯수
    private int startPage; // 페이지 블록의 시작 번호
    private int endPage; // 페이지 블록의 마지막 번호
    private int totalPages; // 전체 페이지의 갯수
    private int offsetStartNumber; // SQL 쿼리의 LIMIT에 들어갈 변수(~번 부터 pageLength개를 출력)
    private int totalRows; // 전체 게시글의 갯수
    private int bgno; // 게시판 종류
}
