package board.controller;

import board.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import board.vo.UserVo;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/joinForm") // 회원가입 페이지
    public String join() {
        return "/user/joinForm";
    }

    @PostMapping("/join/idCheck") // 중복 아이디 확인
    @ResponseBody
    public Map<String, Integer> idCheck(@RequestBody String username) throws Exception {
        username = username.replace("\"", ""); // json 포맷의 쌍따옴표 치환
        int count = userService.idCheck(username);
        Map<String, Integer> map = new HashMap<>();
        map.put("count", count);
        return map;
    }

    @PostMapping("/join/insert") // 회원 가입
    @ResponseBody
    public void joinUser(@RequestBody UserVo userVo) throws Exception{
        userService.insertUser(userVo);
    }

    @GetMapping("/loginForm") // 로그인 페이지
    public String login() {
        return "/user/loginForm";
    }

    @PostMapping("/checkUser") // 존재하는 회원인지 확인
    @ResponseBody
    public boolean checkUser(@RequestBody UserVo userVo, HttpSession session) throws Exception {
        Integer result = userService.checkUser(userVo); // 회원 조회. 반환 타입: 회원의 id
        if (result == null) { // 일치하는 회원의 id 정보가 조회되지 않으면 result의 값을 설정하지 않고 리턴
            return false;
        }
        userVo = userService.getUserInfo(result); // 회원의 id로 회원 정보를 조회하여 담아줌
        session.setAttribute("signIn", userVo);
        return true;
    }

    @GetMapping("/logout") // 로그아웃
    public String logOut(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/updateForm") // 정보수정 페이지
    public String updateForm() {
        return "/user/updateForm";
    }

    @PostMapping("/updateProc") // 정보 업데이트
    @ResponseBody
    public void updateUser(@RequestBody UserVo userVo) throws Exception {
        userService.updateUser(userVo);
    }

    @GetMapping("/needLogin") // 로그인 안내 페이지
    public String needLogin() {
        return "/user/needLogin";
    }

    @GetMapping("/kakao")
    public String kakaoLogin(@RequestParam String code, HttpSession session) throws Exception { // 카카오 로그인
        System.out.println("code:"+code);
        String accessToken = userService.getAccessToken(code);

        UserVo userInfo = userService.getUserInfoFromKakao(accessToken);
        String originalPassword = userInfo.getPassword();
        System.out.println("Before join userInfo: " + userInfo);
        Integer result = userService.checkUser(userInfo); // 회원 조회. 반환 타입: 회원의 id
        System.out.println("After checkUser userInfo: " + userInfo);
        System.out.println(result);
        if (result == null) { // 존재하지 않으면 회원가입 진행 후 index 페이지로 이동
            System.out.println("존재하지않는회원->회원가입 진행");
            userInfo.setPassword(originalPassword);
            userService.insertUser(userInfo);
            session.setAttribute("signIn", userInfo);
        } else { // 존재하면 로그인 후 index 페이지로 이동
            System.out.println("존재하는회원->로그인 진행");
            UserVo userVo = userService.getUserInfo(result); // 회원의 id로 회원 정보를 조회하여 담아줌
            session.setAttribute("signIn", userVo);
        }
        return "redirect:/";
    }
}
