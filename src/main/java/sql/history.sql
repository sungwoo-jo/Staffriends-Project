create table history (
                         id int not null auto_increment primary key,
                         serial_num varchar(100) not null,
                         h_lat decimal(9,6) not null,
                         h_long decimal(10,6) not null,
                         tx_time timestamp not null
);