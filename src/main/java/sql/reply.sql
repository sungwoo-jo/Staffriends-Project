create table reply (
                       reply_idx int not null auto_increment primary key,
                       creator_id varchar(100) not null,
                       reply_content varchar(1000) not null,
                       board_idx int(10) not null,
                       foreign key(board_idx) references t_board(board_idx)
);