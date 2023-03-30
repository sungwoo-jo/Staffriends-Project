package board.service;

import board.dto.UserDto;
import org.springframework.stereotype.Service;

@Service
public interface UserService {
    int insertUser(UserDto userDto) throws Exception;

    void loginProc(UserDto userDto) throws Exception;

    int idCheck(String username) throws Exception;
}
