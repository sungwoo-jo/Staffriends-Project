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
    public List<ReplyVo> getAllReply(Integer boardIdx) { // 댓글 조회 메서드
        return replyMapper.getAllReply(boardIdx);
    }

    @Override
    public void insertReply(ReplyVo replyVo) { // 댓글 삽입 메서드
        replyMapper.insertReply(replyVo);
    }

    @Override
    public void deleteReply(int replyIdx) { // 댓글 삭제 메서드
        replyMapper.deleteReply(replyIdx);
    }

    @Override
    public ReplyVo getReplyParent(String replyParent) { // 부모 댓글 정보 조회 메서드
        return replyMapper.getReplyParent(replyParent);
    }

    @Override
    public void updateReplyOrder(ReplyVo replyInfo) { // 댓글 출력 순서 증가 메서드
        replyMapper.updateReplyOrder(replyInfo);
    }

    @Override
    public String getMaxOrder(int boardIdx) { // 가장 최신 댓글의 순서를 구하는 메서드
        return replyMapper.getMaxOrder(boardIdx);
    }

    @Override
    public void updateReplyCount(int boardIdx) { // 댓글 갯수를 구하는 메서드
        replyMapper.updateReplyCount(boardIdx);
    }
}
