package board.controller;

import board.service.GuardService;
import board.vo.HistoryVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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

    @PostMapping("/guardIndex")
    public String guard(String serialNum, Model model) {
        System.out.println(serialNum);
        List<HistoryVo> map = guardService.getHistory(serialNum);
        model.addAttribute("history", map);
        if (serialNum.equals("")) {
            System.out.println("등록된시리얼번호없음");
            return "/guard/notRegSerial";
        } else if (map.size() == 0) {
            System.out.println("잘못된 시리얼 번호를 입력하였거나, 기기 등록 정보없음");
            return "/guard/guardError";
        }
        return "/guard/guardIndex";
    }

    @PostMapping("/notRegSerial")
    public String notRegSerial() {
        return "/guard/notRegSerial";
    }
}