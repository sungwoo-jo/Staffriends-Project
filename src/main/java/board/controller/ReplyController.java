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
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/reply")
public class ReplyController {
    @Autowired
    private ReplyService replyService;

    @PostMapping("/insertReply")
    public String insertReply(@RequestBody ReplyVo replyVo) {
        replyService.insertReply(replyVo);
        return "insertSuccess";
    }

    @PostMapping("/getAllReply")
    public String getAllReply(@RequestBody String boardIdx) throws ParseException {
        JSONParser parser = new JSONParser();
        JSONObject jsonObject = (JSONObject)parser.parse(boardIdx);

        String strIdx = (String) jsonObject.get("boardIdx");
        Integer idx = Integer.parseInt(strIdx);

        List<ReplyVo> list = replyService.getAllReply(idx);
        System.out.println("list:"+list);
        return "good";
    }
}
