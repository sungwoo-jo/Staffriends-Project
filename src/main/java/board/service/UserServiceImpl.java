package board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import board.vo.UserVo;
import board.mapper.UserMapper;

import java.util.HashMap;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public int insertUser(UserVo userVo) throws Exception {
        int result = userMapper.insertUser(userVo);
        System.out.println(result);
        return result;
    }

    @Override
    public int idCheck(String username) throws Exception {
        int result = userMapper.idCheck(username);
        return result;
    }

    @Override
    public Integer checkUser(HashMap<String, String> userInfo) throws Exception {
        return userMapper.checkUser(userInfo);
    }

    @Override
    public UserVo getUserInfo(int count) {
        return userMapper.getUserInfo(count);
    }

    @Override
    public void updateProc(HashMap<String, String> map) {
        userMapper.updateProc(map);
    }
}
