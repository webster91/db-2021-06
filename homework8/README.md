# Домашнее задание №8

Делаем физическую и логическую репликации

## Цель:

После домашнего задания вы сможете настраивать физическую и логическую репликации самостоятельно

* Физическая репликация: Весь стенд собирается в Docker образах. Необходимо:

* Настроить физическую репликации между двумя кластерами базы данных
* Репликация должна работать использую "слот репликации"
* Реплика должна отставать от мастера на 5 минут

Логическая репликация: В стенд добавить еще один кластер Postgresql. Необходимо:

* Создать на первом кластере базу данных, таблицу и наполнить ее данными (на ваше усмотрение)
* На нем же создать публикацию этой таблицы
* На новом кластере подписаться на эту публикацию
* Убедиться что она среплицировалась. Добавить записи в эту таблицу на основном сервере и убедиться, что они видны на
  логической реплике

## Установка сервера postgres

```
docker run --rm --name postgres1 -e POSTGRES_PASSWORD=qwe -d -p 5432:5432 postgres
docker exec -it postgres1 bash
```

## Устанавливаем nano для изменения конфигов

```
apt-get update
apt-get -y install nano
```

## Для мастера изменяем конфиги в файлах

```
su postgres

nano /var/lib/postgresql/data/postgresql.conf
listen_addresses = '*'
wal_level = replica

nano /var/lib/postgresql/data/pg_hba.conf
host    all             all             0.0.0.0/0            trust
host    replication     all             0.0.0.0/0            trust
```

## Создаём базу

```
psql
CREATE DATABASE replica;
CREATE TABLE test(i int);
INSERT INTO test values(10);

SELECT pg_create_physical_replication_slot('main');
SELECT pg_reload_conf();
```

## Создадим реплику

```
docker run --name postgres2 -e POSTGRES_PASSWORD=qwe -d -p 5433:5432 postgres
docker exec -it postgres2 bash
```

## Настраиваем реплику

```
apt-get update
apt-get -y install nano
pg_createcluster -d /var/lib/postgresql/13/main2 13 main2
service postgresql stop
rm -rf /var/lib/postgresql/13/main2/*
su postgres
pg_basebackup -h 127.0.0.1 -p 5432 -U postgres -D /var/lib/postgresql/13/main2 -Fp -Xs -P -R -W

nano /var/lib/postgresql/13/main2/postgresql.conf
primary_slot_name = 'main'
hot_standby = on
recovery_min_apply_delay = 300s

pg_ctlcluster 13 main2 start
```