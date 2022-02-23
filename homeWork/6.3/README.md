# Домашнее задание к занятию "6.3. MySQL"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/tree/master/additional/README.md).

## Задача 1

Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-03-mysql/test_data) и 
восстановитесь из него.

Перейдите в управляющую консоль `mysql` внутри контейнера.

Используя команду `\h` получите список управляющих команд.

Найдите команду для выдачи статуса БД и **приведите в ответе** из ее вывода версию сервера БД.

**Ответ:**
```shell
mysql> status
--------------
mysql  Ver 8.0.28 for Linux on x86_64 (MySQL Community Server - GPL)
```

Подключитесь к восстановленной БД и получите список таблиц из этой БД.

**Приведите в ответе** количество записей с `price` > 300.

**Ответ:**
```shell
mysql> select count(*) from orders where price > 300;
+----------+
| count(*) |
+----------+
|        1 |
+----------+
1 row in set (0.00 sec)
```

В следующих заданиях мы будем продолжать работу с данным контейнером.

## Задача 2

Создайте пользователя test в БД c паролем test-pass, используя:
- плагин авторизации mysql_native_password
- срок истечения пароля - 180 дней 
- количество попыток авторизации - 3 
- максимальное количество запросов в час - 100
- аттрибуты пользователя:
    - Фамилия "Pretty"
    - Имя "James"

Предоставьте привелегии пользователю `test` на операции SELECT базы `test_db`.
    
Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю `test` и 
**приведите в ответе к задаче**.


**Ответ:**
```shell
mysql> create user test identified with mysql_native_password by 'test-pass'
    -> with MAX_QUERIES_PER_HOUR 100
    -> password expire interval 180 day
    -> failed_login_attempts 3
    -> attribute '{"fname": "Pretty", "lname": "James"}';
Query OK, 0 rows affected (0.01 sec)

mysql> grant select on test_db.* to test;
Query OK, 0 rows affected (0.01 sec)

mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES where user = 'test';
+------+------+---------------------------------------+
| USER | HOST | ATTRIBUTE                             |
+------+------+---------------------------------------+
| test | %    | {"fname": "Pretty", "lname": "James"} |
+------+------+---------------------------------------+
1 row in set (0.00 sec)
```

## Задача 3

Установите профилирование `SET profiling = 1`.
Изучите вывод профилирования команд `SHOW PROFILES;`.

**Ответ:**
```shell
mysql> set profiling = 1;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> show profiles;
+----------+------------+--------------------------------------------------------------------------------------+
| Query_ID | Duration   | Query                                                                                |
+----------+------------+--------------------------------------------------------------------------------------+
|        1 | 0.00047975 | SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES where user = 'test'                 |
|        2 | 0.00026450 | select * from orders                                                                 |
|        3 | 0.00041100 | select * from orders where price > 300                                               |
```

Исследуйте, какой `engine` используется в таблице БД `test_db` и **приведите в ответе**.

**Ответ:**
```shell
mysql> SELECT TABLE_NAME, ENGINE FROM information_schema.TABLES where TABLE_NAME = 'orders';
+------------+--------+
| TABLE_NAME | ENGINE |
+------------+--------+
| orders     | InnoDB |
+------------+--------+
1 row in set (0.00 sec)
```

Измените `engine` и **приведите время выполнения и запрос на изменения из профайлера в ответе**:
- на `MyISAM`
- на `InnoDB`

**Ответ:**
```shell
mysql> show profiles;
+----------+------------+-----------------------------------------------------------+
| Query_ID | Duration   | Query                                                     |
+----------+------------+-----------------------------------------------------------+
|        1 | 0.05627325 | alter table orders engine = MyISAM                        |
|        2 | 0.00478450 | insert into orders (title, price) values ('Book', '200')  |
|        3 | 0.07331350 | alter table orders engine = InnoDB                        |
|        4 | 0.01211875 | insert into orders (title, price) values ('Paper', '100') |
+----------+------------+-----------------------------------------------------------+
4 rows in set, 1 warning (0.00 sec)
```

## Задача 4 

Изучите файл `my.cnf` в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):
- Скорость IO важнее сохранности данных
- Нужна компрессия таблиц для экономии места на диске
- Размер буффера с незакомиченными транзакциями 1 Мб
- Буффер кеширования 30% от ОЗУ
- Размер файла логов операций 100 Мб

Приведите в ответе измененный файл `my.cnf`.

**Ответ:**
```shell
[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
secure-file-priv= NULL

innodb_flush_method = O_DSYNC
innodb_flush_log_at_trx_commit = 2
innodb_buffer_pool_size = 300M
innodb_file_per_table = 1
innodb_log_buffer_size = 1M
innodb_log_file_size = 100M
```

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---