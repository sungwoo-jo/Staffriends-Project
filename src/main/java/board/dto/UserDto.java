package board.dto;

import lombok.Data;

@Data
public class UserDto {
    private int id;
    private String username;
    private String password;
    private String nickname;
    private String email;
    private String joinDate;
}
