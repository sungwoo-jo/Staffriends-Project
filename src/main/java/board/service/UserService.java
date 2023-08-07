package board.service;

import board.vo.UserVo;
import org.springframework.stereotype.Service;

@Service
public interface UserService {
    void insertUser(UserVo userVo) throws Exception;

    String loginProc(UserVo userVo) throws Exception;

    int idCheck(String username) throws Exception;

    UserVo getUserInfo(String username);

    void updateUser(UserVo userVo) throws Exception;

    String getAccessTokenFromKakao(String authorize_code);

    String getAccessTokenFromNaver(String authorize_code);

    UserVo getUserInfoFromKakao(String accessToken);

    String findMyId(UserVo userVo);

    String findMyPassword(UserVo userVo);

    String resetPassword(UserVo userVo) throws Exception;

    void updatePassword(UserVo userVo);
}
