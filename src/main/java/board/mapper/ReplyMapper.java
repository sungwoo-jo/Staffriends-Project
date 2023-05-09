package board.mapper;

import board.vo.ReplyVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReplyMapper {
    List<ReplyVo> getAllReply(Integer boardIdx);

    void insertReply(ReplyVo replyVo);

    void deleteReply(int replyIdx);

    ReplyVo getReplyParent(String replyParent);

    void updateReplyOrder(ReplyVo replyInfo);

    String getMaxOrder(int boardIdx);

    void updateReplyCount(int boardIdx);
}
