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
    public String loginProc(UserVo userVo) throws Exception { // 비밀번호 암호화 후 로그인 진행
        messageDigest(userVo, userVo.getPassword());
        return userMapper.loginProc(userVo);
    }

    @Override
    public UserVo getUserInfo(String username) { // 회원 정보 조회
        return userMapper.getUserInfo(username);
    }

    @Override
    public void updateUser(UserVo userVo) throws Exception { // 비밀번호 암호화 후 회원 정보 수정
        messageDigest(userVo, userVo.getPassword());
        userMapper.updateUser(userVo);
    }

    @Override
    public String getAccessToken(String code) { // 액세스 토큰 발급 받기
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
//            sb.append("&redirect_uri=http://localhost/user/kakao"); // redirect uri
            sb.append("&redirect_uri=http://staffriends.duckdns.org/user/kakao"); // service redirect uri
            sb.append("&code=" + code); // 인가코드
            bw.write(sb.toString());
            bw.flush();

            // 결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();

            // 요청을 통해 얻은 JSON타입의 Response 메시지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }

            //Gson 라이브러리에 포함된 클래스로 JSON 파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            accessToken = element.getAsJsonObject().get("access_token").getAsString();
            refreshToken = element.getAsJsonObject().get("refresh_token").getAsString();

//            System.out.println("accessToken : " + accessToken);
//            System.out.println("refreshToken : " + refreshToken);

            br.close();
            bw.close();

        } catch (IOException e) {
            e.printStackTrace();
        }

        return accessToken;
    }

    @Override
    public UserVo getUserInfoFromKakao(String accessToken) { // 사용자 정보 가져오기
        UserVo userInfo = new UserVo();
        String reqURL = "https://kapi.kakao.com/v2/user/me"; // 요청 URL 주소

        try {
            URL url = new URL(reqURL); // URL 생성
            HttpURLConnection conn = (HttpURLConnection)url.openConnection();
            conn.setRequestMethod("GET"); // method는 GET으로 설정

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
                Map<String, Object> originalName = (Map<String, Object>) properties.get("profile");

                // 회원정보 설정
                long id = (long) jsonMap.get("id"); // 고유번호
                String name = (String) originalName.get("nickname"); // 이름
                String password = "1234"; // 비밀번호
                String originalEmail = (String) properties.get("email"); // 이메일
                String[] email = originalEmail.split("@"); // 지정할 닉네임
                String nickname = email[0];
                String username = "k_" + id; // 아이디
                userInfo.setName(name);
                userInfo.setUsername(username);
                userInfo.setPassword(password);
                userInfo.setNickname(nickname);
                userInfo.setEmail(originalEmail);
                userInfo.setOauth("kakao");

            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return userInfo;
    }

    @Override
    public String findMyId(UserVo userVo) { // 아이디 찾기(이름, 이메일로 조회)
        return userMapper.findMyId(userVo);
    }

    @Override
    public String findMyPassword(UserVo userVo) { // 비밀번호 찾기(아이디, 이름, 이메일로 조회)
        return userMapper.findMyPassword(userVo);
    }

    @Override
    public String resetPassword(UserVo userVo) throws Exception { // 비밀번호 재설정 로직
        String newPassword = RandomStringUtils.randomAlphanumeric(15); // 15자리의 영소문자+숫자로 이루어진 랜덤한 비밀번호 생성
        String username = findMyPassword(userVo); // 입력받은 회원정보로 존재하는 회원의 고유번호 조회
        userVo = getUserInfo(username); // 회원 id로 해당하는 회원 정보 조회
        messageDigest(userVo, newPassword); // 비밀번호 암호화
        updatePassword(userVo); // 회원 비밀번호 재설정
        System.out.println("userVo:" + userVo);

        return newPassword; // 재설정한 비밀번호를 반환
    }

    @Override
    public void updatePassword(UserVo userVo) { // 회원 비밀번호 재설정
        userMapper.updatePassword(userVo);
    }

    public void messageDigest(UserVo userVo, String originalPassword) throws Exception { // SHA-512 해시함수
        MessageDigest md = MessageDigest.getInstance("SHA-512"); // 암호화 기법 지정
        md.update(originalPassword.getBytes()); // originalPassword를 byte 배열로 변환
        userVo.setPassword(String.format("%0128x", new BigInteger(1, md.digest()))); // 해싱된 비밀번호 문자열을 10진법으로 받아 16진법으로 변환하여  set
    }
}
