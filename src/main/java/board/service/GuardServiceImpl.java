package board.service;

import board.mapper.GuardMapper;
import board.vo.HistoryVo;
import board.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.util.HashMap;
import java.util.List;

@Repository
@Service
public class GuardServiceImpl implements GuardService{

    @Autowired
    private GuardMapper guardMapper;

    @Override
    public List<HistoryVo> getHistory(String serialNum) {
        return guardMapper.getHistory(serialNum);
    }
}
