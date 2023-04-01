package board.controller;

import board.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import board.vo.UserVo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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
        MessageDigest md = MessageDigest.getInstance("SHA-512");
        md.reset();
        md.update(userVo.getPassword().getBytes("UTF8"));
        userVo.setPassword(String.format("%0128x", new BigInteger(1, md.digest())));
        userService.insertUser(userVo);
    }

    @GetMapping("/loginForm") // 로그인 페이지
    public String login() {
        return "/user/loginForm";
    }

    @PostMapping("/checkUser") // 존재하는 회원인지 확인
    @ResponseBody
    public Map<String, Integer> checkUser(@RequestBody HashMap<String, String> userInfo, HttpSession session) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-512");
        md.reset();
        md.update(userInfo.get("password").getBytes("UTF8"));
        userInfo.put("password",String.format("%0128x", new BigInteger(1, md.digest())));
        Map<String, Integer> map = new HashMap<>();

        Integer result = userService.checkUser(userInfo);
        if (result == null) { // 일치하는 회원의 id 정보가 조회되지 않으면 result의 값을 설정하지 않고 리턴
            return map;
        }

        UserVo userVo = userService.getUserInfo(result);
        session.setAttribute("signIn", userVo);
        map.put("result", result);
        return map;
    }

    @GetMapping("/logout") // 로그아웃
    public String logOut(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/updateForm") // 정보수정 페이지
    public String updateUser() {
        return "/user/updateForm";
    }

    @PostMapping("/updateProc") // 정보 업데이트
    @ResponseBody
    public void updateProc(@RequestBody HashMap<String, String> userInfo) throws Exception {
        System.out.println(userInfo);
        MessageDigest md = MessageDigest.getInstance("SHA-512");
        md.reset();
        md.update(userInfo.get("password").getBytes("UTF8"));
        userInfo.put("password", String.format("%0128x", new BigInteger(1, md.digest())));
        System.out.println(userInfo);

        userService.updateProc(userInfo);
    }
}
