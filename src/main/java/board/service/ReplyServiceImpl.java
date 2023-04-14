package board.service;

import board.mapper.ReplyMapper;
import board.vo.ReplyVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Repository
@Service
public class ReplyServiceImpl implements ReplyService {

    @Autowired
    private ReplyMapper replyMapper;

    @Override
    public ReplyVo getAllReply(Integer boardIdx) {
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
}
