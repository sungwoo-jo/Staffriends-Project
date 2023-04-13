package board.service;

import board.vo.HistoryVo;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public interface GuardService {
    List<HistoryVo> getHistory(String serialNum);
}
