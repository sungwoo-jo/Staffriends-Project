package board.controller;

import board.service.GuardService;
import board.vo.HistoryVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/guard")
public class GuardController {

    @Autowired
    private GuardService guardService;

    @GetMapping("/guardIndex")
    public String guard(@RequestParam("serial_num") String serialNum, Model model) {
        List<HistoryVo> map = guardService.getHistory(serialNum);
        model.addAttribute("history", map);
        System.out.println(map);
        if (map.size() == 0) {
            return "/guard/guardError";
        }
        return "/guard/guardIndex";
    }
}