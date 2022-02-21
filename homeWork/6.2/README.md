# Домашнее задание к занятию "6.2. SQL"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/tree/master/additional/README.md).

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.

**Ответ:**

```
version: "2.4"

services:
  postgres:
    image: postgres:12
    environment:
      POSTGRES_PASSWORD: secret
    volumes:
      - data-volume:/var/lib/postgresql/data:rw
      - backup-volume:/var/lib/postgresql/backup:rw
    ports:
      - 5432:5432
    restart: always

volumes:
  data-volume:
  backup-volume:
```

## Задача 2

В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
- создайте пользователя test-simple-user  
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

Таблица orders:
- id (serial primary key)
- наименование (string)
- цена (integer)

Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)

Приведите:
- итоговый список БД после выполнения пунктов выше,

**Ответ:**
```shell
test_db=# \l
                                    List of databases
   Name    |      Owner      | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+-----------------+----------+------------+------------+-----------------------
 postgres  | postgres        | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres        | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |                 |          |            |            | postgres=CTc/postgres
 template1 | postgres        | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |                 |          |            |            | postgres=CTc/postgres
 test_db   | test_admin_user | UTF8     | en_US.utf8 | en_US.utf8 |
```

- описание таблиц (describe)

**Ответ:**
```shell
test_db=# \d orders
                              Table "public.orders"
   Column   |  Type   | Collation | Nullable |              Default
------------+---------+-----------+----------+------------------------------------
 id         | integer |           | not null | nextval('orders_id_seq'::regclass)
 order_name | text    |           |          |
 price      | integer |           |          |
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_order_id_fkey" FOREIGN KEY (order_id) REFERENCES orders(id)
```

```shell
test_db=# \d clients
                             Table "public.clients"
  Column  |  Type   | Collation | Nullable |               Default
----------+---------+-----------+----------+-------------------------------------
 id       | integer |           | not null | nextval('clients_id_seq'::regclass)
 surname  | text    |           |          |
 country  | text    |           |          |
 order_id | integer |           |          |
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "clients_country_idx" btree (country)
Foreign-key constraints:
    "clients_order_id_fkey" FOREIGN KEY (order_id) REFERENCES orders(id)
```


- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db

**Ответ:**
```
select
	grantee,
	table_name,
	privilege_type 
from
	information_schema.role_table_grants
where
	table_catalog = 'test_db';
```
- список пользователей с правами над таблицами test_db

**Ответ:**
```
- postgres
- test_admin_user
- test_simple_user
```





## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
- приведите в ответе:
    - запросы 
    - результаты их выполнения.

**Ответ:**

```
insert into orders(order_name, price) values ('Шоколад', 10), ('Принтер', 3000), ('Книга', 500), ('Монитор', 7000), ('Гитара', 4000);

insert into clients(surname, country) values ('Иванов Иван Иванович', 'USA'), ('Петров Петр Петрович', 'Canada'), ('Иоганн Себастьян Бах', 'Japan'), ('Ронни Джеймс Дио', 'Russia'), ('Ritchie Blackmore', 'Russia');

select count(*) from orders;
|count|
|-----|
|5    |

select count(*) from clients;
|count|
|-----|
|5    |

```


## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.

**Ответ:**
```
update clients c set order_id = (select o.id from orders o where o.order_name = 'Книга')
where c.surname = 'Иванов Иван Иванович';

update clients c set order_id = (select o.id from orders o where o.order_name = 'Монитор')
where c.surname = 'Петров Петр Петрович';

update clients c set order_id = (select o.id from orders o where o.order_name = 'Гитара')
where c.surname = 'Иоганн Себастьян Бах';
```

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.

**Ответ:**
```
select * from clients where order_id is not null;

|id |surname             |country|order_id|
|---|--------------------|-------|--------|
|1  |Иванов Иван Иванович|USA    |3       |
|2  |Петров Петр Петрович|Canada |4       |
|3  |Иоганн Себастьян Бах|Japan  |5       |
```
 
Подсказк - используйте директиву `UPDATE`.

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.

**Ответ:**
```
explain
select * from clients where order_id is not null;

|QUERY PLAN                                            |
|------------------------------------------------------|
|Seq Scan on clients  (cost=0.00..1.05 rows=3 width=47)|
|  Filter: (order_id IS NOT NULL)                      |

```

План запроса показал:
- планировщик сделает последовательное чтение Seq Scan таблицы clients,
- внутри узла Seq Scan к каждой строке будет применен фильтр `order_id IS NOT NULL`,
- приблизительная стоимость запуска 0.00, 
- приблизительная общая стоимость 1.05,
- ожидаемое число строк 3,
- ожидаемый средний размер строк 47 байт.

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 

**Ответ:**

Создание бэкапа:
```shell
docker exec -it 62_postgres_1 bash -c "pg_dump test_db -Fc -U postgres -h localhost -p 5432 > /var/lib/postgresql/backup/test_db.dump"
```
Остановка старого контейнера с БД:
```shell
docker stop 62_postgres_1
```
Запуск нового контейнера с БД и подключение volume, в котором лежит бэкап:
```shell

docker run -d --rm --name postgres -p 5432:5432 -v 62_backup-volume:/var/lib/postgresql/backup -e POSTGRES_PASSWORD=secret postgres:12
```
Восстановление test_db из бэкапа:
```shell
docker exec -it postgres bash -c "pg_restore -C -d postgres -U postgres -h localhost -p 5432 /var/lib/postgresql/backup/test_db.dump"
```

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
