package board.mapper;

import org.apache.ibatis.annotations.Mapper;
import board.vo.UserVo;

import java.util.HashMap;

@Mapper
public interface UserMapper {
    int insertUser(UserVo userVo) throws Exception;

    Integer loginProc(UserVo userVo) throws Exception;

    int idCheck(String username) throws Exception;

    UserVo getUserInfo(int count);

    void updateUser(UserVo userVo);

    String findMyId(UserVo userVo);

    Integer findMyPassword(UserVo userVo);

    String findMyPasswordProc(UserVo userVo);

    void updatePassword(UserVo userVo);
}
