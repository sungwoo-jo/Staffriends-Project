package board.service;

import board.dto.UserDto;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public interface UserService {
    int insertUser(UserDto userDto) throws Exception;

    Integer checkUser(HashMap<String, String> userInfo) throws Exception;

    int idCheck(String username) throws Exception;
}
