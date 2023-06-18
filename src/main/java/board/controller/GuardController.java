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

    @PostMapping("/guardIndex") // 보호자 페이지 메인
    public String guard(String serialNum, Model model) { // 회원 정보의 serialNum을 전달받음
        List<HistoryVo> map = guardService.getHistory(serialNum); // 등록된 serialNum으로 입력된 데이터가 있는지 조회해서 map에 반환
        model.addAttribute("history", map); // 결과를 history라는 model 객체에 담아줌
        if (serialNum.equals("")) { // 시리얼 번호를 등록하지 않았다면
            return "/guard/notRegSerial"; // 시리얼 번호를 등록하지 않았다는 페이지로 이동
        } else if (map.size() == 0) { // 시리얼 번호를 등록했으나, 데이터가 없는 경우
            return "/guard/guardError"; // 잘못된 시리얼 or 아직 데이터가 없다는 페이지로 이동
        }
        return "/guard/guardIndex"; // 정상적인 시리얼 번호를 입력한 경우 정상적으로 보호자 페이지에 결과를 출력
    }

    @GetMapping("/notRegSerial") // 시리얼 번호 미등록 페이지
    public String notRegSerial() {
        return "/guard/notRegSerial";
    }
}