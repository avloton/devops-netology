# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:
- вывода списка БД

**Ответ:**
```shell
\l[+]   [PATTERN]      list databases
```

- подключения к БД

**Ответ:**
```shell
\c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo}
```
- вывода списка таблиц

**Ответ:**
```shell
 \dt[S+] [PATTERN]      list tables
```
- вывода описания содержимого таблиц

**Ответ:**
```shell
\d[S+]  NAME           describe table
```
- выхода из psql

**Ответ:**
```shell
\q
```

## Задача 2

Используя `psql` создайте БД `test_database`.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.

**Ответ:**
```shell
select attname, avg_width from pg_stats where tablename = 'orders' order by avg_width desc limit 1;

|attname|avg_width|
|-------|---------|
|title  |16       |
```

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.

**Ответ:**

Текущую таблицу не получится преобразовать в секционированную.
Потребуется создать новую таблицу и вставить в нее данные.

Переименовываем старую таблицу:
```
alter table orders rename to orders_old;
```

Создаем новую секционированную таблицу, взяв структуру старой, с разбиением на секции методом RANGE по полю price: 
```
create table orders (like orders_old) partition by range (price);
```

Создаем первую секцию, в которую должны попасть записи со значениями price > 499:
```
create table orders_1 partition of orders for values from (500) to (maxvalue);
```

Создаем вторую секцию, в которую должны попасть записи со значениями price <= 499:
```
create table orders_2 partition of orders for values from (minvalue) to (500);
```

Вставляем данные в секционированную таблицу:
```
insert into orders select * from orders_old;
```

Проверяем, что все данные попали в новую таблицу:
```
select * from orders;

|id |title               |price|
|---|--------------------|-----|
|1  |War and peace       |100  |
|3  |Adventure psql time |300  |
|4  |Server gravity falls|300  |
|5  |Log gossips         |123  |
|7  |Me and my bash-pet  |499  |
|2  |My little database  |500  |
|6  |WAL never lies      |900  |
|8  |Dbiezdmin           |501  |
```

Проверяем, что первая секция содержит корректные данные:
```
select * from orders_1;

|id |title             |price|
|---|------------------|-----|
|2  |My little database|500  |
|6  |WAL never lies    |900  |
|8  |Dbiezdmin         |501  |
```

Проверяем, что вторая секция содержит корректные данные:
```
select * from orders_2;

|id |title               |price|
|---|--------------------|-----|
|1  |War and peace       |100  |
|3  |Adventure psql time |300  |
|4  |Server gravity falls|300  |
|5  |Log gossips         |123  |
|7  |Me and my bash-pet  |499  |
```

Удаляем старую таблицу:
```shell
drop table orders_old;
```

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

**Ответ:**
Да, можно было при создании таблицы orders на этапе проектирования сделать ее изначально секционированной.

## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.

**Ответ:**

```shell
docker exec -it 64_postgres_1 bash -c "pg_dump test_database -Fp -U postgres -h localhost -p 5432" > dump.sql
```


Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

**Ответ:**

К определению поля title нужно добавить ключевое слово UNIQUE:
```
title character varying(80) NOT NULL UNIQUE
```

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
