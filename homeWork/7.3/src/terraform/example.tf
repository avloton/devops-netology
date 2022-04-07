terraform {
  required_providers {
    yandex = {
      source = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "terraform-tutorial2"
    region     = "ru-central1-a"
    key        = "terraform/homeWork/7.3"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  cloud_id  = "b1gr44d4i93lihefk8bs"
  folder_id = "b1goj6apkc57lq3tc4cf"
  zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "vm-1" {
  name = "terraform1"
  count = local.count_map[terraform.workspace]
  resources {
    cores  = local.core_map[terraform.workspace]
    memory = local.memory_map[terraform.workspace]
  }
  boot_disk {
    initialize_params {
      image_id = "fd807ed79a4kkqfvd1mb"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  lifecycle {
    create_before_destroy = true

  }

}

locals {
  memory_map = {
    stage = 2
    prod = 4
  }
  core_map = {
    stage = 2
    prod = 4
  }
  count_map = {
    stage = 1
    prod = 2
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}