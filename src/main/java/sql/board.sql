-- board Table Create SQL
-- 테이블 생성 SQL - board
CREATE TABLE board
(
    `board_idx`         int(10)         NOT NULL    AUTO_INCREMENT COMMENT '게시글 번호',
    `title`             varchar(300)    NOT NULL    COMMENT '제목',
    `contents`          text            NOT NULL    COMMENT '내용',
    `hit_cnt`           smallint(10)    NOT NULL    DEFAULT 0 COMMENT '조회수',
    `created_datetime`  datetime        NOT NULL    COMMENT '작성 일자',
    `username`        varchar(50)     NOT NULL      COMMENT '작성 회원 id',
    `updated_datetime`  datetime        NULL        COMMENT '수정 일자',
    `updater_id`        varchar(50)     NULL        COMMENT '수정 회원 id',
    `deleted_yn`        char(1)         NOT NULL    DEFAULT 'N' COMMENT '삭제 여부',
    `reply_count`       int             NULL        DEFAULT 0 COMMENT '댓글 갯수',
    `bgno`              int             NOT NULL    COMMENT '게시판종류',
     PRIMARY KEY (board_idx)
);

-- Foreign Key 설정 SQL - board(creator_id) -> user(username)
ALTER TABLE board
    ADD CONSTRAINT user_board_fk FOREIGN KEY (username)
        REFERENCES user (username) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Foreign Key 삭제 SQL - reply(board_idx)
-- ALTER TABLE board
-- DROP FOREIGN KEY user_board_fk;

