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
    public String insertReply(@RequestBody ReplyVo replyVo) {
        replyService.insertReply(replyVo);
        return "insertSuccess";
    }


    @PostMapping("/getAllReply")
    public List<ReplyVo> getAllReply(@RequestBody String boardIdx, Model model) throws ParseException {

        List<ReplyVo> list = replyService.getAllReply(Integer.parseInt(boardIdx));

        System.out.println("list:"+list);

        System.out.println("size:"+list.size());

        model.addAttribute("list", list);
        return list;
    }

    @PostMapping("/deleteReply")
    public String deleteReply(@RequestBody String replyIdx) {
        replyService.deleteReply(Integer.parseInt(replyIdx));

        return "deleteSuccess";
    }
}
