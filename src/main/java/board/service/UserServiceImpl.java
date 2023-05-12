package board.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import board.vo.UserVo;
import board.mapper.UserMapper;

import java.io.*;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.MessageDigest;
import java.util.Map;

@Repository
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public void insertUser(UserVo userVo) throws Exception { // 비밀번호 암호화 후 회원가입 진행
        messageDigest(userVo, userVo.getPassword());
        userMapper.insertUser(userVo);
    }

    @Override
    public int idCheck(String username) throws Exception { // 중복 아이디 확인
        return userMapper.idCheck(username);
    }

    @Override
    public Integer loginProc(UserVo userVo) throws Exception { // 비밀번호 암호화 후 로그인 진행
        messageDigest(userVo, userVo.getPassword());
        return userMapper.loginProc(userVo);
    }

    @Override
    public UserVo getUserInfo(Integer count) { // 회원 정보 조회
        return userMapper.getUserInfo(count);
    }

    @Override
    public void updateUser(UserVo userVo) throws Exception { // 비밀번호 암호화 후 회원 정보 수정
        messageDigest(userVo, userVo.getPassword());
        userMapper.updateUser(userVo);
    }

    @Override
    public String getAccessToken(String code) { //
        String accessToken = "";
        String refreshToken = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";

        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            // POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            // POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=69eddbebb2b07d6a316fc057c32fdbdf"); // REST API KEY
            sb.append("&redirect_uri=http://localhost/user/kakao"); // redirect uri
            sb.append("&code=" + code);
            bw.write(sb.toString());
            bw.flush();

            // 결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            // 요청을 통해 얻은 JSON타입의 Response 메시지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            //Gson 라이브러리에 포함된 클래스로 JSON 파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            accessToken = element.getAsJsonObject().get("access_token").getAsString();
            refreshToken = element.getAsJsonObject().get("refresh_token").getAsString();

            System.out.println("accessToken : " + accessToken);
            System.out.println("refreshToken : " + refreshToken);

            br.close();
            bw.close();

        } catch (IOException e) {
            e.printStackTrace();
        }

        return accessToken;
    }

    @Override
    public UserVo getUserInfoFromKakao(String accessToken) {
        UserVo userInfo = new UserVo();
        String reqURL = "https://kapi.kakao.com/v2/user/me";

        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection)url.openConnection();
            conn.setRequestMethod("GET");

            // 요청에 필요한 Header에 포함될 내용
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);

            int responseCode = conn.getResponseCode();
            System.out.println(responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);
            System.out.println("result type : " + result.getClass().getName()); // java.lang.String

            try {
                // jackson objectmapper 객체 생성
                ObjectMapper objectMapper = new ObjectMapper();
                // JSON String -> Map
                Map<String, Object> jsonMap = objectMapper.readValue(result, new TypeReference<Map<String, Object>>() {
                });

                System.out.println("properties: "+jsonMap.get("properties"));
                Map<String, Object> properties = (Map<String, Object>) jsonMap.get("kakao_account");
//                System.out.println(properties.get("nickname"));
//                System.out.println(properties.get("email"));
                long id = (long) jsonMap.get("id");
                String password = "1234";
                String originalEmail = (String) properties.get("email");
                String[] email = originalEmail.split("@");
                String nickname = email[0];
                String username = "k_" + id;

                userInfo.setUsername(username);
                userInfo.setPassword(password);
                userInfo.setNickname(nickname);
                userInfo.setEmail(originalEmail);
                userInfo.setOauth("kakao");

                System.out.println(userInfo);

            } catch (Exception e) {
                e.printStackTrace();
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
        return userInfo;
    }

    @Override
    public String findMyId(UserVo userVo) {
        return userMapper.findMyId(userVo);
    }

    @Override
    public Integer findMyPassword(UserVo userVo) {
        return userMapper.findMyPassword(userVo);
    }

    @Override
    public String findMyPasswordProc(UserVo userVo) throws Exception {
        String newPwd = RandomStringUtils.randomAlphanumeric(15);
        Integer id = findMyPassword(userVo);
        userVo = getUserInfo(id);
        messageDigest(userVo, newPwd);
        updatePassword(userVo);
        System.out.println("userVo:" + userVo);

        return newPwd;
    }

    @Override
    public void updatePassword(UserVo userVo) {
        userMapper.updatePassword(userVo);
    }

    public void messageDigest(UserVo userVo, String originalPassword) throws Exception { // SHA-512 해시함수
        MessageDigest md = MessageDigest.getInstance("SHA-512"); // 암호화 기법 지정
        md.update(originalPassword.getBytes()); // originalPassword를 byte 배열로 변환
        userVo.setPassword(String.format("%0128x", new BigInteger(1, md.digest()))); // 해싱된 비밀번호 문자열을 10진법으로 받아 16진법으로 변환하여  set
    }
}
