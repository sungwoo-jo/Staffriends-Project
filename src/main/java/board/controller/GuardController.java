package board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/guard")
public class GuardController {

    @GetMapping("")
    public String guard(HttpServletRequest request) {
        HttpSession session = request.getSession();
        System.out.println(session.getCreationTime());
        if (session == null) {
            // 데이터가 없으면 에러 페이지 출력
            return "/guard/guardError";
        } else {
            // 데이터가 있으면 지도 화면 출력
            return "/guard/guardIndex";
        }
    }
}