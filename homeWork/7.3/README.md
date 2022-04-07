# Домашнее задание к занятию "7.3. Основы и принцип работы Терраформ"

## Задача 1. Создадим бэкэнд в S3 (необязательно, но крайне желательно).

Если в рамках предыдущего задания у вас уже есть аккаунт AWS, то давайте продолжим знакомство со взаимодействием
терраформа и aws. 

1. Создайте s3 бакет, iam роль и пользователя от которого будет работать терраформ. Можно создать отдельного пользователя,
а можно использовать созданного в рамках предыдущего задания, просто добавьте ему необходимы права, как описано 
[здесь](https://www.terraform.io/docs/backends/types/s3.html).
2. Зарегистрируйте бэкэнд в терраформ проекте как описано по ссылке выше. 

**Ответ:** Создан s3 bucket на базе Yandex Cloud.


## Задача 2. Инициализируем проект и создаем воркспейсы. 

1. Выполните `terraform init`:
    * если был создан бэкэнд в S3, то терраформ создат файл стейтов в S3 и запись в таблице 
dynamodb.
    * иначе будет создан локальный файл со стейтами.  
1. Создайте два воркспейса `stage` и `prod`.
1. В уже созданный `aws_instance` добавьте зависимость типа инстанса от вокспейса, что бы в разных ворскспейсах 
использовались разные `instance_type`.
1. Добавим `count`. Для `stage` должен создаться один экземпляр `ec2`, а для `prod` два. 
1. Создайте рядом еще один `aws_instance`, но теперь определите их количество при помощи `for_each`, а не `count`.
1. Что бы при изменении типа инстанса не возникло ситуации, когда не будет ни одного инстанса добавьте параметр
жизненного цикла `create_before_destroy = true` в один из рессурсов `aws_instance`.
1. При желании поэкспериментируйте с другими параметрами и рессурсами.

В виде результата работы пришлите:
* Вывод команды `terraform workspace list`.
* Вывод команды `terraform plan` для воркспейса `prod`.  

**Ответ:**
```shell
anatol@WIN-QLVHA9MV1CM:/mnt/c/Users/Anatol/devops-netology/homeWork/7.3/src/terraform$ terraform workspace list
  default
  prod
* stage
```

```shell
anatol@WIN-QLVHA9MV1CM:/mnt/c/Users/Anatol/devops-netology/homeWork/7.3/src/terraform$ terraform workspace select prod
anatol@WIN-QLVHA9MV1CM:/mnt/c/Users/Anatol/devops-netology/homeWork/7.3/src/terraform$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.vm-1[0] will be created
  + resource "yandex_compute_instance" "vm-1" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC4yhL7UgUxDrLmATxTfZuU6S93fOBYxdA1cq7RkvXtt3brdDvwxEObp/uJTit3yfGjqZm8EwfIDxD9ZZrqpXVk/EM4Q0EWMAul58NFULMGxS7KKDIpZp3JgX7hq80iSel3GKIV+mJtX92T2GreRCTngRUuBp9RNxiQaNHmmyqE2OqYT3zZ43vdsvO80vfLlyiHrJ/p1lfY7EAVOI+pmnzNHRKkIwCuh2Qhc0vazTVly9Dlw2O4SAE1celZ0tfz4Kt81NIXaWplExdGa2f2c1cKNTtyhoy5qFXiS5s9J4CjGa6lEzRT3ZDH6IFoBrEOsHTUjFOpHYD8G2pcXqPkCfZw3obmXyMT+CYC58JC9o+nms2oRwJlIqdqwEyqj6O2ErMvj/VJWhdPFHMafmAs8I7y7SJd1TMVMUiyVM0VFpuGW98ZCr4jIW1Mq+Y+JYTQY4Ygf6kz/DC1v00NeumHCUJTqrnEL4Ag9h98qED1UlnHhSjzTHflQFQi9o/DPZ4vMhU= anatol@WIN-QLVHA9MV1CM
            EOT
        }
      + name                      = "terraform1"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd807ed79a4kkqfvd1mb"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + placement_group_id = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 4
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.vm-1[1] will be created
  + resource "yandex_compute_instance" "vm-1" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC4yhL7UgUxDrLmATxTfZuU6S93fOBYxdA1cq7RkvXtt3brdDvwxEObp/uJTit3yfGjqZm8EwfIDxD9ZZrqpXVk/EM4Q0EWMAul58NFULMGxS7KKDIpZp3JgX7hq80iSel3GKIV+mJtX92T2GreRCTngRUuBp9RNxiQaNHmmyqE2OqYT3zZ43vdsvO80vfLlyiHrJ/p1lfY7EAVOI+pmnzNHRKkIwCuh2Qhc0vazTVly9Dlw2O4SAE1celZ0tfz4Kt81NIXaWplExdGa2f2c1cKNTtyhoy5qFXiS5s9J4CjGa6lEzRT3ZDH6IFoBrEOsHTUjFOpHYD8G2pcXqPkCfZw3obmXyMT+CYC58JC9o+nms2oRwJlIqdqwEyqj6O2ErMvj/VJWhdPFHMafmAs8I7y7SJd1TMVMUiyVM0VFpuGW98ZCr4jIW1Mq+Y+JYTQY4Ygf6kz/DC1v00NeumHCUJTqrnEL4Ag9h98qED1UlnHhSjzTHflQFQi9o/DPZ4vMhU= anatol@WIN-QLVHA9MV1CM
            EOT
        }
      + name                      = "terraform1"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd807ed79a4kkqfvd1mb"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + placement_group_id = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 4
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.vm-2["Server-1"] will be created
  + resource "yandex_compute_instance" "vm-2" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC4yhL7UgUxDrLmATxTfZuU6S93fOBYxdA1cq7RkvXtt3brdDvwxEObp/uJTit3yfGjqZm8EwfIDxD9ZZrqpXVk/EM4Q0EWMAul58NFULMGxS7KKDIpZp3JgX7hq80iSel3GKIV+mJtX92T2GreRCTngRUuBp9RNxiQaNHmmyqE2OqYT3zZ43vdsvO80vfLlyiHrJ/p1lfY7EAVOI+pmnzNHRKkIwCuh2Qhc0vazTVly9Dlw2O4SAE1celZ0tfz4Kt81NIXaWplExdGa2f2c1cKNTtyhoy5qFXiS5s9J4CjGa6lEzRT3ZDH6IFoBrEOsHTUjFOpHYD8G2pcXqPkCfZw3obmXyMT+CYC58JC9o+nms2oRwJlIqdqwEyqj6O2ErMvj/VJWhdPFHMafmAs8I7y7SJd1TMVMUiyVM0VFpuGW98ZCr4jIW1Mq+Y+JYTQY4Ygf6kz/DC1v00NeumHCUJTqrnEL4Ag9h98qED1UlnHhSjzTHflQFQi9o/DPZ4vMhU= anatol@WIN-QLVHA9MV1CM
            EOT
        }
      + name                      = "terraform2-Server-1"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd807ed79a4kkqfvd1mb"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + placement_group_id = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 4
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.vm-2["Server-2"] will be created
  + resource "yandex_compute_instance" "vm-2" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC4yhL7UgUxDrLmATxTfZuU6S93fOBYxdA1cq7RkvXtt3brdDvwxEObp/uJTit3yfGjqZm8EwfIDxD9ZZrqpXVk/EM4Q0EWMAul58NFULMGxS7KKDIpZp3JgX7hq80iSel3GKIV+mJtX92T2GreRCTngRUuBp9RNxiQaNHmmyqE2OqYT3zZ43vdsvO80vfLlyiHrJ/p1lfY7EAVOI+pmnzNHRKkIwCuh2Qhc0vazTVly9Dlw2O4SAE1celZ0tfz4Kt81NIXaWplExdGa2f2c1cKNTtyhoy5qFXiS5s9J4CjGa6lEzRT3ZDH6IFoBrEOsHTUjFOpHYD8G2pcXqPkCfZw3obmXyMT+CYC58JC9o+nms2oRwJlIqdqwEyqj6O2ErMvj/VJWhdPFHMafmAs8I7y7SJd1TMVMUiyVM0VFpuGW98ZCr4jIW1Mq+Y+JYTQY4Ygf6kz/DC1v00NeumHCUJTqrnEL4Ag9h98qED1UlnHhSjzTHflQFQi9o/DPZ4vMhU= anatol@WIN-QLVHA9MV1CM
            EOT
        }
      + name                      = "terraform2-Server-2"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd807ed79a4kkqfvd1mb"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + placement_group_id = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 4
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_vpc_network.network-1 will be created
  + resource "yandex_vpc_network" "network-1" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "network1"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_subnet.subnet-1 will be created
  + resource "yandex_vpc_subnet" "subnet-1" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet1"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "192.168.10.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

Plan: 6 to add, 0 to change, 0 to destroy.

────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```



---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
