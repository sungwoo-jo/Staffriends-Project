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
    public List<HistoryVo> getHistory(String serialNum) { // 사용자의 경로 정보 조회 메서드(정렬 순서는 내림차순 - 가장 나중에 들어온 데이터를 먼저 조회)
        return guardMapper.getHistory(serialNum);
    }
}
