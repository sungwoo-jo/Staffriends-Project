package board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import board.dto.UserDto;
import board.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public void insertUser(UserDto userDto) throws Exception {
        userMapper.insertUser(userDto);
    }

    @Override
    public void loginProc(UserDto userDto) throws Exception {
        userMapper.loginProc(userDto);
    }
}
