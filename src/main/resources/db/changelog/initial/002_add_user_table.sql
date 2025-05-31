create table users
(
    id           BIGINT auto_increment PRIMARY KEY,
    user_name    VARCHAR(100),
    email        VARCHAR(100) UNIQUE,
    password     VARCHAR(100),
    avatar       VARCHAR(255),
    enabled      boolean not null default true,
    account_type long    not null
)
