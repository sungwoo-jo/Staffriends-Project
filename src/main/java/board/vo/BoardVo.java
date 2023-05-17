package board.vo;

import lombok.Data;

@Data
public class BoardVo {
    private int boardIdx; // 게시글 번호
    private String title; // 제목
    private String contents; // 내용
    private int hitCnt; // 조회수
    private String username; // 작성자 id
    private String nickname; // 작성자 닉네임
    private String createdDateTime; // 작성일
    private String updaterId; // 수정자
    private String updatedDateTime; // 수정일
    private int replyCount; // 댓글 갯수
    private String deletedYn; // 삭제 여부
}
