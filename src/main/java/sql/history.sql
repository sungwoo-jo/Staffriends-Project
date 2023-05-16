-- history Table Create SQL
-- 테이블 생성 SQL - history
CREATE TABLE history
(
    `id`          int              NOT NULL    AUTO_INCREMENT COMMENT '데이터 순번',
    `serial_num`  varchar(100)     NOT NULL    COMMENT '시리얼 번호',
    `latitude`       decimal(9,6)     NOT NULL    COMMENT '위도',
    `longitude`      decimal(10,6)    NOT NULL    COMMENT '경도',
    `tx_time`     timestamp        NOT NULL    COMMENT '수신시간',
     PRIMARY KEY (id)
);

-- Foreign Key 설정 SQL - history(serial_num) -> user(serial_num)
ALTER TABLE history
    ADD CONSTRAINT history_user_fk FOREIGN KEY (serial_num)
        REFERENCES user (serial_num) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Foreign Key 삭제 SQL - history(serial_num)
-- ALTER TABLE history
-- DROP FOREIGN KEY history_user_fk;