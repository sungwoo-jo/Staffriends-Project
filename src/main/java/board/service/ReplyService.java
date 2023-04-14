package board.service;

import board.vo.BoardVo;
import board.vo.ReplyVo;
import org.springframework.stereotype.Service;

@Service
public interface ReplyService {
    ReplyVo getAllReply(Integer boardIdx); // 댓글 목록
    
    void insertReply(ReplyVo replyVo); // 댓글 작성
    
    void deleteReply(int replyIdx); // 댓글 삭제
    
    int countReply(int boardIdx); // 댓글 갯수
}
