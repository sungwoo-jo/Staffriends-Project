create table t_user (
                        id int auto_increment primary key not null,
                        username varchar(100) not null,
                        password varchar(100) not null,
                        email varchar(50) not null,
                        nick_name varchar(20) not null,
                        createDate datetime not null
);