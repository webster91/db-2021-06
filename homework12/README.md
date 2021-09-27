# Домашнее задание №12

SQL выборка

## Цель:

Научиться джойнить таблицы и использовать условия в SQL выборке

1) Напишите запрос по своей базе с inner join
2) Напишите запрос по своей базе с left join
3) Напишите 5 запросов с WHERE с использованием разных операторов, опишите для чего вам в проекте нужна такая выборка
   данных

### Напишите запрос по своей базе с inner join

````
SELECT C.name, B.street, B.house, BT.name
FROM Build AS B
         INNER JOIN BuildType AS BT
                   ON B.typeId = BT.id
         INNER JOIN City AS C
                   ON B.cityId = C.id;
````

### Напишите запрос по своей базе с left join

````
SELECT C.name, B.street, B.house, BT.name
FROM Build AS B
         LEFT JOIN BuildType AS BT
                   ON B.typeId = BT.id
         LEFT JOIN City AS C
                   ON B.cityId = C.id;
````

### Напишите 5 запросов с WHERE с использованием разных операторов, опишите для чего вам в проекте нужна такая выборка данных

Запрос на получение всех строений у которых площадь больше 50

````
SELECT * FROM Address
WHERE apartmentSquaring > 50;
````

Запрос на получение всех строений в Казани

````
SELECT C.name, B.street, B.house
FROM Build AS B
         LEFT JOIN City AS C
                   ON B.cityId = C.id
WHERE C.name = 'Казань';
````

Запрос на обновление номера дома на 32 у записи с id = 4

```
UPDATE entity.Build
SET house = '32'
WHERE id = 4;
```

Запрос удаление всех невалидных счётчиков

```
DELETE FROM Meter
WHERE Meter.valid;
```

Запрос на получение всех счётчиков у которых значение больше 0

```
SELECT M.id, A.userId, M.value, MT.name
FROM Meter AS M
         LEFT JOIN MeterType AS MT
                   ON M.typeId = MT.id
         LEFT JOIN Address AS A
                   ON M.addressId = A.id
WHERE M.value > 0;
```