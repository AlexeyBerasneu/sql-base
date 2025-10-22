--1. List all accounts with their brokers and opening dates.
-- 1 - Вывести список всех счетов с указанием брокера и даты открытия.
select account_id, broker_name, opened_at
from accounts as ac
         left join brokers as br on ac.broker_id = br.broker_id;

--2. Show all stocks with their sectors and exchanges.
-- 2 - Показать все акции с их биржей и категорией.
select ticker, company_name, category, exchange_name
from stock_exchange as se
        join exchanges as ex on se.exchange_id = ex.exchange_id
        join stocks as st on se.stock_id = st.stock_id;

--3. Find the top-3 most frequently traded stocks.
-- 3 -Найти 3 самые популярные акции по количеству сделок.
select ticker, count(*) as trade_count
from trades as t
         join stocks as st on t.stock_id = st.stock_id
GROUP BY ticker
order by trade_count DESC
LIMIT 3;

--4. For each account, calculate:
-- total commissions paid,
-- total traded volume (`SUM(price * quantity)`).
-- 4 - Для каждого счёта посчитать, сколько он заплатил комиссий и какой у него общий оборот (сумма всех покупок и продаж).
select ac.account_id,
       sum(tr.quantity * tr.price * (tr.comission / 100)) as commission_amount,
       sum(tr.quantity * tr.price)                        as volume
from trades as tr
         join accounts as ac on tr.account_id = ac.account_id
group by ac.account_id
order by volume DESC;

--5. Calculate the average trade price for each stock.
--Для каждой акции посчитать среднюю цену сделки.
select stock_id, avg(price) as average_price
from trades
group by stock_id
order by average_price DESC;

--6. Find stocks traded on multiple exchanges.
-- Показать акции, которые торговались сразу на нескольких биржах.
select ticker, date, array_agg(DISTINCT ex.exchange_name) as exchange_name
from trades as tr
         join stocks as st on tr.stock_id = st.stock_id
         join exchanges as ex on tr.exchange_id = ex.exchange_id
group by ticker, date
having count(DISTINCT tr.exchange_id) >= 2;

--7. For each broker, calculate the percentage of trades per exchange  (e.g., Robinhood — 60% NASDAQ, 40% NYSE).
--Для каждого брокера вывести долю сделок по биржам (например, 60% NYSE, 40% NASDAQ).
-- Пример
--Robinhood:
--NASDAQ: 5 + 10 = 15
--NYSE: 5 + 5 = 10
-- Всего 25 сделок → 60% NASDAQ, 40% NYSE
select broker_name,
       exchange_name,
       round(100 * sum(quantity) / sum(sum(quantity)) over (PARTITION BY broker_name)) as percentage
from trades as tr
         join accounts as ac on tr.account_id = ac.account_id
         join brokers as br on ac.broker_id = br.broker_id
         join exchanges as ex on tr.exchange_id = ex.exchange_id
group by broker_name, exchange_name
order by broker_name;