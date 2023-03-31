package board.controller;

import board.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import board.dto.UserDto;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/joinForm")
    public String join() {
        return "/user/joinForm";
    }

    @PostMapping("/join/idCheck")
    @ResponseBody
    public Map<String, Integer> idCheck(@RequestBody String username) throws Exception {
        username = username.replace("\"", ""); // json 포맷의 쌍따옴표 치환
        int count = userService.idCheck(username);
        Map<String, Integer> map = new HashMap<>();
        map.put("count", count);
        return map;
    }

    @PostMapping("/join/insert")
    @ResponseBody
    public void joinUser(@RequestBody UserDto userDto) throws Exception{
        MessageDigest md = MessageDigest.getInstance("SHA-512");
        md.reset();
        md.update(userDto.getPassword().getBytes("UTF8"));
        userDto.setPassword(String.format("%0128x", new BigInteger(1, md.digest())));
        userService.insertUser(userDto);
    }

    @GetMapping("/loginForm")
    public String login() throws Exception {
        return "/user/loginForm";
    }

    @PostMapping("/checkUser")
    @ResponseBody
//    public String checkUser(@RequestBody String username, @RequestBody String password) throws Exception {
    public String checkUser(@RequestBody Map<String, String> userInfo) throws Exception {
        System.out.println("checkUser 들어옴");
        String username = userInfo.get("username");
        String password = userInfo.get("password");
        userService.checkUser(userInfo);
        System.out.println(userService.checkUser(userInfo));
        return "redirect:/";
    }
}
