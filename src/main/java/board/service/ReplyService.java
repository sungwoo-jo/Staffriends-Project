package board.service;

import board.vo.BoardVo;
import board.vo.ReplyVo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface ReplyService {
    List<ReplyVo> getAllReply(Integer boardIdx); // 댓글 목록(replyOrder순으로 출력)
    
    void insertReply(ReplyVo replyVo); // 댓글 작성
    
    void deleteReply(int replyIdx); // 댓글 삭제(deleted_yn을 y로 update)
    
    int countReply(int boardIdx); // 댓글 갯수

    ReplyVo getReplyParent(String replyParent); // 부모 댓글의 정보 조회(replyDepth는 +1하여 가져오고 replyOrder는 가장 큰 값을 가져온다.)

    void updateReplyOrder(ReplyVo replyInfo); // replyInfo의 replyOrder보다 큰 나머지 댓글들의 순서 증가

    String getMaxOrder(int boardIdx); // 최근 댓글의 숫자를 최대값으로
}
