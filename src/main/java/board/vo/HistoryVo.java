package board.vo;

import lombok.Data;

@Data
public class HistoryVo {
    private int id;
    private String serialNum;
    private String latitude;
    private String longitude;
    private String txTime;
}
