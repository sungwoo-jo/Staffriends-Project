package board.service;

import board.mapper.ReplyMapper;
import board.vo.ReplyVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.List;

@Repository
@Service
public class ReplyServiceImpl implements ReplyService {

    @Autowired
    private ReplyMapper replyMapper;

    @Override
    public List<ReplyVo> getAllReply(Integer boardIdx) {
        return replyMapper.getAllReply(boardIdx);
    }

    @Override
    public void insertReply(ReplyVo replyVo) {
        replyMapper.insertReply(replyVo);
    }

    @Override
    public void deleteReply(int replyIdx) {
        replyMapper.deleteReply(replyIdx);
    }

    @Override
    public int countReply(int boardIdx) {
        return replyMapper.countReply(boardIdx);
    }

    @Override
    public ReplyVo getReplyParent(String replyParent) {
        return replyMapper.getReplyParent(replyParent);
    }

    @Override
    public void updateReplyOrder(ReplyVo replyInfo) {
        replyMapper.updateReplyOrder(replyInfo);
    }

    @Override
    public String getMaxOrder(int boardIdx) {
        return replyMapper.getMaxOrder(boardIdx);
    }

    @Override
    public void updateReplyCount(int boardIdx) {
        replyMapper.updateReplyCount(boardIdx);
    }
}
