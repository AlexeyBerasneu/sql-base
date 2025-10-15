drop table if exists exchanges cascade;
create table exchanges
(
    exchange_id   SERIAL PRIMARY KEY,
    exchange_name varchar(50) not null,
    country_name  varchar(50) not null
);

insert into exchanges(exchange_name, country_name)
values ('NYSE', 'USA'),
       ('NASDAQ', 'USA'),
       ('London Stock Exchange', 'UK'),
       ('Binance', 'Russia'),
       ('Tokyo Stock Exchange', 'Japan');

drop table if exists brokers cascade;
create table brokers
(
    broker_id    SERIAL PRIMARY KEY,
    broker_name  varchar(50) not null,
    country_name varchar(50) not null
);

insert into brokers(broker_name, country_name)
values ('Robinhood', 'USA'),
       ('VanGuard', 'USA'),
       ('eToro', 'Turkish'),
       ('Kraken', 'China'),
       ('Trading 212', 'Belarus');

drop table if exists accounts cascade;
create table accounts
(
    account_id SERIAL PRIMARY KEY,
    broker_id  int         not null REFERENCES brokers (broker_id) ON DELETE cascade,
    owner_name varchar(50) not null,
    opened_at  DATE DEFAULT current_date
);

insert into accounts(broker_id, owner_name, opening_date)
values (1, 'Alex', '2025-12-02'),
       (2, 'Bob', '2024-04-04'),
       (5, 'Alice', '2020-09-08'),
       (3, 'Sheron', '2022-08-02'),
       (1, 'Denis', '1986-01-05');

drop table if exists stocks cascade;
create table stocks
(
    stock_id     SERIAL PRIMARY KEY,
    ticker       varchar(50) not null,
    company_name varchar(50) not null,
    category     varchar(50) not null,
    exchange_id  int         not null references exchanges (exchange_id) ON DELETE cascade
);

insert into stocks(ticker, company_name, category, exchange_id)
VALUES ('AAPL', 'Apple Inc.', 'IT', 1),
       ('MSFT', 'Microsoft Corp.', 'IT', 3),
       ('JPM', 'JPMorgan Chase', 'Finance', 2),
       ('TSLA', 'Tesla Inc.', 'Automotive', 2),
       ('KO', 'Coca-Cola Co.', 'Consumer Goods', 4);


drop table if exists trades cascade;
create table trades
(
    trade_id    SERIAL PRIMARY KEY,
    account_id  int  not null references accounts (account_id) ON DELETE cascade,
    stock_id    int  not null references stocks (stock_id) ON DELETE cascade,
    exchange_id int  not null references exchanges (exchange_id) ON DELETE cascade,
    deal_name   text not null check ( deal_name in ('BUY', 'SELL')),
    quantity    int check ( quantity > 0 ),
    price       DECIMAL(10, 2),
    comission   decimal(10, 2),
    date        date default current_date
);

insert into trades(account_id, stock_id, exchange_id, deal_name, quantity, price, comission, date)
VALUES (1, 3, 1, 'SELL', 20, 10.5, 10, '2025-12-05'),
       (3, 3, 2, 'BUY', 10, 20, 20, '2025-12-05'),
       (2, 5, 3, 'SELL', 30, 40.5, 5, '2025-12-07'),
       (5, 1, 5, 'BUY', 50, 100, 35, '2025-12-09'),
       (4, 4, 4, 'SELL', 15, 4.5, 8, '2025-12-18'),
       (3, 3, 2, 'BUY', 70, 20, 69, '2025-12-05'),
       (2, 2, 3, 'SELL', 60, 40.5, 3, '2025-12-24'),
       (5, 1, 5, 'BUY', 34, 35, 18, '2025-12-20'),
       (1, 4, 4, 'SELL', 52, 2.5, 10, '2025-12-31');

