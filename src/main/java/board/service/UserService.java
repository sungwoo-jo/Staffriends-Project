package board.service;

import board.dto.UserDto;

public interface UserService {
    void insertUser(UserDto userDto) throws Exception;

    void loginProc(UserDto userDto) throws Exception;
}
