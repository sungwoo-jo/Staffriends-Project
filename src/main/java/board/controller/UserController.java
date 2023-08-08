package board.controller;

import board.service.UserService;
import org.apache.catalina.User;
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
    public String joinUser(@RequestBody UserVo userVo) throws Exception{
        userService.insertUser(userVo);
        return "insertSuccess";
    }

    @GetMapping("/loginForm") // 로그인 페이지
    public String login() {
        return "/user/loginForm";
    }

    @PostMapping("/loginProc") // ID와 PW 일치 여부 확인
    @ResponseBody
    public boolean loginProc(@RequestBody UserVo userVo, HttpSession session) throws Exception {
        String username = userService.loginProc(userVo); // 일치하는 회원의 id
        if (username == null) { // 일치하는 회원의 아이디가 조회되지 않으면 세션 값을 설정하지 않고 리턴
            return false;
        }
        userVo = userService.getUserInfo(username); // 회원의 id로 회원 정보를 조회하여 담아줌
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

    @PatchMapping("/updateProc") // 정보 업데이트
    @ResponseBody
    public String updateUser(@RequestBody UserVo userVo) throws Exception {
        System.out.println("userVo:"+userVo);
        userService.updateUser(userVo);
        return "success";
    }

    @GetMapping("/needLogin") // 로그인 안내 페이지
    public String needLogin() {
        return "/user/needLogin";
    }

    @GetMapping("/kakao") // 카카오 로그인 요청
    public String kakaoLogin(@RequestParam String code, HttpSession session) throws Exception { // 카카오 로그인
        System.out.println("code:"+code);
        String accessToken = userService.getAccessTokenFromKakao(code); // accessToken 요청
        UserVo userInfo = userService.getUserInfoFromKakao(accessToken); // accessToken으로 사용자 정보 요청
        String originalPassword = userInfo.getPassword(); // 카카오 계정에 설정하는 디폴트 패스워드 값(originalPassword)
        String username = userService.loginProc(userInfo); // 기존 가입자 여부 확인
        if (username == null) { // 가입 정보가 존재하지 않으면 회원가입 진행
            userInfo.setPassword(originalPassword); // 패스워드 설정
            userService.insertUser(userInfo); // 회원 정보 insert
            session.setAttribute("signIn", userInfo); // 회원 세션 생성
        } else { // 가입 정보가 존재하면 로그인
            UserVo userVo = userService.getUserInfo(username); // 회원 id로 회원 정보를 조회
            session.setAttribute("signIn", userVo); // 회원 세션 생성
        }
        return "redirect:/";
    }

    @GetMapping("/naver") // 네이버 로그인 요청
    public String naverLogin(@RequestParam String code, @RequestParam String state, HttpSession session) throws Exception { // 네이버 로그인
        System.out.println("네이버 로그인 요청 API 호출");
        System.out.println("code:"+code);
        System.out.println("state:"+state);
        String accessToken = userService.getAccessTokenFromNaver(code, state); // accessToken 요청
        UserVo userInfo = userService.getUserInfoFromNaver(accessToken);
        String originalPassword = userInfo.getPassword(); // Oauth 계정에 설정하는 디폴트 패스워드 값(originalPassword)
        String username = userService.loginProc(userInfo); // 기존 가입자 여부 확인
        if (username == null) { // 가입 정보가 존재하지 않으면 회원가입 진행
            userInfo.setPassword(originalPassword); // 패스워드 설정
            userService.insertUser(userInfo); // 회원 정보 insert
            session.setAttribute("signIn", userInfo); // 회원 세션 생성
        } else { // 가입 정보가 존재하면 로그인
            UserVo userVo = userService.getUserInfo(username); // 회원 id로 회원 정보를 조회
            session.setAttribute("signIn", userVo); // 회원 세션 생성
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
        map.put("username", userService.findMyId(userVo)); // 아이디를 찾은 결과를 추가
        return map;
    }

    @GetMapping("/findMyPassword") // 비밀번호 찾기 페이지
    public String findMyPassword() {
        return "/user/findMyPassword";
    }

    @PostMapping("/resetPassword") // 찾을 비밀번호의 정보 입력 및 결과 출력 페이지
    @ResponseBody
    public Map<String, Object> resetPassword(@RequestBody UserVo userVo) throws Exception {
        Map<String, Object> map = new HashMap<>();
        if (userService.findMyPassword(userVo) != null) { // 회원 정보가 일치하는 경우
            map.put("password", userService.resetPassword(userVo)); // 비밀번호 재설정
        } else { // 회원 정보가 일치하지 않는 경우
            map.put("password", "0"); // "0"을 설정
        }
        return map;
    }
}
