package board.mapper;

import org.apache.ibatis.annotations.Mapper;
import board.vo.UserVo;

import java.util.HashMap;

@Mapper
public interface UserMapper {
    int insertUser(UserVo userVo) throws Exception;

    Integer checkUser(UserVo userVo) throws Exception;

    int idCheck(String username) throws Exception;

    UserVo getUserInfo(int count);

    void updateUser(UserVo userVo);
}
