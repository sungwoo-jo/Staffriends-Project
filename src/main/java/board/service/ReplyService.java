package board.service;

import board.vo.BoardVo;
import board.vo.ReplyVo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface ReplyService {
    List<ReplyVo> getAllReply(Integer boardIdx);
    
    void insertReply(ReplyVo replyVo);
    
    void deleteReply(ReplyVo replyVo);

    ReplyVo getReplyParent(String replyParent);

    void updateReplyOrder(ReplyVo replyInfo);

    String getMaxOrder(int boardIdx);

    void updateReplyCount(int boardIdx);

    void updateReplyContents(ReplyVo replyVo);
}
