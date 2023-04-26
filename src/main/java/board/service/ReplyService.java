package board.service;

import board.vo.BoardVo;
import board.vo.ReplyVo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface ReplyService {
    List<ReplyVo> getAllReply(Integer boardIdx); // 댓글 목록
    
    void insertReply(ReplyVo replyVo); // 댓글 작성
    
    void deleteReply(int replyIdx); // 댓글 삭제
    
    int countReply(int boardIdx); // 댓글 갯수

    ReplyVo getReplyParent(String replyParent); // 모댓글 정보 조회

    void updateReplyOrder(ReplyVo replyInfo); // 나머지 댓글들 순서 증가

    Integer getMaxOrder(int boardIdx); // 최근 댓글의 숫자를 최대값으로
}
