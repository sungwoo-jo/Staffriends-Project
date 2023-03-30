package board.mapper;

import org.apache.ibatis.annotations.Mapper;
import board.dto.UserDto;

@Mapper
public interface UserMapper {
    void insertUser(UserDto userDto) throws Exception;

    void loginProc(UserDto userDto) throws Exception;
}
