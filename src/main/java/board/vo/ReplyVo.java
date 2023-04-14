package board.vo;

import lombok.Data;

@Data
public class ReplyVo {
    private int replyIdx;
    private String creatorId;
    private String replyContent;
    private int boardIdx;
}
