package board.service;

import board.dto.UserDto;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public interface UserService {
    int insertUser(UserDto userDto) throws Exception;

    Integer checkUser(Map<String, String> userInfo) throws Exception;

    int idCheck(String username) throws Exception;
}
