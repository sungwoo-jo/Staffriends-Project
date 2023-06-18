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
        replyService.insertReply(replyVo);

        return "insertSuccess";
    }

    @GetMapping("/getAllReply/{boardIdx}")
    public List<ReplyVo> getAllReply(@PathVariable("boardIdx") int boardIdx) { // 댓글 정보 출력 메서드
        return replyService.getAllReply(boardIdx); // 전달받은 boardIdx와 일치하고, 삭제되지 않은 댓글의 정보를 replyOrder 순서대로 조회하여 결과를 반환
    }

    @DeleteMapping("/deleteReply/{replyIdx}")
    public String deleteReply(@RequestBody ReplyVo replyVo) { // 댓글 삭제 메서드
        replyService.deleteReply(replyVo); // 전달받은 replyIdx와 일치하는 컬럼의 deleted_yn 필드를 y로 update
        replyService.updateReplyCount(replyVo.getBoardIdx());

        return "deleteSuccess"; // 성공적으로 댓글 삭제 후 deleteSuccess 문자열 반환
    }

    @PutMapping("/modifyProc/{replyIdx}")
    public String modifyProc(@RequestBody ReplyVo replyVo) { // 댓글 수정 메서드
        System.out.println(replyVo);
        replyService.updateReplyContents(replyVo);
        return "modifySuccess";
    }
}
