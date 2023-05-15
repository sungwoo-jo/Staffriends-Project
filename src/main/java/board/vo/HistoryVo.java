package board.vo;

import lombok.Data;

@Data
public class HistoryVo {
    private int id; // 고유번호
    private String serialNum; // 시리얼 번호
    private String latitude; // 위도
    private String longitude; // 경도
    private String txTime; // 수신시간
}
