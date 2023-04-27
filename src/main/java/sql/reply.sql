create table reply (
                       reply_idx int not null auto_increment primary key,
                       user_id int not null,
                       username varchar(100) not null,
                       reply_contents varchar(1000) not null,
                       board_idx int(10) not null,
                       deleted_yn char(1) not null default 'N',
                       created_datetime timestamp not null,
                       reply_parent int,
                       reply_depth int not null,
                       reply_order int not null,
                       constraint board_reply_fk foreign key(board_idx) references t_board(board_idx)
                           on delete cascade on update cascade
);