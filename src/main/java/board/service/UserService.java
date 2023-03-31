package board.service;

import board.vo.UserVo;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
public interface UserService {
    int insertUser(UserVo userVo) throws Exception;

    Integer checkUser(HashMap<String, String> userInfo) throws Exception;

    int idCheck(String username) throws Exception;

    UserVo getUserInfo(int count);
}
