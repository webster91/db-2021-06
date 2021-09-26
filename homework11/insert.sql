
INSERT INTO BuildType (id, name, descr)
VALUES (default, 'Многоэтажная постройка', 'Жилое многоэтажное здание'),
       (default, 'Частный дом', 'Частный дом'),
       (default, 'Частный дом2', 'Частный дом'),
       (default, 'Частный дом3', 'Частный дом'),
       (default, 'Частный дом4', 'Частный дом'),
       (default, 'Частный дом5', 'Частный дом'),
       (default, 'Частный дом6', 'Частный дом'),
       (default, 'Частный дом7', 'Частный дом'),
       (default, 'Частный дом8', 'Частный дом'),
       (default, 'Частный дом9', 'Частный дом');


INSERT INTO City (id, name)
VALUES (default, 'Москва'),
       (default, 'Санкт-Петербург'),
       (default, 'Казань'),
       (default, 'Новосибирск'),
       (default, 'Екатеринбург'),
       (default, 'Нижний Новгород'),
       (default, 'Челябинск'),
       (default, 'Самара'),
       (default, 'Омск'),
       (default, 'Уфа'),
       (default, 'Красноярск'),
       (default, 'Воронеж'),
       (default, 'Казань');

INSERT INTO Build (id, typeid, cityid, street, house)
VALUES (default, 1, 1, 'Ленина', '1a'),
       (default, 1, 1, 'Ленина', '2'),
       (default, 1, 1, 'Ленина', '2w'),
       (default, 1, 1, 'Ленина', '3a'),
       (default, 1, 2, 'Ленина', '1'),
       (default, 1, 2, 'Социалистическая', '22'),
       (default, 2, 2, 'Социалистическая', '33a'),
       (default, 2, 2, 'Социалистическая', '33'),
       (default, 1, 3, 'Гагарина', '1'),
       (default, 1, 3, 'Гагарина', '2'),
       (default, 1, 3, 'Гагарина', '3');


INSERT INTO Address (buildId, flat, apartment)
VALUES (1, 1, '1'),
       (1, 1, '2'),
       (1, 1, '3'),
       (1, 2, '4'),
       (1, 2, '5'),
       (1, 2, '6')
;

INSERT INTO MeterType(id, name)
VALUES (1, 'тип 1'),
       (2, 'тип 2'),
       (31, 'тип 33'),
       (44, 'тип 44'),
       (65, 'тип 65'),
       (23, 'тип 66'),
       (34, 'тип 34'),
       (66, 'тип 66'),
       (33, 'тип 33'),
       (45, 'тип 45');

INSERT INTO Meter(id, name, typeId, addressId, value, valid, serialNumber)
VALUES (default, 'счётчик', 1, 1, 2022.5, true, '11231231'),
       (default, 'счётчик', 2, 1, 2022.5, true, '1323'),
       (default, 'счётчик', 65, 1, 2022.5, true, 'В424242'),

       (default, 'счётчик', 2, 2, 2022.5, true, '1555'),
       (default, 'счётчик', 65, 2, 2022.5, true, '122Б23'),

       (default, 'счётчик', 65, 3, 2022.5, true, '11<2>32'),
       (default, 'счётчик', 65, 3, 2022.5, true, '15345'),
       (default, 'счётчик', 33, 4, 2022.5, true, '14343'),
       (default, 'счётчик', 45, 4, 2022.5, true, '12323/233')
;

ALTER TABLE AddressStatistic PARTITION BY RANGE (id) (
    PARTITION p0 VALUES LESS THAN (1000),
    PARTITION p1 VALUES LESS THAN (2000),
    PARTITION p2 VALUES LESS THAN (3000),
    PARTITION p3 VALUES LESS THAN (4000),
    PARTITION p4 VALUES LESS THAN (5000),
    PARTITION p5 VALUES LESS THAN (6000),
    PARTITION p6 VALUES LESS THAN MAXVALUE
    );

INSERT INTO AddressStatistic(id, addressId)
VALUES (3210, 1112544),
       (2010, 1112544),
       (3410, 1112544),
       (25010, 1112544),
       (5010, 1112544),
       (1010, 1112544),
       (10, 1112544),
       (3010, 1112544),
       (2560, 1112544),
       (5610, 1112544),
       (6710, 1112544),
       (310, 1112544),
       (4010, 1112544),
       (110, 1112544),
       (8010, 1112544),
       (7010, 1112544),
       (6010, 1112544),
       (5032, 1112544);

SELECT p.PARTITION_NAME, p.TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS p
WHERE TABLE_NAME = 'AddressStatistic';

