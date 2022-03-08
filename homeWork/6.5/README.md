# Домашнее задание к занятию "6.5. Elasticsearch"

## Задача 1

В этом задании вы потренируетесь в:
- установке elasticsearch
- первоначальном конфигурировании elastcisearch
- запуске elasticsearch в docker

Используя докер образ [centos:7](https://hub.docker.com/_/centos) как базовый и 
[документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html):

- составьте Dockerfile-манифест для elasticsearch
- соберите docker-образ и сделайте `push` в ваш docker.io репозиторий
- запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины

Требования к `elasticsearch.yml`:
- данные `path` должны сохраняться в `/var/lib`
- имя ноды должно быть `netology_test`

В ответе приведите:
- текст Dockerfile манифеста
- ссылку на образ в репозитории dockerhub
- ответ `elasticsearch` на запрос пути `/` в json виде

Подсказки:
- возможно вам понадобится установка пакета perl-Digest-SHA для корректной работы пакета shasum
- при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml
- при некоторых проблемах вам поможет docker директива ulimit
- elasticsearch в логах обычно описывает проблему и пути ее решения

Далее мы будем работать с данным экземпляром elasticsearch.

**Ответ:**

- текст Dockerfile
```shell
vagrant@server1:/vagrant/hw/6.5$ cat Dockerfile
FROM    centos:7

ENV     DIR=/opt/elasticsearch/
ENV     USER=elastic

RUN     useradd -d $DIR -m -s /bin/bash $USER && \
        mkdir /var/lib/data && \
        chown $USER. /var/lib/data && \
        yum -y install wget && \
        cd $DIR && \
        wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.0.1-linux-x86_64.tar.gz && \
        tar -zxvf elasticsearch-8.0.1-linux-x86_64.tar.gz && \
        echo "node.name: netology_test" >> elasticsearch-8.0.1/config/elasticsearch.yml && \
        echo "path.data: /var/lib/data" >> elasticsearch-8.0.1/config/elasticsearch.yml && \
        chown -R $USER. $DIR/elasticsearch-8.0.1 && \
        rm -f elasticsearch-8.0.1-linux-x86_64.tar.gz

WORKDIR $DIR/elasticsearch-8.0.1

USER    elastic

EXPOSE 9200/tcp
EXPOSE 9300/tcp

ENTRYPOINT ["./bin/elasticsearch"]
```
- ссылка на образ

https://hub.docker.com/repository/docker/avloton/elasticsearch-netology

- ответ elasticsearch на запрос по пути /
```shell
vagrant@server1:/vagrant/hw/6.5$ curl -k -u elastic:SqcHKDi5jgJIwa8P2J+w https://localhost:9200
{
  "name" : "netology_test",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "g2XuyXCmRoaJFzT0UCKW2Q",
  "version" : {
    "number" : "8.0.1",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "801d9ccc7c2ee0f2cb121bbe22ab5af77a902372",
    "build_date" : "2022-02-24T13:55:40.601285296Z",
    "build_snapshot" : false,
    "lucene_version" : "9.0.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}
```

## Задача 2

В этом задании вы научитесь:
- создавать и удалять индексы
- изучать состояние кластера
- обосновывать причину деградации доступности данных

Ознакомтесь с [документацией](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) 
и добавьте в `elasticsearch` 3 индекса, в соответствии со таблицей:

| Имя | Количество реплик | Количество шард |
|-----|-------------------|-----------------|
| ind-1| 0 | 1 |
| ind-2 | 1 | 2 |
| ind-3 | 2 | 4 |

Получите список индексов и их статусов, используя API и **приведите в ответе** на задание.

**Ответ:**
```shell
vagrant@server1:~$ curl -k -u elastic:SqcHKDi5jgJIwa8P2J+w https://localhost:9200/_cat/indices
green  open ind-1 cT2lv0UgTNmqQ8Z0g45B5Q 1 0 0 0 225b 225b
yellow open ind-3 h4nuyyoZRemQTj77kWcn7A 4 2 0 0 900b 900b
yellow open ind-2 SoS8xhjDQTeRDu8UiBqxpw 2 1 0 0 450b 450b
```

Получите состояние кластера `elasticsearch`, используя API.

**Ответ:**
```shell
vagrant@server1:~$ curl -s -k -u elastic:SqcHKDi5jgJIwa8P2J+w https://localhost:9200/_cluster/health | jq
{
  "cluster_name": "elasticsearch",
  "status": "yellow",
  "timed_out": false,
  "number_of_nodes": 1,
  "number_of_data_nodes": 1,
  "active_primary_shards": 9,
  "active_shards": 9,
  "relocating_shards": 0,
  "initializing_shards": 0,
  "unassigned_shards": 10,
  "delayed_unassigned_shards": 0,
  "number_of_pending_tasks": 0,
  "number_of_in_flight_fetch": 0,
  "task_max_waiting_in_queue_millis": 0,
  "active_shards_percent_as_number": 47.368421052631575
}
```

Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

**Ответ:**
Часть индексов и кластер находятся в состоянии yellow, так как присутствуют неназначенные шарды (unassigned_shards).
Причина появления неназначенных шардов в том, что индексы ind-2 и ind-3 требуют наличия дополнительных реплик, 
но у нас поднята только одна нода elasticsearch.


Удалите все индексы.

**Важно**

При проектировании кластера elasticsearch нужно корректно рассчитывать количество реплик и шард,
иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.

## Задача 3

В данном задании вы научитесь:
- создавать бэкапы данных
- восстанавливать индексы из бэкапов

Создайте директорию `{путь до корневой директории с elasticsearch в образе}/snapshots`.

Используя API [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository) 
данную директорию как `snapshot repository` c именем `netology_backup`.

**Приведите в ответе** запрос API и результат вызова API для создания репозитория.

**Ответ:**
```shell
vagrant@server1:/vagrant$ curl -k -X PUT -u elastic:SqcHKDi5jgJIwa8P2J+w https://localhost:9200/_snapshot/netology_backup -H 'Content-type: application/json' -d '  
{
"type": "fs",
"settings": {
  "location": "/opt/elasticsearch/snapshots/netology_backup"
}
}'
{"acknowledged":true}
```

Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.

**Ответ:**
```shell
vagrant@server1:/vagrant$ curl -k -X PUT -u elastic:SqcHKDi5jgJIwa8P2J+w https://localhost:9200/test -H 'Content-type: application/json' -d '
{
"settings": {
  "index": {
    "number_of_shards": 1,
    "number_of_replicas": 0 }}}
'
{"acknowledged":true,"shards_acknowledged":true,"index":"test"}

vagrant@server1:/vagrant$ curl -k -u elastic:SqcHKDi5jgJIwa8P2J+w https://localhost:9200/_cat/indices
green open test sFLnYbPSS9K-egzxPF_sTw 1 0 0 0 225b 225b
```

[Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html) 
состояния кластера `elasticsearch`.

**Приведите в ответе** список файлов в директории со `snapshot`ами.

**Ответ:**
```shell
vagrant@server1:/vagrant$ curl -k -X PUT -u elastic:SqcHKDi5jgJIwa8P2J+w https://localhost:9200/_snapshot/netology_backup/snapshot_1
{"accepted":true}

[elastic@d1322171a0ec elasticsearch]$ ls -l /opt/elasticsearch/snapshots/netology_backup/
total 36
-rw-r--r-- 1 elastic elastic  1095 Mar  8 16:48 index-0
-rw-r--r-- 1 elastic elastic     8 Mar  8 16:48 index.latest
drwxr-xr-x 5 elastic elastic  4096 Mar  8 16:48 indices
-rw-r--r-- 1 elastic elastic 17700 Mar  8 16:48 meta-cEHccgvDTjewYIO23WHzpQ.dat
-rw-r--r-- 1 elastic elastic   389 Mar  8 16:48 snap-cEHccgvDTjewYIO23WHzpQ.dat
```

Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.

**Ответ:**
```shell
vagrant@server1:/vagrant$ curl -k -u elastic:SqcHKDi5jgJIwa8P2J+w https://localhost:9200/_cat/indices
green open test-2 e3TV0AvOQbCA18Hf8GeXxw 1 0 0 0 225b 225b
```

[Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние
кластера `elasticsearch` из `snapshot`, созданного ранее. 

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.

**Ответ:**
```shell
vagrant@server1:/vagrant$ curl -k -X POST -u elastic:SqcHKDi5jgJIwa8P2J+w https://localhost:9200/_snapshot/netology_backup/snapshot_1/_restore
{"accepted":true}

vagrant@server1:/vagrant$ curl -k -u elastic:SqcHKDi5jgJIwa8P2J+w https://localhost:9200/_cat/indices
green open test-2 e3TV0AvOQbCA18Hf8GeXxw 1 0 0 0 225b 225b
green open test   8QTLNEU-QYSjjIpdZATUOw 1 0 0 0 225b 225b
```

Подсказки:
- возможно вам понадобится доработать `elasticsearch.yml` в части директивы `path.repo` и перезапустить `elasticsearch`

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
