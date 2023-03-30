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
    public int insertUser(UserDto userDto) throws Exception {
        int result = userMapper.insertUser(userDto);
        System.out.println(result);
        return result;
    }

    @Override
    public int idCheck(String username) throws Exception {
        int result = userMapper.idCheck(username);
        System.out.println("result:"+result);
        return result;
    }

    @Override
    public void loginProc(UserDto userDto) throws Exception {
        userMapper.loginProc(userDto);
    }


}
