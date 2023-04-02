package board.service;

import board.vo.HistoryVo;

import java.util.HashMap;
import java.util.List;

public interface GuardService {
    List<HistoryVo> getHistory(String serialNum);
}
