package board.mapper;

import org.apache.ibatis.annotations.Mapper;
import board.dto.UserDto;

import java.util.Map;

@Mapper
public interface UserMapper {
    int insertUser(UserDto userDto) throws Exception;

    Integer checkUser(Map<String, String> userInfo) throws Exception;

    int idCheck(String username) throws Exception;
}
