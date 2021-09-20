INSERT INTO BuildType (id, name, descr)
VALUES (DEFAULT, 'Многоэтажная постройка', 'Жилое многоэтажное здание'),
       (DEFAULT, 'Частный дом', 'Частный дом'),
       (DEFAULT, 'Частный дом2', 'Частный дом'),
       (DEFAULT, 'Частный дом3', 'Частный дом'),
       (DEFAULT, 'Частный дом4', 'Частный дом'),
       (DEFAULT, 'Частный дом5', 'Частный дом'),
       (DEFAULT, 'Частный дом6', 'Частный дом'),
       (DEFAULT, 'Частный дом7', 'Частный дом'),
       (DEFAULT, 'Частный дом8', 'Частный дом'),
       (DEFAULT, 'Частный дом9', 'Частный дом');


INSERT INTO City (id, name)
VALUES (DEFAULT, 'Москва'),
       (DEFAULT, 'Санкт-Петербург'),
       (DEFAULT, 'Казань'),
       (DEFAULT, 'Новосибирск'),
       (DEFAULT, 'Екатеринбург'),
       (DEFAULT, 'Нижний Новгород'),
       (DEFAULT, 'Челябинск'),
       (DEFAULT, 'Самара'),
       (DEFAULT, 'Омск'),
       (DEFAULT, 'Уфа'),
       (DEFAULT, 'Красноярск'),
       (DEFAULT, 'Воронеж'),
       (DEFAULT, 'Казань');

INSERT INTO Build (id, typeid, cityid, street, house)
VALUES (DEFAULT, 1, 1, 'Ленина', '1a'),
       (DEFAULT, 1, 1, 'Ленина', '2'),
       (DEFAULT, 1, 1, 'Ленина', '2w'),
       (DEFAULT, 1, 1, 'Ленина', '3a'),
       (DEFAULT, 1, 2, 'Ленина', '1'),
       (DEFAULT, 1, 2, 'Социалистическая', '22'),
       (DEFAULT, 2, 2, 'Социалистическая', '33a'),
       (DEFAULT, 2, 2, 'Социалистическая', '33'),
       (DEFAULT, 1, 3, 'Гагарина', '1'),
       (DEFAULT, 1, 3, 'Гагарина', '2'),
       (DEFAULT, 1, 3, 'Гагарина', '3');