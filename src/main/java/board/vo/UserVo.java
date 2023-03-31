package board.vo;

import lombok.Data;

@Data
public class UserVo {
    private int id;
    private String username;
    private String password;
    private String nickname;
    private String email;
    private String joinDate;
    private String sessionId;
}
