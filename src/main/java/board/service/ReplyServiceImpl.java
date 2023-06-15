package board.service;

import board.mapper.ReplyMapper;
import board.vo.ReplyVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.List;

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
        if(replyVo.getReplyIdx() == null) { // 새로운 댓글을 등록하는 경우(replyIdx가 비어있는 경우)
            if (replyVo.getReplyParent() != null) { // 부모 댓글의 정보가 있는 경우(계층형 댓글을 작성하는 경우)
                // replyInfo에 부모 댓글의 정보를 대입(부모 댓글의 정보를 가져온다.)
                ReplyVo replyInfo = getReplyParent(replyVo.getReplyParent()); // getReplyParent 메서드는 replyDepth를 부모 댓글의 replyDepth에 +1하여 가져온다.
                replyVo.setReplyDepth(replyInfo.getReplyDepth()); // 새로 등록되는 댓글의 replyDepth를 부모 댓글의 replyDepth에 +1 한 값으로 세팅
                replyVo.setReplyOrder(replyInfo.getReplyOrder() + 1); // replyOrder는 부모 댓글보다 한 단계 아래에 출력되어야 하기 때문에 +1로 세팅
                updateReplyOrder(replyInfo); // updateReplyOrder 메서드 실행(전달받은 댓글을 제외한 나머지 댓글들의 출력 순서를 증가하여 해당 위치에 댓글을 삽입하기 위함)
            } else { // 일반 댓글을 작성하는 경우(부모 댓글의 정보가 없는 경우 == getReplyParent == null)
                Integer maxReplyOrder = Integer.valueOf(getMaxOrder(replyVo.getBoardIdx())); // replyOrder의 최댓값을 가져온다.(가장 최근에 작성된 댓글이기 때문에 가장 아래에 출력)
                replyVo.setReplyOrder(maxReplyOrder); // replyOrder를 가장 큰 값으로 세팅하여 가장 마지막 댓글로 출력
            }
            replyMapper.insertReply(replyVo); // 댓글 정보를 DB에 insert
            updateReplyCount(replyVo.getBoardIdx());
        } else { // replyIdx의 값이 존재한다면 댓글의 출력 순서를 update
            updateReplyOrder(replyVo); // 댓글 또는 대댓글 작성 시 updateReplyOrder 메서드를 호출
        }
//        replyMapper.insertReply(replyVo);
    }

    @Override
    public void deleteReply(ReplyVo replyVo) { // 댓글 삭제 메서드
        replyMapper.deleteReply(replyVo);
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

    @Override
    public void updateReplyContents(ReplyVo replyVo) {
        replyMapper.updateReplyContents(replyVo);
    }
}
