
# Домашнее задание к занятию "5.3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"

---

## Задача 1

Сценарий выполения задачи:

- создайте свой репозиторий на https://hub.docker.com;
- выберете любой образ, который содержит веб-сервер Nginx;
- создайте свой fork образа;
- реализуйте функциональность:
запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```
Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

**Ответ:** https://hub.docker.com/repository/docker/avloton/nginx-netology

## Задача 2

Посмотрите на сценарий ниже и ответьте на вопрос:
"Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

- Высоконагруженное монолитное java веб-приложение;

**Ответ:** В данном случае нет причин выделять отдельный физический сервер или виртуальную машину для приложения. Самое оптимальное будет запустить в контейнере, который обеспечит безопасность за счет изоляции и переносимость приложения.

- Nodejs веб-приложение;

**Ответ:** Аналогично, лучше запустить в контейнере. Нет преимуществ, если запустить на выделенном сервере или в виртуальной машине.

- Мобильное приложение c версиями для Android и iOS;

**Ответ:** Потребуется физическое устройство с Android/iOS или виртуальная машина, которая будет эмулировать данные устройства. 

- Шина данных на базе Apache Kafka;

**Ответ:** Лучше запустить в контейнере. Нет преимуществ, если запустить на выделенном сервере или в виртуальной машине.

- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;

**Ответ:** Каждую ноду и приложения можно запустить в отдельных контейнерах, которые будут взаимодействовать между собой. В данном случае запуск в контейнерах даст высокую переносимость, возможность быстрого развертывания дополнительных нод, более оптимальное использование ресурсов.

- Мониторинг-стек на базе Prometheus и Grafana;

**Ответ:** Аналогично, лучше всего запустить в отдельных контейнерах. Нет преимуществ, если запустить на выделенном сервере или в виртуальной машине. 

- MongoDB, как основное хранилище данных для java-приложения;

**Ответ:** Аналогично, лучше запустить в контейнере. Нет преимуществ, если запустить на выделенном сервере или в виртуальной машине.

- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.

**Ответ:** Есть возможность запустить Gitlab сервер в контейнере. Но потребуется настраивать внутри контейнера супервизор как главный процесс, который будет управлять корректным запуском/остановкой других связанных процессов.
Хотя, если Gitlab является высоконагруженным, то лучше выделить для него отдельные физические сервера или виртуальные машины, при этом БД вынести на отдельный сервер.
Docker Registry лучше запустить в своем отдельном контейнере, так как нет приемуществ при его запуске на выделенном сервере.

## Задача 3

- Запустите первый контейнер из образа ***centos*** c любым тэгом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```;
- Добавьте еще один файл в папку ```/data``` на хостовой машине;
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.

**Ответ:**
```shell
vagrant@server1:~$ mkdir data
vagrant@server1:~$ docker run --rm --name centos -d -v /home/vagrant/data:/data centos:latest sleep infinity
67b99b1b14e34b09d523a5efed7885ca3731e27bba425437d91f2be81025f8d5
vagrant@server1:~$ docker run --rm --name debian -d -v /home/vagrant/data:/data debian:latest sleep infinity
9528144ac4cfe9ab7a9f68b1dc8f942c56859eebb45c83719ee55b33290b5994
vagrant@server1:~$ docker exec centos /bin/bash -c "echo test > /data/testfile1"
vagrant@server1:~$ echo test > data/testfile2
vagrant@server1:~$ docker exec debian /bin/bash -c "ls -l /data/"
total 8
-rw-r--r-- 1 root root 5 Feb  2 16:30 testfile1
-rw-rw-r-- 1 1000 1000 5 Feb  2 16:31 testfile2
vagrant@server1:~$ docker exec debian /bin/bash -c "cat /data/testfile1"
test
vagrant@server1:~$ docker exec debian /bin/bash -c "cat /data/testfile2"
test
```

## Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

Соберите Docker образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.

**Ответ:**
https://hub.docker.com/repository/docker/avloton/ansible