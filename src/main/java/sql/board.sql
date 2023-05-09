create table t_board(
                        board_idx int(10) not null primary key auto_increment,
                        title varchar(300) not null,
                        contents text not null,
                        hit_cnt smallint(10) not null default 0,
                        created_datetime datetime not null,
                        creator_id varchar(50) not null,
                        updated_datetime datetime,
                        updater_id varchar(50),
                        deleted_yn char(1) not null default 'N',
                        reply_count int default 0
);