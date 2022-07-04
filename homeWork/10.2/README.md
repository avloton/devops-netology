# Домашнее задание к занятию "10.02. Системы мониторинга"

## Обязательные задания

1. Опишите основные плюсы и минусы pull и push систем мониторинга.

#### Ответ

#### Pull система

- Плюсы:
  - В Pull системе централизованная конфигурация, что упрощает сопровождение.
  - В Pull системе легче контролировать подлинность данных, так как мы сами контролируем с каких узлов собирать данные.

- Минусы
  - В Pull системе вся нагрузка ложится на центральный хост, который опрашивает узлы.
  - В Pull системе, если опрашиваемый узел находится за NAT или firewall, то доступ к нему может быть затруднен.

#### Push система

- Плюсы
  - В Push системе, если агент находится за NAT или firewall, то отправка данных в систему мониторинга достаточно проста.
  - В Push системе нагрузка по сбору метрик ложится на агенты, что снижает нагрузку с системы мониторинга.

- Минусы
  - В Push системе отказ агента может привести к потере данных, что снижает надежность.
  - В Push системе настройка сбора метрик децентрализована, что усложняет сопровождение.

---

2. Какие из ниже перечисленных систем относятся к push модели, а какие к pull? А может есть гибридные?

    - Prometheus
    - TICK
    - Zabbix
    - VictoriaMetrics
    - Nagios

#### Ответ

#### Pull
- Prometheus
- Nagios

#### Push
- TICK

#### Гибридные
- Zabbix
- VictoriaMetrics

---

3. Склонируйте себе [репозиторий](https://github.com/influxdata/sandbox/tree/master) и запустите TICK-стэк,
   используя технологии docker и docker-compose.

В виде решения на это упражнение приведите выводы команд с вашего компьютера (виртуальной машины):

    - curl http://localhost:8086/ping
    - curl http://localhost:8888
    - curl http://localhost:9092/kapacitor/v1/ping

А также скриншот веб-интерфейса ПО chronograf (`http://localhost:8888`).

P.S.: если при запуске некоторые контейнеры будут падать с ошибкой - проставьте им режим `Z`, например
`./data:/var/lib:Z`


#### Ответ

```shell
vagrant@server1:~/sandbox$ curl -sl -I http://localhost:8086/ping
HTTP/1.1 204 No Content
Content-Type: application/json
Request-Id: 713bd554-fa39-11ec-8035-0242ac150003
X-Influxdb-Build: OSS
X-Influxdb-Version: 1.8.10
X-Request-Id: 713bd554-fa39-11ec-8035-0242ac150003
Date: Sat, 02 Jul 2022 19:01:56 GMT

vagrant@server1:~/sandbox$ curl -sl -I http://localhost:8888
HTTP/1.1 200 OK
Accept-Ranges: bytes
Cache-Control: public, max-age=3600
Content-Length: 336
Content-Security-Policy: script-src 'self'; object-src 'self'
Content-Type: text/html; charset=utf-8
Etag: "3362220244"
Last-Modified: Tue, 22 Mar 2022 20:02:44 GMT
Vary: Accept-Encoding
X-Chronograf-Version: 1.9.4
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Xss-Protection: 1; mode=block
Date: Sat, 02 Jul 2022 19:02:24 GMT

vagrant@server1:~/sandbox$ curl -sl -I http://localhost:9092/kapacitor/v1/ping
HTTP/1.1 204 No Content
Content-Type: application/json; charset=utf-8
Request-Id: 9235c429-fa39-11ec-8039-000000000000
X-Kapacitor-Version: 1.6.4
Date: Sat, 02 Jul 2022 19:02:51 GMT
```
---

4. Перейдите в веб-интерфейс Chronograf (`http://localhost:8888`) и откройте вкладку `Data explorer`.

    - Нажмите на кнопку `Add a query`
    - Изучите вывод интерфейса и выберите БД `telegraf.autogen`
    - В `measurments` выберите mem->host->telegraf_container_id , а в `fields` выберите used_percent.
      Внизу появится график утилизации оперативной памяти в контейнере telegraf.
    - Вверху вы можете увидеть запрос, аналогичный SQL-синтаксису.
      Поэкспериментируйте с запросом, попробуйте изменить группировку и интервал наблюдений.

Для выполнения задания приведите скриншот с отображением метрик утилизации места на диске
(disk->host->telegraf_container_id) из веб-интерфейса.

#### Ответ

---

5. Изучите список [telegraf inputs](https://github.com/influxdata/telegraf/tree/master/plugins/inputs).
   Добавьте в конфигурацию telegraf следующий плагин - [docker](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/docker):
```
[[inputs.docker]]
  endpoint = "unix:///var/run/docker.sock"
```

Дополнительно вам может потребоваться донастройка контейнера telegraf в `docker-compose.yml` дополнительного volume и
режима privileged:
```
  telegraf:
    image: telegraf:1.4.0
    privileged: true
    volumes:
      - ./etc/telegraf.conf:/etc/telegraf/telegraf.conf:Z
      - /var/run/docker.sock:/var/run/docker.sock:Z
    links:
      - influxdb
    ports:
      - "8092:8092/udp"
      - "8094:8094"
      - "8125:8125/udp"
```

После настройке перезапустите telegraf, обновите веб интерфейс и приведите скриншотом список `measurments` в
веб-интерфейсе базы telegraf.autogen . Там должны появиться метрики, связанные с docker.

#### Ответ

Факультативно можете изучить какие метрики собирает telegraf после выполнения данного задания.

---
### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

