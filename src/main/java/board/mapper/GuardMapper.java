package board.mapper;

import board.vo.HistoryVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface GuardMapper {
    List<HistoryVo> getHistory(String serialNum);
}
