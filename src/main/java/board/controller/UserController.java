package board.controller;

import board.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import board.vo.UserVo;
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
        Map<String, Integer> map = new HashMap<>(); // 중복 아이디 결과를 담아줄 map 선언
        map.put("count", userService.idCheck(username)); // 중복된 아이디의 갯수를 map에 put
        return map; // 갯수 반환
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

    @PostMapping("/loginProc") // ID와 PW 일치 여부 확인
    @ResponseBody
    public boolean loginProc(@RequestBody UserVo userVo, HttpSession session) throws Exception {
        if (userService.loginProc(userVo) == null) { // 일치하는 회원의 id 정보가 조회되지 않으면 세션 값을 설정하지 않고 리턴
            return false;
        }
        userVo = userService.getUserInfo(userService.loginProc(userVo)); // 회원의 id로 회원 정보를 조회하여 담아줌
        session.setAttribute("signIn", userVo); // 회원의 세션 정보 생성 후 리턴
        return true;
    }

    @GetMapping("/logout") // 로그아웃
    public String logOut(HttpServletRequest request) {
        HttpSession session = request.getSession(); // 전달받은 세션의 정보를 저장
        session.invalidate(); // 세션 무효화
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

    @GetMapping("/kakao") // 카카오 로그인 요청
    public String kakaoLogin(@RequestParam String code, HttpSession session) throws Exception { // 카카오 로그인
        System.out.println("code:"+code);
        String accessToken = userService.getAccessToken(code);

        UserVo userInfo = userService.getUserInfoFromKakao(accessToken);
        String originalPassword = userInfo.getPassword();
        System.out.println("Before join userInfo: " + userInfo);
        Integer result = userService.loginProc(userInfo); // 회원 조회. 반환 타입: 회원의 id
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

    @GetMapping("/findMyId") // 아이디 찾기 페이지
    public String findMyId() {
        return "/user/findMyId";
    }

    @PostMapping("/findMyIdProc") // 찾을 아이디의 정보 입력 및 결과 출력 페이지
    @ResponseBody
    public Map<String, Object> findMyIdProc(@RequestBody UserVo userVo) {
        Map<String, Object> map = new HashMap<>();
        map.put("username", userService.findMyId(userVo));
        return map;
    }

    @GetMapping("/findMyPassword") // 비밀번호 찾기 페이지
    public String findMyPassword() {
        return "/user/findMyPassword";
    }

    @PostMapping("/findMyPasswordProc") // 찾을 비밀번호의 정보 입력 및 결과 출력 페이지
    @ResponseBody
    public Map<String, Object> findMyPasswordProc(@RequestBody UserVo userVo) throws Exception {
        Map<String, Object> map = new HashMap<>();
        System.out.println("findMyPassword:"+userService.findMyPassword(userVo));
        if (userService.findMyPassword(userVo) != 0) {
            map.put("password", userService.findMyPasswordProc(userVo));
        } else {
            map.put("password", "0");
        }


        return map;
    }
}
