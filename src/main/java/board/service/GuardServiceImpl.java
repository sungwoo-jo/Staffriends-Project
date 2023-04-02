package board.service;

import board.mapper.GuardMapper;
import board.vo.HistoryVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class GuardServiceImpl implements GuardService{

    @Autowired
    private GuardMapper guardMapper;

    @Override
    public List<HistoryVo> getHistory(String serialNum) {
        return guardMapper.getHistory(serialNum);
    }
}
