package board.vo;

import lombok.Data;

@Data
public class BoardVo {
    private int boardIdx;
    private String title;
    private String contents;
    private int hitCnt;
    private String creatorId;
    private String createdDateTime;
    private String updaterId;
    private String updatedDateTime;
}
