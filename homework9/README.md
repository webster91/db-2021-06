# Домашнее задание №9

Создаем базу данных в докере

## Цель:

Упаковка скриптов создания БД в контейнер

* забрать стартовый репозиторий https://github.com/aeuge/otus-mysql-docker
* прописать sql скрипт для создания своей БД в init.sql
* проверить запуск и работу контейнера следую описанию в репозитории
* прописать кастомный конфиг - настроить innodb_buffer_pool и другие параметры по желанию * протестить сисбенчем -
  результат теста приложить в README

# Создаем базу данных в докере


Поднять сервис mydb можно командой:

````
docker-compose up --remove-orphans -d mydb 
````

Для подключения к БД используйте команду:

````
docker-compose exec mydb mysql -u root -p12345 hestia
````

Для использования в клиентских приложениях можно использовать команду:

````
docker-compose exec mydb bash
````

Установка и запуск sysbench:

````
echo "deb http://deb.debian.org/debian buster-backports main" >> /etc/apt/sources.list
apt-get update
apt-get -t buster-backports install sysbench
````

Подготовка и запуск sysbench:

````
sysbench --mysql-host=localhost --mysql-user=root --mysql-password='12345' --db-driver=mysql --mysql-db=hestia /usr/share/sysbench/oltp_read_write.lua prepare
sysbench --mysql-host=localhost --mysql-user=root --mysql-password='12345' --db-driver=mysql --mysql-db=hestia /usr/share/sysbench/oltp_read_write.lua run
````

Статистика

````
SQL statistics:
queries performed:
read:                            11438
write:                           3268
other:                           1634
total:                           16340
transactions:                        817    (81.62 per sec.)
queries:                             16340  (1632.34 per sec.)
ignored errors:                      0      (0.00 per sec.)
reconnects:                          0      (0.00 per sec.)

General statistics:
total time:                          10.0091s
total number of events:              817

Latency (ms):
min:                                    6.57
avg:                                   12.25
max:                                  285.00
95th percentile:                       16.71
sum:                                10005.69

Threads fairness:
events (avg/stddev):           817.0000/0.00
execution time (avg/stddev):   10.0057/0.00
````