# Домашнее задание к занятию "10.03. Grafana"

## Ответ

### Задание 1

Выполнил самостоятельное развертывание Node-exporter, Prometheus и Grafana.

Node-exporter запущен при помощи Systemd.

Файл юнита:
```
[Unit]
Description=Node Exporter
After=network.target

[Service]
EnvironmentFile=-/etc/default/node_exporter
ExecStart=/usr/local/bin/node_exporter $OPTS
Restart=on-failure
Type=simple

[Install]
WantedBy=multi-user.target
```

Вывод информации о процессе:
```shell
vagrant@server1:/vagrant/grafana$ service node_exporter status
● node_exporter.service - Node Exporter
     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
     Active: active (running) since Sat 2022-07-16 07:14:28 UTC; 4h 7min ago
   Main PID: 23811 (node_exporter)
      Tasks: 10 (limit: 9448)
     Memory: 11.6M
     CGroup: /system.slice/node_exporter.service
             └─23811 /usr/local/bin/node_exporter --collector.cpu.info --collector.systemd --collector.processes
```

Prometheus и Grafana развернуты при помощи Docker.

Файл docker-compose.yml:
```shell
version: '3'

services:

  grafana:
    image: grafana/grafana-oss:9.0.2
    container_name: grafana
    volumes:
      - grafana-storage:/var/lib/grafana
    network_mode: host
    expose:
      - 3000
    restart: unless-stopped

  prometheus:
    image: prom/prometheus:v2.36.2
    container_name: prometheus
    volumes:
      - ./prometheus:/etc/prometheus:ro
      - prometheus-storage:/prometheus
    network_mode: host
    expose:
      - 9090
    restart: unless-stopped

  alertmanager:
    image: prom/alertmanager:v0.24.0
    container_name: alertmanager
    volumes:
      - ./alertmanager/alertmanager.yml:/etc/alertmanager/alertmanager.yml:ro
    network_mode: host
    restart: unless-stopped
    expose:
      - 9093

volumes:
  grafana-storage: {}
  prometheus-storage: {}
```

Конфигурация Prometheus:
```
# my global config
global:
  scrape_interval: 15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
    - static_configs:
        - targets:
          - localhost:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  - "alert.rules.yml"
  - "alert.rules.load_average.yml"
  - "alert.rules.cpu_usage.yml"
  - "alert.rules.ram_usage.yml"
  - "alert.rules.disk_usage.yml"

scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: "local_metrics"
    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.
    static_configs:
      - targets: ["localhost:9090", "localhost:9100"]

```

### Задание 2

PromQL запросы:

- Утилизация CPU для nodeexporter (в процентах, 100-idle)

    + По каждому CPU:
  
    `100 * (1 - avg(irate(node_cpu_seconds_total{instance="localhost:9100",mode="idle"}[5m])) by (instance,cpu))`

    + По всем CPU среднее:

    `100 * (1 - avg(irate(node_cpu_seconds_total{instance="localhost:9100",mode="idle"}[5m])) by (instance))`

- CPULA 1/5/15

    + LA 1m

  `avg(node_load1{instance="localhost:9100"})*100 / count(count(node_cpu_seconds_total) by (cpu))`

    + LA 5m

    `avg(node_load5{instance="localhost:9100"})*100 / count(count(node_cpu_seconds_total) by (cpu))`

    + LA 15m
  
    `avg(node_load15{instance="localhost:9100"})*100 / count(count(node_cpu_seconds_total) by (cpu))`

- Количество свободной оперативной памяти

`node_memory_MemFree_bytes{instance="localhost:9100"}/(1024*1024)`

- Количество места на файловой системе

`node_filesystem_avail_bytes{instance="localhost:9100",fstype="ext4"}/(1024*1024*1024)`

Снимок экрана получившегося dashboard:
![](https://github.com/avloton/devops-netology/blob/main/homeWork/10.3/img/dashboard.png?raw=true)

### Задание 3

Настроил Alertmanager для оповещений в Telegram.

Файл конфигурации alertmanager.yml:
```
global:
route:
  receiver: Telegram
  group_by: [alertname, instance, severity]
  group_wait: 5s
  group_interval: 5s
  repeat_interval: 10m
  routes:
    - receiver: Telegram
      matchers:
        - instance = 'localhost:9100'
receivers:
  - name: Telegram
    telegram_configs:
      - send_resolved: true
        api_url: 'https://api.telegram.org'
        bot_token: XXXXXXXXX
        chat_id: -688949245 #Get chat_id from https://api.telegram.org/botXXXXX/getUpdates
        message: |
          *Severity*: {{ .GroupLabels.severity }}
          *Alert*: {{ .GroupLabels.alertname }}
          *Status*: {{ .Status }}
        disable_notifications: false
        parse_mode: "MarkdownV2"
```

В Prometheus настроил и подключил правила alert:

alert.rules.cpu_usage.yml:
```
groups:
- name: alert.rules.cpu_usage
  rules:
  - alert: High CPU usage
    expr: 100 * (1 - avg(irate(node_cpu_seconds_total{instance="localhost:9100",mode="idle"}[5m])) by (instance)) > 90
    for: 10s
    labels:
      severity: critical
    annotations:
      description: '{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 1 minute.'
      summary: 'Instance {{ $labels.instance }} down.'
```

alert.rules.disk_usage.yml:
```
groups:
- name: alert.rules.disk_space
  rules:
  - alert: Not enough free disk space
    expr: node_filesystem_avail_bytes{instance="localhost:9100",fstype="ext4"}/(1024*1024*1024) < 5
    for: 10s
    labels:
      severity: critical
    annotations:
      description: '{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 1 minute.'
      summary: 'Instance {{ $labels.instance }} down.'
```

alert.rules.load_average.yml:
```
groups:
- name: alert.rules.load_average
  rules:
  - alert: High Load Average
    expr: avg(node_load1{instance="localhost:9100"})*100 / count(count(node_cpu_seconds_total) by (cpu)) > 70
    for: 10s
    labels:
      severity: critical
    annotations:
      description: '{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 1 minute.'
      summary: 'Instance {{ $labels.instance }} down.'
```

alert.rules.ram_usage.yml:
```
groups:
- name: alert.rules.ram_usage
  rules:
  - alert: Not enough free RAM
    expr: node_memory_MemFree_bytes{instance="localhost:9100"}/(1024*1024) < 500
    for: 10s
    labels:
      severity: critical
    annotations:
      description: '{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 1 minute.'
      summary: 'Instance {{ $labels.instance }} down.'
```

Снимок экрана сообщений в Telegram из Alertmanager:
![](https://github.com/avloton/devops-netology/blob/main/homeWork/10.3/img/telegram.png?raw=true)

### Задание 4

Листинг dashboard в формате JSON:
```
{
  "annotations": {
    "list": [
      {
        "builtIn": 1,
        "datasource": {
          "type": "grafana",
          "uid": "-- Grafana --"
        },
        "enable": true,
        "hide": true,
        "iconColor": "rgba(0, 211, 255, 1)",
        "name": "Annotations & Alerts",
        "target": {
          "limit": 100,
          "matchAny": false,
          "tags": [],
          "type": "dashboard"
        },
        "type": "dashboard"
      }
    ]
  },
  "editable": true,
  "fiscalYearStartMonth": 0,
  "graphTooltip": 0,
  "id": 5,
  "links": [],
  "liveNow": false,
  "panels": [
    {
      "datasource": {
        "type": "prometheus",
        "uid": "msBjCP6nz"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "thresholds"
          },
          "decimals": 1,
          "mappings": [],
          "max": 100,
          "min": 0,
          "thresholds": {
            "mode": "percentage",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "percent"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 0,
        "y": 0
      },
      "id": 6,
      "options": {
        "orientation": "auto",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "showThresholdLabels": false,
        "showThresholdMarkers": true
      },
      "pluginVersion": "9.0.2",
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "msBjCP6nz"
          },
          "editorMode": "code",
          "expr": "avg(node_load1{instance=\"localhost:9100\"})*100 / count(count(node_cpu_seconds_total) by (cpu))",
          "legendFormat": "Load average (1m) ",
          "range": true,
          "refId": "A"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "msBjCP6nz"
          },
          "editorMode": "code",
          "expr": "avg(node_load5{instance=\"localhost:9100\"})*100 / count(count(node_cpu_seconds_total) by (cpu))",
          "hide": false,
          "legendFormat": "Load average (5m) ",
          "range": true,
          "refId": "B"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "msBjCP6nz"
          },
          "editorMode": "code",
          "expr": "avg(node_load15{instance=\"localhost:9100\"})*100 / count(count(node_cpu_seconds_total) by (cpu))",
          "hide": false,
          "legendFormat": "Load average (15m) ",
          "range": true,
          "refId": "C"
        }
      ],
      "title": "Load Average 1/5/15",
      "type": "gauge"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "msBjCP6nz"
      },
      "description": "",
      "fieldConfig": {
        "defaults": {
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          },
          "unit": "short"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 0
      },
      "id": 8,
      "options": {
        "colorMode": "value",
        "graphMode": "none",
        "justifyMode": "center",
        "orientation": "auto",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "textMode": "value"
      },
      "pluginVersion": "9.0.2",
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "msBjCP6nz"
          },
          "editorMode": "code",
          "exemplar": false,
          "expr": "node_filesystem_avail_bytes{instance=\"localhost:9100\",fstype=\"ext4\"}/(1024*1024*1024)",
          "format": "time_series",
          "instant": false,
          "legendFormat": "__auto",
          "range": true,
          "refId": "A"
        }
      ],
      "title": "Free disk space in gigabytes",
      "type": "stat"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "msBjCP6nz"
      },
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "drawStyle": "line",
            "fillOpacity": 0,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "lineInterpolation": "linear",
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 0,
        "y": 8
      },
      "id": 4,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "list",
          "placement": "bottom"
        },
        "tooltip": {
          "mode": "single",
          "sort": "none"
        }
      },
      "pluginVersion": "9.0.2",
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "msBjCP6nz"
          },
          "editorMode": "code",
          "expr": "100 * (1 - avg(irate(node_cpu_seconds_total{instance=\"localhost:9100\",mode=\"idle\"}[5m])) by (instance,cpu))",
          "legendFormat": "cpu {{cpu}}",
          "range": true,
          "refId": "A"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "msBjCP6nz"
          },
          "editorMode": "code",
          "expr": "100 * (1 - avg(irate(node_cpu_seconds_total{instance=\"localhost:9100\",mode=\"idle\"}[5m])) by (instance))",
          "hide": false,
          "legendFormat": "avg",
          "range": true,
          "refId": "B"
        }
      ],
      "title": "CPU usage",
      "type": "timeseries"
    },
    {
      "datasource": {
        "type": "prometheus",
        "uid": "msBjCP6nz"
      },
      "fieldConfig": {
        "defaults": {
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              }
            ]
          },
          "unit": "none"
        },
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 8
      },
      "id": 10,
      "options": {
        "colorMode": "value",
        "graphMode": "none",
        "justifyMode": "auto",
        "orientation": "auto",
        "reduceOptions": {
          "calcs": [
            "lastNotNull"
          ],
          "fields": "",
          "values": false
        },
        "text": {},
        "textMode": "auto"
      },
      "pluginVersion": "9.0.2",
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "msBjCP6nz"
          },
          "editorMode": "code",
          "expr": "node_memory_MemFree_bytes{instance=\"localhost:9100\"}/(1024*1024)",
          "legendFormat": "__auto",
          "range": true,
          "refId": "A"
        }
      ],
      "title": "Free RAM in megabytes",
      "type": "stat"
    }
  ],
  "refresh": "5s",
  "schemaVersion": 36,
  "style": "dark",
  "tags": [],
  "templating": {
    "list": []
  },
  "time": {
    "from": "now-5m",
    "to": "now"
  },
  "timepicker": {},
  "timezone": "",
  "title": "My dashboard",
  "uid": "K65qyzg4z",
  "version": 12,
  "weekStart": ""
}
```