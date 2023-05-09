package board.controller;

import board.service.ReplyService;
import board.vo.ReplyVo;
import com.google.gson.JsonObject;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/reply")
public class ReplyController {
    @Autowired
    private ReplyService replyService;

    @PostMapping("/insertReply")
    public String insertReply(@RequestBody ReplyVo replyVo) { // 댓글 및 대댓글 등록 메서드(ajax로 요청)
        if(replyVo.getReplyIdx() == null || "".equals(replyVo.getReplyIdx())) { // 새로운 댓글을 등록하는 경우(replyIdx가 비어있는 경우)
            if (replyVo.getReplyParent() != null) { // 부모 댓글의 정보가 있는 경우(계층형 댓글을 작성하는 경우)
                // replyInfo에 부모 댓글의 정보를 대입(부모 댓글의 정보를 가져온다.)
                ReplyVo replyInfo = replyService.getReplyParent(replyVo.getReplyParent()); // getReplyParent 메서드는 replyDepth를 부모 댓글의 replyDepth에 +1하여 가져온다.
                replyVo.setReplyDepth(replyInfo.getReplyDepth()); // 새로 등록되는 댓글의 replyDepth를 부모 댓글의 replyDepth에 +1 한 값으로 세팅
                replyVo.setReplyOrder(replyInfo.getReplyOrder() + 1); // replyOrder는 부모 댓글보다 한 단계 아래에 출력되어야 하기 때문에 +1로 세팅
                replyService.updateReplyOrder(replyInfo); // updateReplyOrder 메서드 실행(전달받은 댓글을 제외한 나머지 댓글들의 출력 순서를 증가하여 해당 위치에 댓글을 삽입하기 위함)
            } else { // 일반 댓글을 작성하는 경우(부모 댓글의 정보가 없는 경우 == getReplyParent == null)
                Integer maxReplyOrder = Integer.valueOf(replyService.getMaxOrder(replyVo.getBoardIdx())); // replyOrder의 최댓값을 가져온다.(가장 최근에 작성된 댓글이기 때문에 가장 아래에 출력)
                replyVo.setReplyOrder(maxReplyOrder); // replyOrder를 가장 큰 값으로 세팅하여 가장 마지막 댓글로 출력
            }
            replyService.insertReply(replyVo); // 댓글 정보를 DB에 insert
            replyService.updateReplyCount(replyVo.getBoardIdx());
        } else { // replyIdx의 값이 존재한다면 댓글의 출력 순서를 update
            replyService.updateReplyOrder(replyVo); // 댓글 또는 대댓글 작성 시 updateReplyOrder 메서드를 호출
        }
        return "insertSuccess"; // 성공적으로 댓글 작성 후 insertSuccess 문자열 반환
    }

    @PostMapping("/getAllReply")
    public List<ReplyVo> getAllReply(@RequestBody String boardIdx) { // 댓글 정보 출력 메서드
        return replyService.getAllReply(Integer.parseInt(boardIdx)); // 전달받은 boardIdx와 일치하고, 삭제되지 않은 댓글의 정보를 replyOrder 순서대로 조회하여 결과를 반환
    }

    @PostMapping("/deleteReply")
    public String deleteReply(@RequestBody String replyIdx) { // 댓글 삭제 메서드
        replyService.deleteReply(Integer.parseInt(replyIdx)); // 전달받은 replyIdx와 일치하는 컬럼의 deleted_yn 필드를 y로 update

        return "deleteSuccess"; // 성공적으로 댓글 삭제 후 deleteSuccess 문자열 반환
    }
}
