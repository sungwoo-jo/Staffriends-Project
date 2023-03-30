package board.controller;

import board.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import board.dto.UserDto;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("/user/join")
    public String join() {
        return "/user/joinForm";
    }

    @RequestMapping("/user/join/insert")
    public String joinUser(UserDto userDto) throws Exception{
        userService.insertUser(userDto);
        return "redirect:/";
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
