package board.vo;

import lombok.Data;

@Data
public class UserVo {
//    private int id; // 유저 고유 번호
    private String name; // 이름
    private String username; // 아이디
    private String password; // 비밀번호
    private String nickname; // 닉네임
    private String email; // 이메일
    private String joinDate; // 가입일
    private String serialNum; // 시리얼 번호
    private String oauth; // oauth 여부
}
