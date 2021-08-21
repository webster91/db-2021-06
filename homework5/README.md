# Домашнее задание

DML в PostgreSQL

## Цель:

Написать запрос с конструкциями SELECT, JOIN Написать запрос с добавлением данных INSERT INTO Написать запрос с
обновлением данных с UPDATE FROM Использовать using для оператора DELETE

* Напишите запрос по своей базе с регулярным выражением, добавьте пояснение, что вы хотите найти.
* Напишите запрос по своей базе с использованием LEFT JOIN и INNER JOIN, как порядок соединений в FROM влияет на
  результат? Почему?
* Напишите запрос на добавление данных с выводом информации о добавленных строках.
* Напишите запрос с обновлением данные используя UPDATE FROM.
* Напишите запрос для удаления данных с оператором DELETE используя join с другой таблицей с помощью using.
    * Приведите пример использования утилиты COPY (по желанию)

### Напишите запрос по своей базе с регулярным выражением, добавьте пояснение, что вы хотите найти.

Запрос на нахождение всех домов, где указали буквы английского алфавита, вместо русского

```
SELECT house
FROM entity.Build
WHERE house ~* '[a-z]$';
```

### Напишите запрос по своей базе с использованием LEFT JOIN и INNER JOIN, как порядок соединений в FROM влияет на результат? Почему?

Запрос на поиск всех строений. Порядок JOIN никак не влияет на выборку. Для соединения LEFT JOIN нет никакой разницы
порядок присоединения

```
SELECT C.name, B.street, B.house, BT.name
FROM entity.Build AS B
         LEFT JOIN type.BuildType AS BT
                   ON B.typeId = BT.id
         LEFT JOIN type.City AS C
                   ON B.cityId = C.id
```

## Напишите запрос на добавление данных с выводом информации о добавленных строках.

Запрос добавления строения с возвратом его id

```
INSERT INTO entity.Build (id, typeid, cityid, street, house)
VALUES (default, 1, 1, 'Ленина', '1б')
RETURNING id;
```

## Напишите запрос с обновлением данные используя UPDATE FROM

Запрос на обновление номера дома у записи с id = 4

```
UPDATE entity.Build
SET house = '32'
WHERE id = 4;
```

## Напишите запрос для удаления данных с оператором DELETE используя join с другой таблицей с помощью using.

Запрос на удаление всех строений находящихся в Казани

```
DELETE FROM entity.Build AS B
    USING type.City AS C
WHERE B.cityId = C.id and C.name = 'Казань';
```

## Приведите пример использования утилиты COPY (по желанию)

```
COPY (
    SELECT C.name, B.street, B.house, BT.name
    FROM entity.Build AS B
             LEFT JOIN type.BuildType AS BT
                       ON B.typeId = BT.id
             LEFT JOIN type.City AS C
                       ON B.cityId = C.id
    )
    TO '/build.csv'
    WITH CSV;
```