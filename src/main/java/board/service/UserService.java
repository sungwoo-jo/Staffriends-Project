package board.service;

import board.vo.UserVo;
import org.springframework.stereotype.Service;

@Service
public interface UserService {
    void insertUser(UserVo userVo) throws Exception;

    Integer loginProc(UserVo userVo) throws Exception;

    int idCheck(String username) throws Exception;

    UserVo getUserInfo(Integer count);

    void updateUser(UserVo userVo) throws Exception;

    String getAccessToken(String authorize_code);

    UserVo getUserInfoFromKakao(String accessToken);

    String findMyId(UserVo userVo);

    Integer findMyPassword(UserVo userVo);

    String resetPassword(UserVo userVo) throws Exception;

    void updatePassword(UserVo userVo);
}
