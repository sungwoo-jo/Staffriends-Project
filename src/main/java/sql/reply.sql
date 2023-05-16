-- reply Table Create SQL
-- 테이블 생성 SQL - reply
CREATE TABLE reply
(
    `reply_idx`         int              NOT NULL    AUTO_INCREMENT COMMENT '댓글 번호',
    `username`          varchar(100)     NOT NULL    COMMENT '댓글 작성자 id',
    `reply_contents`    varchar(1000)    NOT NULL    COMMENT '댓글 내용',
    `board_idx`         int(10)          NOT NULL    COMMENT '게시글 번호',
    `deleted_yn`        char(1)          NOT NULL    DEFAULT 'N' COMMENT '삭제 여부',
    `created_datetime`  timestamp        NOT NULL    DEFAULT current_timestamp COMMENT '작성 일자',
    `reply_parent`      int              NULL        COMMENT '모 댓글 idx',
    `reply_depth`       int              NOT NULL    COMMENT '댓글, 대댓글 여부',
    `reply_order`       int              NOT NULL    COMMENT '댓글 출력 순서',
     PRIMARY KEY (reply_idx)
);

-- Foreign Key 설정 SQL - reply(board_idx) -> board(board_idx)
ALTER TABLE reply
    ADD CONSTRAINT board_reply_fk FOREIGN KEY (board_idx)
        REFERENCES board (board_idx) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Foreign Key 삭제 SQL - reply(board_idx)
-- ALTER TABLE reply
-- DROP FOREIGN KEY board_reply_fk;