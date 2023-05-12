package board.mapper;

import org.apache.ibatis.annotations.Mapper;
import board.vo.UserVo;

@Mapper
public interface UserMapper {
    void insertUser(UserVo userVo) throws Exception;

    Integer loginProc(UserVo userVo) throws Exception;

    int idCheck(String username) throws Exception;

    UserVo getUserInfo(Integer count);

    void updateUser(UserVo userVo);

    String findMyId(UserVo userVo);

    Integer findMyPassword(UserVo userVo);

    String findMyPasswordProc(UserVo userVo);

    void updatePassword(UserVo userVo);
}
