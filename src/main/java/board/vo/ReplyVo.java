package board.vo;

import lombok.Data;

@Data
public class ReplyVo {
    private int replyIdx; // 댓글 번호
    private int userId; // 댓글 작성자 idx
    private String username; // 댓글 작성자
    private String replyContents; // 댓글 내용
    private int boardIdx; // 게시글 번호
    private String deletedYn; // 삭제 여부
    private String createdDatetime; // 작성 시간
}
