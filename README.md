# 📊 SQL Practice — Financial Market Database

A mini-project to practice SQL skills: creating tables, designing relationships, writing analytical queries with aggregation and window functions.  
The domain is a **financial market** — brokers, exchanges, client accounts, stocks, and trades.

---

![](/Users/MAC/Desktop/accounts.png)


## 🏗️ Database Schema Overview

### 1. `exchanges` — Stock Exchanges  
Stores basic information about trading exchanges.

| Field | Type | Description |
|--------|------|-------------|
| exchange_id | SERIAL | Primary key |
| exchange_name | VARCHAR(50) | Exchange name (e.g., NASDAQ) |
| country_name | VARCHAR(50) | Country |

---

### 2. `brokers` — Brokers  
Trading companies through which clients execute trades.

| Field | Type | Description |
|--------|------|-------------|
| broker_id | SERIAL | Primary key |
| broker_name | VARCHAR(50) | Broker name |
| country_name | VARCHAR(50) | Country |

---

### 3. `accounts` — Client Accounts  
Each client has an account under a broker.

| Field | Type | Description |
|--------|------|-------------|
| account_id | SERIAL | Primary key |
| broker_id | INT | FK → brokers |
| owner_name | VARCHAR(100) | Account owner |
| base_currency | VARCHAR(10) | Account currency |
| opened_at | DATE | Date opened |

---

### 4. `stocks` — Instruments  
Represents tradable companies (stocks).

| Field | Type | Description |
|--------|------|-------------|
| stock_id | SERIAL | Primary key |
| ticker | VARCHAR(10) | Stock symbol (AAPL, TSLA) |
| company_name | VARCHAR(100) | Company name |
| category | VARCHAR(50) | Sector (IT, Finance, Automotive) |
| exchange_id | INT | FK → exchanges |

---

### 5. `trades` — Transactions  
All buy/sell operations performed by clients.

| Field | Type | Description |
|--------|------|-------------|
| trade_id | SERIAL | Primary key |
| account_id | INT | FK → accounts |
| stock_id | INT | FK → stocks |
| exchange_id | INT | FK → exchanges |
| deal_name | VARCHAR(10) | 'BUY' or 'SELL' |
| quantity | INT | Number of shares |
| price | DECIMAL(10,2) | Trade price per share |
| trade_time | TIMESTAMP | Trade timestamp |

---

## 💾 Example Data

| ticker | company_name | category | exchange |
|--------|---------------|-----------|-----------|
| AAPL | Apple Inc. | IT | NASDAQ |
| MSFT | Microsoft Corp. | IT | NASDAQ |
| JPM | JPMorgan Chase | Finance | NYSE |
| TSLA | Tesla Inc. | Automotive | NASDAQ |
| KO | Coca-Cola Co. | Consumer Goods | NYSE |

---

## 🧠 SQL Tasks to Practice

### 🔸 Basic Queries
1. List all accounts with their brokers and opening dates.  
2. Show all stocks with their sectors and exchanges.  
3. Find the top-3 most frequently traded stocks.  
4. For each account, calculate:  
   - total commissions paid,  
   - total traded volume (`SUM(price * quantity)`).

### 🔸 Aggregations and Grouping
5. Calculate the average trade price for each stock.

### 🔸 Financial Analytics
6. Find stocks traded on multiple exchanges.

### 🔸 Window Functions
7. For each broker, calculate the percentage of trades per exchange  
   (e.g., Robinhood — 60% NASDAQ, 40% NYSE).  

## 🎯 Learning Goals

This project helps to:
- Understand table relationships: one-to-many and many-to-many.  
- Practice joins, grouping, subqueries, and window functions.  
- Learn to calculate percentages, rankings, and moving totals.  
- Build a clean SQL project suitable for a GitHub portfolio.


## 🧱 Author
**Aliaksei Berasneu**  
SQL Practice Project — Financial Market Data  
Created for self-study and portfolio use.
