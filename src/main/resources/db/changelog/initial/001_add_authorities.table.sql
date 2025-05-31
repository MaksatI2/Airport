create table authorities
(
    id   long auto_increment primary key not null,
    name varchar(20)                     not null unique
)