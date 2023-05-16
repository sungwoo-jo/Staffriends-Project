-- user Table Create SQL
-- 테이블 생성 SQL - user
CREATE TABLE user
(
    `id`          int             NOT NULL    AUTO_INCREMENT COMMENT '회원 idx',
    `name`        varchar(100)    NOT NULL    COMMENT '이름',
    `username`    varchar(100)    NOT NULL    COMMENT '회원 id',
    `password`    varchar(130)    NOT NULL    COMMENT '비밀번호',
    `email`       varchar(50)     NOT NULL    COMMENT '이메일',
    `nickname`    varchar(20)     NOT NULL    COMMENT '닉네임',
    `join_date`   datetime        NOT NULL    COMMENT '가입 일자',
    `serial_num`  varchar(100)    NULL        COMMENT '시리얼 번호',
    `oauth`       varchar(10)     NULL        COMMENT 'oauth 여부',
     PRIMARY KEY (id)
);