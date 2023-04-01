package board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import board.vo.UserVo;
import board.mapper.UserMapper;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.util.HashMap;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public int insertUser(UserVo userVo) throws Exception {
        messageDigest(userVo, userVo.getPassword());
        int result = userMapper.insertUser(userVo);
        return result;
    }

    @Override
    public int idCheck(String username) throws Exception {
        int result = userMapper.idCheck(username);
        return result;
    }

    @Override
    public Integer checkUser(UserVo userVo) throws Exception {
        messageDigest(userVo, userVo.getPassword());
        return userMapper.checkUser(userVo);
    }

    @Override
    public UserVo getUserInfo(int count) {
        return userMapper.getUserInfo(count);
    }

    @Override
    public void updateProc(UserVo userVo) throws Exception {
        messageDigest(userVo, userVo.getPassword());
        userMapper.updateProc(userVo);
    }

    public UserVo messageDigest(UserVo userVo, String oldPassword) throws Exception { // SHA-512 해시함수
        MessageDigest md = MessageDigest.getInstance("SHA-512");
        md.reset();
        md.update(oldPassword.getBytes("UTF8"));
        userVo.setPassword(String.format("%0128x", new BigInteger(1, md.digest())));
        return userVo;
    }
}
