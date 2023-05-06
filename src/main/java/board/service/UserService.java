package board.service;

import board.vo.UserVo;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
public interface UserService {
    void insertUser(UserVo userVo) throws Exception;

    Integer checkUser(UserVo userVo) throws Exception;

    int idCheck(String username) throws Exception;

    UserVo getUserInfo(int count);

    void updateUser(UserVo userVo) throws Exception;

    String getAccessToken(String authorize_code);

    HashMap<String, Object> getUserInfoFromKakao(String accessToken);
}
