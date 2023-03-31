package board.mapper;

import org.apache.ibatis.annotations.Mapper;
import board.dto.UserDto;

import java.util.HashMap;
import java.util.Map;

@Mapper
public interface UserMapper {
    int insertUser(UserDto userDto) throws Exception;

    Integer checkUser(HashMap<String, String> userInfo) throws Exception;

    int idCheck(String username) throws Exception;
}
