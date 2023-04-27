package board.vo;

import lombok.Data;

@Data
public class ReplyVo {
    private Integer replyIdx; // 댓글 번호
    private int userId; // 댓글 작성자 idx
    private String username; // 댓글 작성자
    private String replyContents; // 댓글 내용
    private int boardIdx; // 게시글 번호
    private String deletedYn; // 삭제 여부
    private String createdDatetime; // 작성 시간
    private String replyParent; // 모 댓글 idx
    private String replyDepth; // 댓글 or 대댓글 여부, 0:댓글 / 1: 대댓글
    private String replyOrder; // 댓글 출력 순서(높은 댓글일수록 아래에 정렬)
}
