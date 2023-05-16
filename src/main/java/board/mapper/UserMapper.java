package board.mapper;

import org.apache.ibatis.annotations.Mapper;
import board.vo.UserVo;

@Mapper
public interface UserMapper {
    void insertUser(UserVo userVo) throws Exception;

    String loginProc(UserVo userVo) throws Exception;

    int idCheck(String username) throws Exception;

    UserVo getUserInfo(String username);

    void updateUser(UserVo userVo);

    String findMyId(UserVo userVo);

    String findMyPassword(UserVo userVo);

    String resetPassword(UserVo userVo);

    void updatePassword(UserVo userVo);
}
