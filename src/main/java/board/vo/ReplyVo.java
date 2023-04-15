package board.vo;

import lombok.Data;

@Data
public class ReplyVo {
    private int replyIdx; // 댓글 번호
    private String creatorId; // 댓글 작성자
    private String replyContent; // 댓글 내용
    private int boardIdx; // 게시글 번호
}
