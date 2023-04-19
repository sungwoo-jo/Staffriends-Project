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


    @ResponseBody
    @PostMapping("/getAllReply")
    public Map<String, Object> getAllReply(@RequestBody String boardIdx, Model model) throws ParseException {
//        System.out.println("댓글목록 컨트롤러 들어옴");
        Map<String, Object> map = new HashMap<>();
        JSONParser parser = new JSONParser();
        JSONObject jsonObject = (JSONObject)parser.parse(boardIdx);

        String strIdx = (String) jsonObject.get("boardIdx");
        Integer idx = Integer.parseInt(strIdx);

        List<ReplyVo> list = replyService.getAllReply(idx);

        System.out.println("list:"+list);

        System.out.println("size:"+list.size());

        for(int i=0; i<list.size(); i++) {
            System.out.println("list.get(i):"+list.get(i));
        }

        map.put("list", list);
        map.put("size", list.size());
        return map;
    }
}
