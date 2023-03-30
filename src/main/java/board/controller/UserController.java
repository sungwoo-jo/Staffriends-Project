package board.controller;

import board.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import board.dto.UserDto;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("/user/joinForm")
    public String join() {
        return "/user/joinForm";
    }

    @PostMapping("/user/join/idCheck")
    @ResponseBody
    public Map<String, Integer> idCheck(@RequestBody String username) throws Exception {
        username = username.replace("\"", ""); // json 포맷의 쌍따옴표 치환
        int count = userService.idCheck(username);
        Map<String, Integer> map = new HashMap<>();
        map.put("count", count);
        return map;
    }

    @PostMapping("/user/join/insert")
    @ResponseBody
    public void joinUser(@RequestBody UserDto userDto) throws Exception{
        System.out.println(userDto);
        userService.insertUser(userDto);
    }

    @RequestMapping("/user/login")
    public String loginProc() throws Exception {
        return "/user/loginProc";
    }

    @RequestMapping("/user/loginProc")
    public String loginProc(UserDto userDto) throws Exception {
        userService.loginProc(userDto);
        return "redirect:/";
    }
}
